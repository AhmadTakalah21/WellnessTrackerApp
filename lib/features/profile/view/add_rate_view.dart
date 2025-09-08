import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/profile/cubit/profile_cubit.dart';
import 'package:wellnesstrackerapp/global/models/rating_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

abstract class AddRateViewCallBacks {
  void onSelectRate(int index);
  void onSubmitTap();
}

@RoutePage()
class AddRateView extends StatelessWidget {
  const AddRateView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddRatePage();
  }
}

class AddRatePage extends StatefulWidget {
  const AddRatePage({super.key});

  @override
  State<AddRatePage> createState() => _Ratingfeaturestate();
}

class _Ratingfeaturestate extends State<AddRatePage>
    implements AddRateViewCallBacks {
  late final ProfileCubit profileCubit = context.read();
  int selectedRate = 1;

  @override
  void onSelectRate(int index) {
    setState(() {
      selectedRate = index - 1;
    });
    profileCubit.setRating(index);
  }

  @override
  void onSubmitTap() => profileCubit.addRating();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("rate_us".tr())),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            spacing: 20,
            children: [
              SizedBox(height: 10),
              ratingContent(),
              _buildSubmitButton()
            ],
          ),
        ));
  }

  Widget ratingContent() {
    return Container(
      padding: const EdgeInsets.all(10 * 2.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: context.cs.surface,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(color: AppColors.black.withOpacity(0.2), blurRadius: 6.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "what_u_think".tr(),
            style: context.tt.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "feedback_help".tr(),
            style: context.tt.bodyMedium
                ?.copyWith(color: context.cs.onSecondaryFixed),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                RatingEnum.values.length,
                (index) {
                  final rate = RatingEnum.values[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10 / 2),
                    child: GestureDetector(
                        onTap: () => onSelectRate(rate.id),
                        child: Icon(
                          Icons.star,
                          color: selectedRate >= index
                              ? Color(0xFFFFC107)
                              : Color(0xFFD9D9D9),
                          size: 30.0,
                        )),
                  );
                },
              )),
          SizedBox(height: 30),
          Container(
            height: 100.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: context.cs.surface,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: AppColors.black.withOpacity(0.2), blurRadius: 6.0),
              ],
            ),
            child: TextField(
              //onChanged: onChanged,
              onChanged: profileCubit.setComment,
              textAlignVertical: TextAlignVertical.top,
              expands: true,
              minLines: null,
              maxLines: null,
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: context.cs.primary,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "enter_note".tr(),
                hintStyle: TextStyle(
                  color: context.cs.onSecondaryFixed,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<ProfileCubit, GeneralProfileState>(
      buildWhen: (previous, current) => current is AddRatingState,
      listener: (context, state) {
        if (state is AddRatingSuccess) {
          context.router.pop();
          MainSnackBar.showSuccessMessage(context, state.message);
        } else if (state is AddRatingFail) {
          MainSnackBar.showErrorMessage(context, state.error);
        }
      },
      builder: (context, state) {
        return MainActionButton(
          onTap: onSubmitTap,
          text: "submit".tr(),
          isLoading: state is AddRatingLoading,
        );
      },
    );
  }
}
