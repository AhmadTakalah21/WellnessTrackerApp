import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
    // TODO : remove this jsut untile there is a user account
    final List<ItemModel> staticData = List.generate(
      10,
      (index) => ItemModel(
        id: index + 1,
        name: "Item name ${index + 1}",
        price: 1000 + ((index + 1) * 300),
        description: "description for item ${index + 1}",
        image: "image",
      ),
    );
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
          } else if (state is ItemsFail) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: NotificationListener<ScrollNotification>(
                onNotification: onNotification,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: AppConstants.padding16,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ...state.items.map(
                        //   (item) {
                        //     return _buildCardItem(item);
                        //   },
                        // ),
                        ...staticData.map(
                          (item) {
                            return _buildCardItem(item);
                          },
                        ),
                      ],
                    ),
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
          }
          // else if (state is ItemsFail) {
          //   return MainErrorWidget(
          //     error: state.error,
          //     onTryAgainTap: onTryAgainTap,
          //   );
          // }
          else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildCardItem(ItemModel item) {
    return Badge(
      offset: Offset(20, 30),
      backgroundColor: Colors.white,
      label: Icon(Icons.lock),
      child: Card(
        margin: AppConstants.paddingV10,
        child: Padding(
          padding: AppConstants.padding30,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: 1000 / item.price,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation(context.cs.primary),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        item.price.toStringAsFixed(0),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "نقطة",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppImageWidget(
                    width: 70,
                    height: 70,
                    url: item.image,
                    borderRadius: AppConstants.borderRadiusCircle,
                    border: Border.all(width: 0.5),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: context.tt.titleLarge,
                      ),
                      SizedBox(height: 5),
                      Text(
                        item.description,
                        style: context.tt.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
