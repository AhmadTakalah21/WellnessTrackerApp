import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_counter_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class UpdateCustomerInfoViewCallBacks {
  void onSubmit();
}

@RoutePage()
class UpdateCustomerInfoView extends StatelessWidget {
  const UpdateCustomerInfoView({
    super.key,
    required this.customersCubit,
    required this.customer,
    required this.role,
  });
  final CustomersCubit customersCubit;
  final UserRoleEnum role;
  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: customersCubit,
      child: UpdateCustomerInfoPage(customer: customer, role: role),
    );
  }
}

class UpdateCustomerInfoPage extends StatefulWidget {
  const UpdateCustomerInfoPage({
    super.key,
    required this.customer,
    required this.role,
  });
  final UserRoleEnum role;
  final CustomerModel customer;

  @override
  State<UpdateCustomerInfoPage> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<UpdateCustomerInfoPage>
    implements UpdateCustomerInfoViewCallBacks {
  late final CustomersCubit customersCubit = context.read();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    customersCubit.setInitailCustomerInfo(widget.customer.info!);
  }

  @override
  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      customersCubit.updateCustomerInfo(widget.role, widget.customer.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = widget.customer.info;
    return Scaffold(
      appBar: AppBar(title: Text("update_information".tr())),
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
                  const SizedBox(height: 10),
                  MainCounterWidget(
                    initialCount: info?.age,
                    maxCount: 150,
                    minCount: 12,
                    onChanged: customersCubit.setAge,
                    label: 'age'.tr(),
                    icon: Icons.calendar_today,
                  ),
                  MainCounterWidget(
                    initialCount: info?.weight,
                    maxCount: 200,
                    minCount: 30,
                    onChanged: customersCubit.setWeight,
                    label: 'weight'.tr(),
                    icon: Icons.monitor_weight,
                  ),
                  MainCounterWidget(
                    initialCount: info?.length,
                    maxCount: 220,
                    minCount: 120,
                    onChanged: customersCubit.setLength,
                    label: 'length'.tr(),
                    icon: Icons.height,
                  ),
                  MainTextField2(
                    initialText: info?.chronicDiseases,
                    onChanged: customersCubit.setChronicDiseases,
                    icon: Icons.healing,
                    label: 'chronic_diseases'.tr(),
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  MainCounterWidget(
                    initialCount: info?.waistCircumference,
                    maxCount: 100,
                    minCount: 10,
                    onChanged: customersCubit.setWaistCircumference,
                    label: 'waist_circumference'.tr(),
                    icon: Icons.line_weight,
                  ),
                  MainCounterWidget(
                    initialCount: info?.chest,
                    maxCount: 100,
                    minCount: 20,
                    onChanged: customersCubit.setChest,
                    label: 'chest'.tr(),
                    icon: Icons.accessibility_new,
                  ),
                  MainCounterWidget(
                    initialCount: info?.shoulder,
                    maxCount: 100,
                    minCount: 10,
                    onChanged: customersCubit.setShoulder,
                    label: 'shoulder'.tr(),
                    icon: Icons.accessibility,
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
                BlocConsumer<CustomersCubit, GeneralCustomersState>(
                  listener: (context, state) {
                    if (state is UpdateCustomerInfoSuccess) {
                      context.router.pop();
                      customersCubit.getCustomers(widget.role);
                      MainSnackBar.showSuccessMessage(context, state.message);
                    } else if (state is UpdateCustomerInfoFail) {
                      MainSnackBar.showErrorMessage(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    var onTap = onSubmit;
                    Widget? child;
                    if (state is UpdateCustomerInfoLoading) {
                      onTap = () {};
                      child = const LoadingIndicator(isInBtn: true);
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
