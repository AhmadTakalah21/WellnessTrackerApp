import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/features/items/view/widgets/add_item_view.dart';
import 'package:wellnesstrackerapp/features/items/view/widgets/buy_item_dialog.dart';
import 'package:wellnesstrackerapp/features/items/view/widgets/item_tile.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class ItemsViewCallBacks {
  void onTryAgainTap();
  Future<void> onRefresh();
  void onAddTap();
  bool onNotification(ScrollNotification scrollInfo);
  void showBuyDialog(ItemModel item);
  void onBuyTap(ItemModel item);
  void onTap(ItemModel item);
  void onEditTap(ItemModel item);
  void onDeleteTap(ItemModel item);
}

@RoutePage()
class ItemsView extends StatelessWidget {
  const ItemsView({super.key, required this.role, this.level});
  final UserRoleEnum role;
  final LevelModel? level;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          get<ItemsCubit>()..getItems(role, levelId: level?.id),
      child: ItemsPage(role: role, level: level),
    );
  }
}

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key, required this.role, this.level});

  final UserRoleEnum role;
  final LevelModel? level;

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> implements ItemsViewCallBacks {
  late final ItemsCubit itemsCubit = context.read();

  @override
  bool onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      itemsCubit.getItems(widget.role, levelId: widget.level?.id);
    }
    return true;
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => itemsCubit.getItems(
        widget.role,
        isLoadMore: false,
        levelId: widget.level?.id,
      );

  @override
  void onBuyTap(ItemModel item) => itemsCubit.buyItem(item.id);

  @override
  void onAddTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemView(
          itemCubit: itemsCubit,
          level: widget.level,
          onSuccess: onTryAgainTap,
        ),
      ),
    );
  }

  @override
  void onDeleteTap(ItemModel item) {
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
          item: item,
          onSuccess: () {
            Navigator.pop(context);
            onTryAgainTap();
          }),
    );
  }

  @override
  void onEditTap(ItemModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemView(
          itemCubit: itemsCubit,
          item: item,
          level: widget.level,
          onSuccess: onTryAgainTap,
        ),
      ),
    );
  }

  @override
  void onTap(ItemModel item) {
    if (widget.role.isAdmin) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
        builder: (context) => AdditionalOptionsBottomSheet(
          item: item,
          onEditTap: onEditTap,
          onDeleteTap: onDeleteTap,
        ),
      );
    } else if (widget.role.isUser) {
      if (item.link == null) {
        showBuyDialog(item);
      } else {
        _openExternal(item.link!);
      }
    }
  }

  Future<void> _openExternal(String url) async {
    final ok =
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('cannot_open_link'.tr())),
      );
    }
  }

  @override
  void showBuyDialog(ItemModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return BuyItemDialog(
          itemsCubit: itemsCubit,
          item: item,
          onTap: onBuyTap,
          onSuccess: onTryAgainTap,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.role;
    return Scaffold(
      appBar: AppBar(title: Text('items'.tr())),
      body: BlocBuilder<ItemsCubit, GeneralItemsState>(
        buildWhen: (previous, current) => current is ItemsState,
        builder: (context, state) {
          if (state is ItemsLoading) {
            return LoadingIndicator();
          } else if (state is ItemsSuccess) {
            return NotificationListener<ScrollNotification>(
              onNotification: onNotification,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: onRefresh,
                      child: GridView.builder(
                        padding: AppConstants.padding8,
                        physics: BouncingScrollPhysics(),
                        itemCount: state.items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.75),
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return ItemTile(item: item, role: role, onTap: onTap);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: widget.role.isUser ? 100 : 40)
                ],
              ),
            );
          } else if (state is ItemsEmpty) {
            return MainErrorWidget(
              error: state.message,
              onTryAgainTap: onTryAgainTap,
              isRefresh: true,
            );
          } else if (state is ItemsFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: widget.role == UserRoleEnum.admin
          ? Padding(
              padding: AppConstants.padding8,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: AppConstants.borderRadiusCircle,
                ),
                onPressed: onAddTap,
                child: Icon(Icons.add, color: context.cs.secondary, size: 30),
              ),
            )
          : null,
    );
  }
}
