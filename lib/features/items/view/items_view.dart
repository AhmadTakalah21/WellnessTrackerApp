import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/features/items/view/widgets/add_item_view.dart';
import 'package:wellnesstrackerapp/features/items/view/widgets/item_tile.dart';
import 'package:wellnesstrackerapp/global/blocs/delete_cubit/cubit/delete_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class ItemsViewCallBacks {
  void onTryAgainTap();
  Future<void> onRefresh();
  void onAddTap();
  bool onNotification(ScrollNotification scrollInfo);
  void showBuyDialog(ItemModel item);
  void onTap(ItemModel item);
  void onEditTap(ItemModel item);
  void onDeleteTap(ItemModel item);
}

@RoutePage()
class ItemsView extends StatelessWidget {
  const ItemsView({super.key, required this.role, this.levelId});
  final UserRoleEnum role;
  final int? levelId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              get<ItemsCubit>()..getItems(role, levelId: levelId),
        ),
        BlocProvider(create: (context) => get<DeleteCubit>()),
      ],
      child: ItemsPage(role: role, levelId: levelId),
    );
  }
}

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key, required this.role, this.levelId});

  final UserRoleEnum role;
  final int? levelId;

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> implements ItemsViewCallBacks {
  late final ItemsCubit itemsCubit = context.read();
  late final DeleteCubit deleteCubit = context.read();

  @override
  bool onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      itemsCubit.getItems(widget.role, levelId: widget.levelId);
    }
    return true;
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => itemsCubit.getItems(widget.role,
      isLoadMore: false, levelId: widget.levelId);

  @override
  void onAddTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddItemView(
          itemCubit: itemsCubit,
          isEdit: false,
          onSuccess: () =>
              itemsCubit.getItems(widget.role, levelId: widget.levelId),
        ),
      ),
    );
  }

  @override
  void onDeleteTap(ItemModel item) {
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
        deleteCubit: deleteCubit,
        item: item,
        onSaveTap: (c) => deleteCubit.deleteItem<ItemModel>(item),
        onSuccess: () =>
            itemsCubit.getItems(widget.role, levelId: widget.levelId),
      ),
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
          isEdit: true,
          onSuccess: () =>
              itemsCubit.getItems(widget.role, levelId: widget.levelId),
        ),
      ),
    );
  }

  @override
  void onTap(ItemModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Row(
        children: [
          Expanded(
            child: Padding(
              padding: AppConstants.padding16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "additional_options".tr(),
                      style: context.tt.headlineMedium,
                    ),
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.edit),
                    onPressed: () => onEditTap(item),
                    label: Text(
                      "edit".tr(),
                      style: context.tt.labelMedium?.copyWith(
                        color: context.cs.primary,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.delete, color: context.cs.error),
                    onPressed: () => onDeleteTap(item),
                    label: Text(
                      "delete".tr(),
                      style: context.tt.labelMedium?.copyWith(
                        color: context.cs.error,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void showBuyDialog(ItemModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  context.cs.primary.withOpacity(0.9),
                  context.cs.primary.withOpacity(0.75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_cart_checkout,
                    size: 48, color: Colors.white),
                const SizedBox(height: 16),
                Text(
                  "شراء العنصر",
                  style: context.tt.titleLarge?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "هل ترغب بشراء '${item.name}' مقابل",
                  style: context.tt.bodyLarge?.copyWith(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  "${item.price.toInt()} نقطة",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.amberAccent,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "إلغاء",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 3,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("تم شراء ${item.name}!"),
                              backgroundColor: context.cs.primary,
                            ),
                          );
                        },
                        child: Text(
                          "شراء",
                          style: TextStyle(
                            color: context.cs.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final role = widget.role;
    final onItem = role.isUser
        ? showBuyDialog
        : role.isAdmin
            ? onTap
            : (item) {};
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('store'.tr(), style: context.tt.titleLarge),
      ),
      body: BlocBuilder<ItemsCubit, GeneralItemsState>(
        buildWhen: (previous, current) => current is ItemsState,
        builder: (context, state) {
          if (state is ItemsLoading) {
            return LoadingIndicator();
          } else if (state is ItemsSuccess) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: NotificationListener<ScrollNotification>(
                onNotification: onNotification,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: AppConstants.padding8,
                        physics: BouncingScrollPhysics(),
                        itemCount: state.items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.8),
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return ItemTile(
                            item: item,
                            role: role,
                            onTap: onItem,
                          );
                        },
                      ),
                    )
                  ],
                ),
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
