import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GridView.builder(
                        padding: AppConstants.padding8,
                        physics: BouncingScrollPhysics(),
                        itemCount: staticData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.8),
                        itemBuilder: (context, index) {
                          final item = staticData[index];
                          return _buildStageCard(item);
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

  Widget _buildStageCard(ItemModel item) {
    final userPoints = 1000;
    final progress = (userPoints / item.price).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: () => _showBuyDialog(item),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width / 2 - 24,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.cs.primary.withOpacity(0.9),
              context.cs.primary.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: context.cs.primary.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.lock_outline, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 6),
            CircularPercentIndicator(
              radius: 35,
              lineWidth: 5,
              percent: progress,
              animation: true,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.white,
              backgroundColor: Colors.white24,
              center: AppImageWidget(
                width: 40,
                height: 40,
                url: item.image,
                borderRadius: AppConstants.borderRadiusCircle,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.name,
              style: context.tt.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              item.description,
              style: context.tt.bodySmall?.copyWith(
                color: Colors.white70,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                "${item.price.toInt()} نقطة",
                style: GoogleFonts.poppins(
                  color: context.cs.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBuyDialog(ItemModel item) {
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
}
