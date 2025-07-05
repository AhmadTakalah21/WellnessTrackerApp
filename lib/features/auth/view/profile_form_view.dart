import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/models/gender_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_date_picker.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class CompleteProfileFormViewCallBacks {
  void onGenderChanged(GenderEnum gender);
  void onBirthdayChanged(DateTime? birthday);
  void onAgeChanged(String age);
  void onWeightChanged(String weight);
  void onLengthChanged(String length);
  void onChronicDiseasesChanged(String chronicDiseases);
  void onWaistCircumferenceChanged(String waistCircumference);
  void onChestChanged(String chest);
  void onShoulderChanged(String shoulder);
  void onThighCircumferenceChanged(String thighCircumference);
  void onForearmCircumferenceChanged(String forearmCircumference);
  void onSubmit();
}

@RoutePage()
class CompleteProfileFormView extends StatelessWidget {
  const CompleteProfileFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<AuthCubit>(),
      child: const CompleteProfileFormPage(),
    );
  }
}

class CompleteProfileFormPage extends StatefulWidget {
  const CompleteProfileFormPage({super.key});

  @override
  State<CompleteProfileFormPage> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileFormPage>
    implements CompleteProfileFormViewCallBacks {
  //late final AuthManagerBloc authManagerBloc = context.read();
  late final AuthCubit authCubit = context.read();

  final _formKey = GlobalKey<FormState>();

  @override
  void onGenderChanged(GenderEnum? gender) => authCubit.setGender(gender);

  @override
  void onBirthdayChanged(DateTime? birthday) =>
      authCubit.setBirthday(birthday?.formatYYYYMMDD);

  @override
  void onAgeChanged(String age) => authCubit.setAge(age);

  @override
  void onWeightChanged(String weight) => authCubit.setWeight(weight);

  @override
  void onLengthChanged(String length) => authCubit.setLength(length);

  @override
  void onChronicDiseasesChanged(String chronicDiseases) =>
      authCubit.setChronicDiseases(chronicDiseases);

  @override
  void onWaistCircumferenceChanged(String waistCircumference) =>
      authCubit.setWaistCircumference(waistCircumference);

  @override
  void onChestChanged(String chest) => authCubit.setChest(chest);

  @override
  void onShoulderChanged(String shoulder) => authCubit.setShoulder(shoulder);

  @override
  void onThighCircumferenceChanged(String thighCircumference) =>
      authCubit.setThighCircumference(thighCircumference);

  @override
  void onForearmCircumferenceChanged(String forearmCircumference) =>
      authCubit.setForearmCircumference(forearmCircumference);

  @override
  void onSubmit() {
    //if (_formKey.currentState!.validate()) {
      authCubit.addInfo();
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('استكمال الملف الشخصي'),
        backgroundColor: context.cs.primary,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10,
                children: [
                  const Center(
                    child: Text(
                      'يرجى تعبئة البيانات التالية بدقة:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MainDropDownWidget(
                    items: GenderEnum.values,
                    prefixIcon: Icons.person,
                    hintText: 'gender'.tr(),
                    labelText: 'gender'.tr(),
                    errorMessage: 'required_field'.tr(),
                    onChanged: onGenderChanged,
                  ),
                  MainDatePicker(
                    onDateSelected: onBirthdayChanged,
                    validator: (date) =>
                        date == null ? 'required_field'.tr() : null,
                  ),
                  MainTextField2(
                    onChanged: onAgeChanged,
                    icon: Icons.calendar_today,
                    label: 'age'.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  MainTextField2(
                    onChanged: onWeightChanged,
                    icon: Icons.monitor_weight,
                    label: 'weight'.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  MainTextField2(
                    onChanged: onLengthChanged,
                    icon: Icons.height,
                    label: 'length'.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  MainTextField2(
                    onChanged: onChronicDiseasesChanged,
                    icon: Icons.healing,
                    label: 'chronic_diseases'.tr(),
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  MainTextField2(
                    onChanged: onWaistCircumferenceChanged,
                    icon: Icons.line_weight,
                    label: 'waist_circumference'.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  MainTextField2(
                    onChanged: onChestChanged,
                    icon: Icons.accessibility_new,
                    label: 'chest'.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  MainTextField2(
                    onChanged: onShoulderChanged,
                    icon: Icons.accessibility,
                    label: 'shoulder'.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  MainTextField2(
                    onChanged: onThighCircumferenceChanged,
                    icon: Icons.directions_walk,
                    label: 'thigh_circumference'.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  MainTextField2(
                    onChanged: onForearmCircumferenceChanged,
                    icon: Icons.pan_tool,
                    label: 'forearm_circumference'.tr(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
          Padding(
            padding: AppConstants.padding20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AddInfoSuccess) {
                      MainSnackBar.showSuccessMessage(context, state.message);
                    } else if (state is AddInfoFail) {
                      MainSnackBar.showErrorMessage(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    var onTap = onSubmit;
                    Widget? child;
                    if (state is AddInfoLoading) {
                      onTap = () {};
                      child = const LoadingIndicator(size: 30);
                    }
                    return MainActionButton(
                      text: 'save'.tr(),
                      onTap: onTap,
                      child: child,
                    );
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
