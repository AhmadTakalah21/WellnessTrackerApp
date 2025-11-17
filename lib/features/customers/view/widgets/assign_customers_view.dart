import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/levels/cubit/levels_cubit.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/activity_status_enum.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
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

abstract class AssignCustomersViewCallBacks {
  void onDepartmentSelected(DepartmentEnum? department);
  void onEmployeeSelected(UserModel? employee);
  void onActivityStatusSelected(ActivityStatusEnum? status);
  void onLevelSelected(LevelModel? level);
  void onCancelTap();
  void onSave();
  void onTryAgainTap();
}

@RoutePage()
class AssignCustomersView extends StatelessWidget {
  const AssignCustomersView({
    super.key,
    required this.customersCubit,
    this.onSuccess,
  });

  final CustomersCubit customersCubit;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: customersCubit),
        BlocProvider(create: (context) => get<UsersCubit>()),
        BlocProvider(create: (context) => get<LevelsCubit>()),
      ],
      child: AssignCustomersPage(
        customersCubit: customersCubit,
        onSuccess: onSuccess,
      ),
    );
  }
}

class AssignCustomersPage extends StatefulWidget {
  const AssignCustomersPage({
    super.key,
    required this.customersCubit,
    this.onSuccess,
  });
  final CustomersCubit customersCubit;
  final VoidCallback? onSuccess;

  @override
  State<AssignCustomersPage> createState() => _AssignCustomersPageState();
}

class _AssignCustomersPageState extends State<AssignCustomersPage>
    implements AssignCustomersViewCallBacks {
  late final UsersCubit usersCubit = context.read();
  late final LevelsCubit levelsCubit = context.read();

  DepartmentEnum? selectedDepartment;

  @override
  void initState() {
    super.initState();
    usersCubit.getUsers(perPage: 1000000);
    levelsCubit.getLevels(UserRoleEnum.admin, perPage: 1000000);
  }

  @override
  void onActivityStatusSelected(ActivityStatusEnum? status) =>
      widget.customersCubit.setActivityStatus(status);

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
  void onEmployeeSelected(UserModel? employee) =>
      widget.customersCubit.setEmployeeId(employee);

  @override
  void onCancelTap() => context.router.pop();

  @override
  void onSave() => widget.customersCubit.assignSubscriber();

  @override
  void onTryAgainTap() {
    usersCubit.getUsers(perPage: 1000000);
    levelsCubit.getLevels(UserRoleEnum.admin, perPage: 1000000);
  }

  @override
  void dispose() {
    widget.customersCubit.resetAssignSubscriberModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: AppConstants.padding20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            _buildTitle(),
            const SizedBox(height: 4),
            _buildDepartmentsDropDown(),
            _buildUsersDropDown(),
            _buildSelectedEmployees(),
            _buildLevelsDropDown(),
            const SizedBox(height: 10),
            _buildSubmitButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() => Center(
      child: Text('assign_to_specialists'.tr(), style: context.tt.titleLarge));

  Widget _buildDepartmentsDropDown() => MainDropDownWidget(
        items: DepartmentEnum.values,
        prefixIcon: Icons.group,
        hintText: "department".tr(),
        labelText: "department".tr(),
        errorMessage: "department_required".tr(),
        onChanged: onDepartmentSelected,
      );

  Widget _buildUsersDropDown() => BlocBuilder<UsersCubit, GeneralUsersState>(
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
      );

  Widget _buildSelectedEmployees() {
    return BlocBuilder<CustomersCubit, GeneralCustomersState>(
      buildWhen: (previous, current) => current is SelectedSpecialistsState,
      builder: (context, state) {
        if (state is SelectedSpecialistsState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              if (state.selectedDietitian != null)
                Text("selected dietitian :${state.selectedDietitian?.name} "),
              if (state.selectedCoach != null)
                Text("selected coach :${state.selectedCoach?.name} "),
              if (state.selectedDoctor != null)
                Text("selected doctor :${state.selectedDoctor?.name} "),
              if (state.selectedPsychologist != null)
                Text("selected doctor :${state.selectedPsychologist?.name} "),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLevelsDropDown() => BlocBuilder<LevelsCubit, GeneralLevelsState>(
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
          } else if (state is LevelsEmpty) {
            return MainErrorWidget(error: state.message);
          } else if (state is LevelsFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return SizedBox.shrink();
          }
        },
      );

  Widget _buildSubmitButton() =>
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
          return MainActionButton(
            text: 'save'.tr(),
            onTap: onSave,
            isLoading: state is AssignSubscriberLoading,
          );
        },
      );
}
