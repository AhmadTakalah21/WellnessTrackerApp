import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class ItemsViewCallBacks {
  void onTryAgainTap();
  Future<void> onRefresh();
  bool onNotification(ScrollNotification scrollInfo);
}

@RoutePage()
class ItemsView extends StatelessWidget {
  const ItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<ItemsCubit>()..getItems(),
      child: const ItemsPage(),
    );
  }
}

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> implements ItemsViewCallBacks {
  late final ItemsCubit itemsCubit = context.read();

  @override
  bool onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      itemsCubit.getItems();
    }
    return true;
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => itemsCubit.getItems(isLoadMore: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('store'.tr(), style: context.tt.titleLarge),
      ),
      body: BlocBuilder<ItemsCubit, GeneralItemsState>(
        builder: (context, state) {
          if (state is ItemsLoading) {
            return LoadingIndicator();
          } else if (state is ItemsSuccess) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: NotificationListener<ScrollNotification>(
                onNotification: onNotification,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: AppConstants.padding16,
                  child: Column(
                    children: [
                      ...state.items.map(
                        (item) {
                          return _buildCardItem(item);
                        },
                      )
                    ],
                  ),
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
    );
  }

  Widget _buildCardItem(ItemModel item) {
    return Card(
      margin: AppConstants.paddingV10,
      child: Padding(
        padding: AppConstants.padding20,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImageWidget(
                  
                  width: 70,
                  height: 70,
                  url: item.image,
                  borderRadius: AppConstants.borderRadiusCircle,
                  border: Border.all(width: 0.5),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      item.name,
                      style: context.tt.titleMedium,
                    ),
                    SizedBox(height: 5),
                    Text(
                      item.description,
                      style: context.tt.bodyMedium,
                    ),
                    SizedBox(height: 5),
                    Text(
                      item.price.toStringAsFixed(0),
                      style: context.tt.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
