import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/add_customer_report_widget.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/add_medical_consultation_widget.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/add_points_widget.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/additional_customer_options_widget.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/assign_customers_view.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/assign_exercise_plan_widget.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/assign_meal_plan_widget.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

abstract class CustomersViewCallbacks {
  void fetchCustomers();
  void onSelectPageTap(int page, int perPage);
  void onSearchChanged(String input);
  void onEditTap(CustomerModel customer);
  void onDeleteTap(CustomerModel customer);
  void onReportTap(CustomerModel customer);
  void onLongPress(CustomerModel customer);
  void onAddMedicalConsultation(CustomerModel customer);
  void onAddPoints();
  void onAssignPlan();
  void onTryAgainTap();
  void onAssignCustomers();
  Future<void> onRefresh();
  void onSelected(CustomerModel customer);
  List<Widget> customButtons(CustomerModel customer);
}

@RoutePage()
class CustomersView extends StatelessWidget {
  const CustomersView({super.key, required this.role, this.user});

  final UserRoleEnum role;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<CustomersCubit>()
        ..getCustomers(role, employeeId: user?.id, page: 1),
      child: CustomersPage(role: role, user: user),
    );
  }
}

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key, required this.role, this.user});

  final UserRoleEnum role;
  final UserModel? user;

  @override
  CustomersPageState createState() => CustomersPageState();
}

