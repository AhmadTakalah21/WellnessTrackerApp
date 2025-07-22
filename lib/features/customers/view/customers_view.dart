import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/approve_customer_view.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class CustomersViewCallbacks {
  void fetchCustomers();
  void onSelectPageTap(int page, int perPage);
  void onSearchChanged(String input);
  void onEditTap(CustomerModel customer);
  void onDeleteTap(CustomerModel customer);
  void onAddPoints();
  void onSubmitAddPoints();
  void onTryAgainTap();
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
  bool isAddPoints = false;

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
  void onAddPoints() {
    setState(() {
      isAddPoints = !isAddPoints;
    });
    if (!isAddPoints) {
      customersCubit.resetAddPointsModel();
    }
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
                        //spacing: 16,
                        children: [
                          Row(
                            spacing: 16,
                            children: [
                              Expanded(
                                child: MainActionButton(
                                  onTap: onAddPoints,
                                  textColor: context.cs.secondary,
                                  text: "add_points".tr(),
                                  icon: Icon(Icons.add),
                                ),
                              ),
                              Expanded(
                                child: AnimatedSizeAndFade.showHide(
                                  show: isAddPoints,
                                  child: MainTextField2(
                                    onChanged: customersCubit.setPoints,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    isWithTitle: false,
                                    label: "points".tr(),
                                    icon: Icons.point_of_sale,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          AnimatedSizeAndFade.showHide(
                            show: isAddPoints,
                            child: Column(
                              children: [
                                SizedBox(height: 16),
                                BlocConsumer<CustomersCubit,
                                    GeneralCustomersState>(
                                  listener: (context, state) {
                                    if (state is AddPointsSuccess) {
                                      MainSnackBar.showSuccessMessage(
                                          context, state.message);
                                    } else if (state is AddPointsFail) {
                                      MainSnackBar.showErrorMessage(
                                          context, state.error);
                                    }
                                  },
                                  builder: (context, state) {
                                    bool isLoading = state is AddPointsLoading;
                                    return MainActionButton(
                                      onTap:
                                          isLoading ? () {} : onSubmitAddPoints,
                                      text: "save".tr(),
                                      child: isLoading
                                          ? LoadingIndicator(
                                              size: 20,
                                              color: context.cs.surface)
                                          : null,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          MainDataTable<CustomerModel>(
                            titles: CustomerModel.titles,
                            items: state.customers,
                            onPageChanged: onSelectPageTap,
                            emptyMessage: state.emptyMessage,
                            onEditTap: onEditTap,
                            onDeleteTap: isAdmin ? onDeleteTap : null,
                            onSearchChanged: onSearchChanged,
                            isSelectable: isAddPoints,
                            onSelected: isAddPoints
                                ? customersCubit.updateUserIds
                                : null,
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
