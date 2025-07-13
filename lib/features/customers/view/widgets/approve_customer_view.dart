import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

class TitleValueModel {
  String title;
  String value;
  TitleValueModel(this.title, this.value);
}

abstract class ApproveCustomerViewCallBacks {
  void onDepartmentSelected(DepartmentEnum? department);
  void onEmployeeSelected(UserModel? employee);
  void onLevelSelected(LevelModel? level);
  void onCancelTap();
  void onSave();
  void onTryAgainTap();
}

@RoutePage()
class ApproveCustomerView extends StatelessWidget {
  const ApproveCustomerView({
    super.key,
    required this.customer,
    required this.customersCubit,
    this.onSuccess,
  });

  final CustomerModel customer;
  final CustomersCubit customersCubit;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: customersCubit,
        ),
        BlocProvider(create: (context) => get<UsersCubit>()),
        BlocProvider(create: (context) => get<LevelsCubit>()),
      ],
      child: ApproveCustomerPage(
        customersCubit: customersCubit,
        customer: customer,
        onSuccess: onSuccess,
      ),
    );
  }
}

class ApproveCustomerPage extends StatefulWidget {
  const ApproveCustomerPage({
    super.key,
    required this.customersCubit,
    required this.customer,
    this.onSuccess,
  });
  final CustomerModel customer;
  final CustomersCubit customersCubit;
  final VoidCallback? onSuccess;

  @override
  State<ApproveCustomerPage> createState() => _ApproveCustomerPageState();
}

class _ApproveCustomerPageState extends State<ApproveCustomerPage>
    implements ApproveCustomerViewCallBacks {
  late final UsersCubit usersCubit = context.read();
  late final LevelsCubit levelsCubit = context.read();

  DepartmentEnum? selectedDepartment;

  @override
  void initState() {
    super.initState();
    usersCubit.getUsers(perPage: 1000000);
    levelsCubit.getLevels(perPage: 1000000);
    widget.customersCubit.setUserId(widget.customer.id);
  }

  @override
  void onDepartmentSelected(DepartmentEnum? department) {
    setState(() {
      selectedDepartment = department;
    });
    usersCubit.setRoleFilter(department);
    levelsCubit.setRoleFilter(department);
  }

  @override
  void onLevelSelected(LevelModel? level) =>
      widget.customersCubit.setLevelId(level?.id);

  @override
  void onEmployeeSelected(UserModel? employee) {
    // TODO check this
    if (selectedDepartment == DepartmentEnum.coach) {
      widget.customersCubit.setCoachId(employee?.id);
    } else if (selectedDepartment == DepartmentEnum.dietitian) {
      widget.customersCubit.setDietitianId(employee?.id);
    } else {
      widget.customersCubit.setDoctorId(employee?.id);
    }
  }

  @override
  void onCancelTap() => Navigator.pop(context);

  @override
  void onSave() => widget.customersCubit.assignSubscriber();

  @override
  void onTryAgainTap() {
    usersCubit.getUsers(perPage: 1000000);
    levelsCubit.getLevels(perPage: 1000000);
  }

  @override
  Widget build(BuildContext context) {
    final customer = widget.customer;
    final info = customer.info;
    final data = [
      TitleValueModel("gender", customer.gender?.displayName ?? "-"),
      TitleValueModel("birthday", customer.birthday ?? "-"),
      TitleValueModel("age", info?.age.toString() ?? "-"),
      TitleValueModel("weight", info?.weight.toString() ?? "-"),
      TitleValueModel("length", info?.length.toString() ?? "-"),
      TitleValueModel(
          "waist_circumference", info?.waistCircumference.toString() ?? "-"),
      TitleValueModel("chest", info?.chest.toString() ?? "-"),
      TitleValueModel("shoulder", info?.shoulder.toString() ?? "-"),
      TitleValueModel(
          "thigh_circumference", info?.thighCircumference.toString() ?? "-"),
      TitleValueModel("forearm_circumference",
          info?.forearmCircumference.toString() ?? "-"),
      TitleValueModel("chronic_diseases", info?.chronicDiseases ?? "-"),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        title: Text(
          'user_activation'.tr(),
          style: context.tt.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        padding: AppConstants.padding20,
        child: Column(
          spacing: 10,
          children: [
            const SizedBox(height: 5),
            Table(
              border: TableBorder.all(
                color: context.cs.primary,
                width: 2,
                borderRadius: AppConstants.borderRadius10,
              ),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: data.map((entry) {
                return TableRow(
                  children: [
                    Padding(
                      padding: AppConstants.padding12,
                      child: Text(
                        entry.title.tr(),
                        style: context.tt.titleMedium,
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: AppConstants.padding12,
                        child: Text(
                          entry.value,
                          style: context.tt.titleSmall,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            MainDropDownWidget(
              items: DepartmentEnum.values,
              prefixIcon: Icons.group,
              hintText: "department".tr(),
              labelText: "department".tr(),
              errorMessage: "department_required".tr(),
              onChanged: onDepartmentSelected,
            ),
            BlocBuilder<UsersCubit, GeneralUsersState>(
              builder: (context, state) {
                if (state is UsersLoading) {
                  return LoadingIndicator();
                } else if (state is UsersSuccess) {
                  return MainDropDownWidget<UserModel>(
                    items: state.users.data,
                    prefixIcon: Icons.person,
                    hintText: "employee".tr(),
                    labelText: "employee".tr(),
                    onChanged: onEmployeeSelected,
                  );
                } else if (state is UsersFail) {
                  return MainErrorWidget(
                    error: state.error,
                    onTryAgainTap: onTryAgainTap,
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            BlocBuilder<LevelsCubit, GeneralLevelsState>(
              builder: (context, state) {
                if (state is LevelsLoading) {
                  return LoadingIndicator();
                } else if (state is LevelsSuccess) {
                  return MainDropDownWidget(
                    items: state.levels.data,
                    prefixIcon: Icons.bar_chart,
                    hintText: 'level'.tr(),
                    labelText: 'level'.tr(),
                    errorMessage: 'required_field'.tr(),
                    onChanged: onLevelSelected,
                  );
                } else if (state is LevelsFail) {
                  return MainErrorWidget(
                    error: state.error,
                    onTryAgainTap: onTryAgainTap,
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 10),
            BlocConsumer<CustomersCubit, GeneralCustomersState>(
              listener: (context, state) {
                if (state is AssignSubscriberSuccess) {
                  widget.onSuccess?.call();
                  onCancelTap();
                  MainSnackBar.showSuccessMessage(context, state.message);
                } else if (state is AssignSubscriberFail) {
                  MainSnackBar.showErrorMessage(context, state.error);
                }
              },
              builder: (context, state) {
                var onTap = onSave;
                Widget? child;
                if (state is AssignSubscriberLoading) {
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