class CustomersPageState extends State<CustomersPage>
    implements CustomersViewCallbacks {
  late final CustomersCubit customersCubit = context.read();

  int perPage = 10;
  int currentPage = 1;

  @override
  void fetchCustomers() {
    customersCubit.getCustomers(
      widget.role,
      page: currentPage,
      perPage: perPage,
      employeeId: widget.user?.id,
    );
  }

  @override
  void onSelectPageTap(int page, int perPage) {
    setState(() {
      currentPage = page;
      this.perPage = perPage;
    });
    fetchCustomers();
  }

  @override
  void onEditTap(CustomerModel customer) {
    if (widget.role.isAdmin) {
      if (customer.info == null) {
        MainSnackBar.showMessage(context, "customer_not_fill_info".tr());
        return;
      }
      context.router.push(
        ApproveCustomerRoute(
          customer: customer,
          customersCubit: customersCubit,
          onSuccess: fetchCustomers,
        ),
      );
    } else {
      context.router.push(
        UpdateCustomerInfoRoute(
          customersCubit: customersCubit,
          customer: customer,
          role: widget.role,
        ),
      );
    }
  }

  @override
  void onAssignCustomers() {
    showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (bottomSheetContext) => AssignCustomersView(
        customersCubit: customersCubit,
        onSuccess: () => fetchCustomers(),
      ),
    );
  }

  @override
  void onReportTap(CustomerModel customer) {
    if (!widget.role.isAdmin) {
      showMaterialModalBottomSheet(
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
        builder: (context) => AddCustomerReportView(
          customersCubit: customersCubit,
          role: widget.role,
          customer: customer,
        ),
      );
    } else {
      context.router.push(
        SubscriberEvaluationRoute(role: widget.role, customer: customer),
      );
    }
  }

  @override
  void onSelected(CustomerModel customer) {
    customersCubit.updateUserIds(customer);
    setState(() {});
  }

  @override
  void onAssignPlan() {
    final view = widget.role.isDietitian
        ? AssignMealPlanView(customersCubit: customersCubit)
        : AssignExercisePlanView(customersCubit: customersCubit);
    Navigator.pop(context);
    showDialog(context: context, builder: (context) => view);
  }

  @override
  void onLongPress(CustomerModel customer) {
    if (customersCubit.isSelected(customer)) {
      void Function()? onAssign = onAssignPlan;
      String text = "assign_diet_plan";
      if (widget.role.isAdmin) {
        //onAssign = null;
        text = "assign_to_specialists";
        onAssign = onAssignCustomers;
      } else if (widget.role.isDietitian) {
      } else if (widget.role.isCoach) {
        text = "assign_exercise_plan";
      } else if (widget.role.isDoctor) {
        onAssign = null;
      } else if (widget.role.isPsychologist) {
        onAssign = null;
      }
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
        builder: (context) => AdditionalCustomerOptionsWidget(
          onAddPoints: onAddPoints,
          assignPlanText: text,
          onAssignPlan: onAssign,
        ),
      );
    }
  }

  @override
  void onAddPoints() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return AddPointsView(customersCubit: customersCubit, role: widget.role);
      },
    );
  }

  @override
  void onAddMedicalConsultation(CustomerModel customer) {
    showDialog(
      context: context,
      builder: (context) {
        return AddMedicalConsultationView(
          customersCubit: customersCubit,
          role: widget.role,
          customer: customer,
        );
      },
    );
  }

  @override
  void onDeleteTap(CustomerModel customer) {
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
        item: customer,
        onSuccess: onTryAgainTap,
      ),
    );
  }

  @override
  void onSearchChanged(String input) => customersCubit.searchCustomers(input);

  @override
  List<Widget> customButtons(CustomerModel customer) {
    bool isAdmin = widget.role.isAdmin;
    bool isDoctor = widget.role.isDoctor;
    bool isPsychologist = widget.role.isPsychologist;
    return [
      IconButton(
        onPressed: () => onReportTap(customer),
        icon: Icon(
          isAdmin ? Icons.description : Icons.edit_document,
          color: context.cs.onPrimaryFixed,
        ),
      ),
      if (isDoctor || isPsychologist)
        IconButton(
          onPressed: () => onAddMedicalConsultation(customer),
          icon: Icon(Icons.medical_services, color: Colors.red),
        ),
    ];
  }

  @override
  void onTryAgainTap() => fetchCustomers();

  @override
  Future<void> onRefresh() async => fetchCustomers();

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = widget.role.isAdmin;
    final bool isDoctor = widget.role.isDoctor;
    final bool isPsychologist = widget.role.isPsychologist;
    final titles = [
      '#',
      'name'.tr(),
      'email'.tr(),
      'phone'.tr(),
      if (isAdmin && widget.user == null) ...[
        'dietitian'.tr(),
        'coach'.tr(),
        'doctor'.tr(),
        'psychologist'.tr(),
      ],
      if (isAdmin) 'code'.tr(),
      'subscription_end_date'.tr(),
      if (widget.user != null || isDoctor || isPsychologist)
        "medical_consultations_num".tr(),
      'status'.tr(),
      'event'.tr(),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('customers_administration'.tr())),
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CustomersCubit, GeneralCustomersState>(
                buildWhen: (previous, current) => current is CustomersState,
                builder: (context, state) {
                  if (state is CustomersLoading) {
                    return LoadingIndicator();
                  } else if (state is CustomersSuccess) {
                    return RefreshIndicator(
                      onRefresh: onRefresh,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            MainDataTable<CustomerModel>(
                              titles: titles,
                              items: state.customers,
                              onPageChanged: onSelectPageTap,
                              emptyMessage: state.emptyMessage,
                              onEditTap: onEditTap,
                              onDeleteTap: isAdmin ? onDeleteTap : null,
                              onSearchChanged: onSearchChanged,
                              onSelected: onSelected,
                              checkSelected: customersCubit.isSelected,
                              onLongPress: onLongPress,
                              searchHint: 'search_customer',
                              customButtons: customButtons,
                              //showCheckboxColumn: true,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is CustomersEmpty) {
                    return MainErrorWidget(
                      error: state.message,
                      onTryAgainTap: onTryAgainTap,
                      isRefresh: true,
                    );
                  } else if (state is CustomersFail) {
                    return MainErrorWidget(
                      error: state.error,
                      onTryAgainTap: onTryAgainTap,
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
