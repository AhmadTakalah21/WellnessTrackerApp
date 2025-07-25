import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/customers/cubit/customers_cubit.dart';
import 'package:wellnesstrackerapp/features/notifications/cubit/notifications_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/choose_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';
import 'package:wellnesstrackerapp/global/widgets/mutli_selector_drop_down.dart';

abstract class AddNotificationViewCallBacks {
  void onDepartmentSelected(DepartmentEnum? department);
  void onIsAllSelected(bool? isAll);
  void onCancelTap();
  void onTryAgainTap();
  void onSend();
}

class AddNotificationView extends StatelessWidget {
  const AddNotificationView({
    super.key,
    required this.notificationsCubit,
    this.onSuccess,
    required this.role,
  });

  final NotificationsCubit notificationsCubit;
  final UserRoleEnum role;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<CustomersCubit>(),
      child: AddNotificationWidget(
        notificationsCubit: notificationsCubit,
        role: role,
        onSuccess: onSuccess,
      ),
    );
  }
}

class AddNotificationWidget extends StatefulWidget {
  const AddNotificationWidget({
    super.key,
    this.onSuccess,
    required this.notificationsCubit,
    required this.role,
  });

  final NotificationsCubit notificationsCubit;
  final UserRoleEnum role;
  final VoidCallback? onSuccess;

  @override
  State<AddNotificationWidget> createState() => _AddNotificationWidgetState();
}

class _AddNotificationWidgetState extends State<AddNotificationWidget>
    implements AddNotificationViewCallBacks {
  late final CustomersCubit customersCubit = context.read();
  final _formKey = GlobalKey<FormState>();

  bool isAll = false;
  DepartmentEnum? selectedDepartment;

  @override
  void initState() {
    super.initState();
    customersCubit.getCustomers(widget.role, perPage: null);
  }

  @override
  void onIsAllSelected(bool? value) {
    setState(() {
      isAll = !isAll;
    });
    if (isAll) {
      widget.notificationsCubit.clearUserIds();
    }
    widget.notificationsCubit.setIsAll(isAll.toString());
  }

  @override
  void onDepartmentSelected(DepartmentEnum? department) {
    setState(() {
      selectedDepartment = department;
    });
  }

  @override
  void onTryAgainTap() =>
      customersCubit.getCustomers(widget.role, perPage: null);

  @override
  void onSend() => widget.notificationsCubit.addNotification(widget.role);

  @override
  void onCancelTap() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final isAdmin = widget.role.isAdmin;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: AppConstants.padding20,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back),
                      ),
                      Spacer(),
                      Text(
                        'send_notification'.tr(),
                        style: context.tt.headlineSmall,
                      ),
                      Spacer(),
                      SizedBox(width: 30)
                    ],
                  ),
                  const SizedBox(height: 24),
                  SwitchListTile(
                    value: isAll,
                    onChanged: onIsAllSelected,
                    title: Text(
                      isAll
                          ? "all_subscribers".tr()
                          : "certain_subscribers".tr(),
                      style: context.tt.bodyLarge,
                    ),
                    activeColor: context.cs.primary,
                    inactiveThumbColor: context.cs.secondary,
                    activeTrackColor: context.cs.primary.withValues(alpha: 0.4),
                    inactiveTrackColor:
                        context.cs.secondary.withValues(alpha: 0.2),
                    dense: true,
                    visualDensity: VisualDensity.compact,
                  ),
                  AnimatedSizeAndFade.showHide(
                    show: !isAll,
                    child: Column(
                      children: [
                        if (isAdmin) ...[
                          const SizedBox(height: 16),
                          MainDropDownWidget(
                            items: DepartmentEnum.values,
                            prefixIcon: Icons.group,
                            hintText: "department".tr(),
                            labelText: "department".tr(),
                            errorMessage: "department_required".tr(),
                            onChanged: onDepartmentSelected,
                            isEntityName: true,
                          ),
                        ],
                        const SizedBox(height: 16),
                        BlocBuilder<CustomersCubit, GeneralCustomersState>(
                          builder: (context, state) {
                            if (state is CustomersLoading) {
                              return LoadingIndicator();
                            } else if (state is CustomersSuccess) {
                              // TODO filter depending on department
                              //inal data = state.customers.data;
                              // final items = selectedDepartment == null
                              //     ? data
                              //     : data.where((customer) {
                              //         return customer.department.id ==
                              //             selectedDepartment?.id;
                              //       }).toList();
                              return MutliSelectorDropDown(
                                items: state.customers.data,
                                prefixIcon: Icons.subscriptions,
                                hintText: "subscribers".tr(),
                                labelText: "subscribers".tr(),
                                onChanged: widget.notificationsCubit.setUsers,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  MainTextField2(
                    onChanged: widget.notificationsCubit.setTitle,
                    icon: Icons.title,
                    label: 'title'.tr(),
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  const SizedBox(height: 12),
                  MainTextField2(
                    onChanged: widget.notificationsCubit.setMessage,
                    icon: Icons.message,
                    label: 'message'.tr(),
                    validator: (val) => val == null || val.isEmpty
                        ? 'required_field'.tr()
                        : null,
                  ),
                  const SizedBox(height: 12),
                  ChooseImageWidget(
                    onSetImage: widget.notificationsCubit.setImage,
                    validator: (i) => i == null ? 'image_required'.tr() : null,
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          Padding(
            padding: AppConstants.padding20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocConsumer<NotificationsCubit, GeneralNotificationsState>(
                  bloc: widget.notificationsCubit,
                  listener: (context, state) {
                    if (state is AddNotificationSuccess) {
                      widget.onSuccess?.call();
                      onCancelTap();
                      MainSnackBar.showSuccessMessage(context, state.message);
                    } else if (state is AddNotificationFail) {
                      MainSnackBar.showErrorMessage(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    var onTap = onSend;
                    Widget? child;
                    if (state is AddNotificationLoading) {
                      onTap = () {};
                      child = LoadingIndicator(
                        size: 30,
                        color: context.cs.surface,
                      );
                    }
                    return MainActionButton(
                      text: 'send'.tr(),
                      onTap: onTap,
                      child: child,
                    );
                  },
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
