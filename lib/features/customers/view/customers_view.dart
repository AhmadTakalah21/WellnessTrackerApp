import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/features/customers/view/widgets/approve_customer_view.dart';
import 'package:wellnesstrackerapp/global/blocs/delete_cubit/cubit/delete_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';

import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_data_table.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';

abstract class CustomersViewCallbacks {
  void onSelectPageTap(int page, int perPage);
  void onSearchChanged(String input);
  void onEditTap(CustomerModel customer);
  void onSaveDeleteTap(CustomerModel customer);
  void onDeleteTap(CustomerModel customer);
  void onTryAgainTap();
}

@RoutePage()
class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => get<CustomersCubit>()..getCustomers(page: 1),
        ),
        BlocProvider(create: (context) => get<DeleteCubit>()),
      ],
      child: const CustomersPage(),
    );
  }
}

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  CustomersPageState createState() => CustomersPageState();
}

class CustomersPageState extends State<CustomersPage>
    implements CustomersViewCallbacks {
  late final CustomersCubit customersCubit = context.read();
  late final DeleteCubit deleteCubit = context.read();

  int perPage = 10;
  int currentPage = 1;

  @override
  void onSelectPageTap(int page, int perPage) {
    setState(() {
      currentPage = page;
      this.perPage = perPage;
    });
    customersCubit.getCustomers(page: currentPage, perPage: perPage);
  }

  @override
  void onEditTap(CustomerModel customer) {
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
          ),
        ),
      );
    }
  }

  @override
  void onDeleteTap(CustomerModel customer) {
    showDialog(
      context: context,
      builder: (context) => InsureDeleteWidget(
        deleteCubit: deleteCubit,
        item: customer,
        onSaveTap: onSaveDeleteTap,
        onSuccess: onTryAgainTap,
      ),
    );
  }

  @override
  void onSaveDeleteTap(CustomerModel customer) =>
      deleteCubit.deleteItem<CustomerModel>(customer);

  @override
  void onSearchChanged(String input) => customersCubit.searchCodes(input);

  @override
  void onTryAgainTap() => customersCubit.getCustomers(
        page: currentPage,
        perPage: perPage,
      );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        title: Text(
          'customers_administration'.tr(),
          style: context.tt.titleLarge,
        ),
      ),
      backgroundColor: context.cs.onSurface,
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
                    return MainDataTable<CustomerModel>(
                      header: CustomerModel.header,
                      titles: CustomerModel.titles,
                      items: state.customers,
                      onPageChanged: onSelectPageTap,
                      emptyMessage: state.emptyMessage,
                      onEditTap: onEditTap,
                      onDeleteTap: onDeleteTap,
                      onSearchChanged: onSearchChanged,
                      searchHint: 'search_customer',
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
