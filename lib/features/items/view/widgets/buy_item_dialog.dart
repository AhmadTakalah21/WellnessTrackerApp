import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellnesstrackerapp/features/items/cubit/items_cubit.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

class BuyItemDialog extends StatelessWidget {
  const BuyItemDialog({
    super.key,
    required this.itemsCubit,
    required this.item,
    required this.onTap,
    this.onSuccess,
  });
  final ItemsCubit itemsCubit;
  final ItemModel item;
  final void Function(ItemModel item) onTap;
  final void Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: itemsCubit,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
              Icon(Icons.shopping_cart_checkout, size: 48, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                "شراء العنصر",
                style: context.tt.titleLarge?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "هل ترغب بشراء ${item.name.en} مقابل",
                style: context.tt.bodyLarge?.copyWith(color: Colors.white),
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
                    child: MainActionButton(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(16),
                      buttonColor: context.cs.surface.withOpacity(0.15),
                      text: "cancel".tr(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                      child: BlocConsumer<ItemsCubit, GeneralItemsState>(
                    buildWhen: (previous, current) => current is BuyItemState,
                    listener: (context, state) {
                      if (state is BuyItemSuccess) {
                        Navigator.pop(context);
                        onSuccess?.call();
                        MainSnackBar.showSuccessMessage(context, state.message);
                      } else if (state is BuyItemFail) {
                        MainSnackBar.showErrorMessage(context, state.error);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is BuyItemLoading;
                      var onTap = (item) => this.onTap(item);
                      if (isLoading) {
                        onTap = (item) {};
                      }
                      return MainActionButton(
                        onTap: () => onTap(item),
                        borderRadius: BorderRadius.circular(16),
                        buttonColor: context.cs.surface,
                        textColor: context.cs.primary,
                        text: "buy".tr(),
                        child:
                            isLoading ? LoadingIndicator(isInBtn: true) : null,
                      );
                    },
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
