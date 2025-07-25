import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/add_points_widget.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/approve_customer_view.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/assign_meal_plan_widget.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
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
  void onLongPress(CustomerModel customer);
  void onAddPoints();
  void onAssignDietPlan();
  void onSubmitAddPoints();
  void onTryAgainTap();
  void onSelected(CustomerModel customer);
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
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApproveCustomerView(
              customer: customer,
              customersCubit: customersCubit,
              onSuccess: fetchCustomers,
            ),
          ),
        );
      }
    }
  }

  @override
  void onSelected(CustomerModel customer) {
    customersCubit.updateUserIds(customer);
    setState(() {});
  }

  @override
  void onLongPress(CustomerModel customer) {
    if (customersCubit.isSelected(customer)) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape:
            RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
        builder: (context) => Row(
          children: [
            Expanded(
              child: Padding(
                padding: AppConstants.padding16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        "additional_options".tr(),
                        style: context.tt.headlineMedium,
                      ),
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: onAddPoints,
                      label: Text(
                        "add_points".tr(),
                        style: context.tt.titleMedium?.copyWith(
                          color: context.cs.primary,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.edit),
                      onPressed: onAssignDietPlan,
                      label: Text(
                        "assign_diet_plan".tr(),
                        style: context.tt.titleMedium?.copyWith(
                          color: context.cs.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
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
        return AddPointsView(
          customersCubit: customersCubit,
          onSave: onSubmitAddPoints,
        );
      },
    );
  }

  @override
  void onAssignDietPlan() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return AssignMealPlanView(
          customersCubit: customersCubit,
          onSave: onSubmitAddPoints,
        );
      },
    );
  }

  @override
  void onSubmitAddPoints() => customersCubit.addPoints(widget.role);

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
  void onSearchChanged(String input) => customersCubit.searchCodes(input);

  @override
  void onTryAgainTap() => fetchCustomers();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    bool isAdmin = widget.role.isAdmin;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        title: Text(
          'customers_administration'.tr(),
          style: context.tt.titleLarge,
        ),
      ),
      backgroundColor: context.cs.surface,
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CustomersCubit, GeneralCustomersState>(
                buildWhen: (previous, current) => current is CustomersState,
                builder: (context, state) {
                  if (state is CustomersLoading) {
                    return LoadingIndicator(
                      color: context.cs.primary,
                      height: height / 1.2,
                    );
                  } else if (state is CustomersSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          MainDataTable<CustomerModel>(
                            titles: CustomerModel.titles,
                            items: state.customers,
                            onPageChanged: onSelectPageTap,
                            emptyMessage: state.emptyMessage,
                            onEditTap: onEditTap,
                            onDeleteTap: isAdmin ? onDeleteTap : null,
                            onSearchChanged: onSearchChanged,
                            onSelected:
                                widget.role.isDietitian ? onSelected : null,
                            checkSelected: customersCubit.isSelected,
                            onLongPress: onLongPress,
                            searchHint: 'search_customer',
                          ),
                        ],
                      ),
                    );
                  } else if (state is CustomersEmpty) {
                    return MainErrorWidget(
                      error: state.message,
                      onTryAgainTap: onTryAgainTap,
                      height: 2.5,
                      isRefresh: true,
                    );
                  } else if (state is CustomersFail) {
                    return MainErrorWidget(
                      error: state.error,
                      height: 2.5,
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
