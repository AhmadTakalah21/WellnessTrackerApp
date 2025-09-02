import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/models/gender_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_counter_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_date_picker.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class CompleteProfileFormViewCallBacks {
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
  late final AuthCubit authCubit = context.read();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authCubit.setInitialFormData();
  }

  @override
  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      authCubit.addInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("complete_information".tr())),
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
                    selectedValue: GenderEnum.male,
                    items: GenderEnum.values,
                    prefixIcon: Icons.person,
                    hintText: 'gender'.tr(),
                    labelText: 'gender'.tr(),
                    errorMessage: 'required_field'.tr(),
                    onChanged: authCubit.setGender,
                  ),
                  MainDatePicker(
                    onDateSelected: (date) =>
                        authCubit.setBirthday(date?.formatYYYYMMDD),
                    label: "birth_date",
                    hintText: "select_birth_date",
                    validator: (date) =>
                        date == null ? 'required_field'.tr() : null,
                  ),
                  MainCounterWidget(
                    maxCount: 200,
                    minCount: 30,
                    initialCount: 50,
                    onChanged: authCubit.setWeight,
                    label: 'weight'.tr(),
                    icon: Icons.monitor_weight,
                  ),
                  MainCounterWidget(
                    maxCount: 220,
                    minCount: 120,
                    initialCount: 160,
                    onChanged: authCubit.setLength,
                    label: 'length'.tr(),
                    icon: Icons.height,
                  ),
                  MainTextField2(
                    onChanged: authCubit.setChronicDiseases,
                    icon: Icons.healing,
                    label: 'chronic_diseases'.tr(),
                    // validator: (val) => val == null || val.isEmpty
                    //     ? 'required_field'.tr()
                    //     : null,
                  ),
                  MainCounterWidget(
                    maxCount: 100,
                    //minCount: 10,
                    onChanged: authCubit.setWaistCircumference,
                    label: 'waist_circumference'.tr(),
                    icon: Icons.line_weight,
                    isRequired: false,
                  ),
                  MainCounterWidget(
                    maxCount: 100,
                    //minCount: 20,
                    onChanged: authCubit.setChest,
                    label: 'chest'.tr(),
                    icon: Icons.accessibility_new,
                    isRequired: false,
                  ),
                  MainCounterWidget(
                    maxCount: 100,
                    //minCount: 10,
                    onChanged: authCubit.setShoulder,
                    label: 'shoulder'.tr(),
                    icon: Icons.accessibility,
                    isRequired: false,
                  ),
                  MainCounterWidget(
                    maxCount: 100,
                    //minCount: 10,
                    onChanged: authCubit.setThighCircumference,
                    label: 'thigh_circumference'.tr(),
                    icon: Icons.directions_walk,
                    isRequired: false,
                  ),
                  MainCounterWidget(
                    maxCount: 100,
                    //minCount: 10,
                    onChanged: authCubit.setForearmCircumference,
                    label: 'forearm_circumference'.tr(),
                    icon: Icons.pan_tool,
                    isRequired: false,
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
                      child = LoadingIndicator(
                        size: 30,
                        color: context.cs.surface,
                      );
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
