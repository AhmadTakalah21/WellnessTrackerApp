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
import 'package:wellnesstrackerapp/global/utils/utils.dart';
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
  final _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    customersCubit.getCustomers(widget.role, perPage: null);
  }

  @override
  void dispose() {
    _timeController.dispose();
    widget.notificationsCubit.resetAddNotificationModel();
    super.dispose();
  }

  @override
  void onIsAllSelected(bool? value) {
    if (value == null) return;
    setState(() => isAll = value);
    if (isAll) {
      widget.notificationsCubit.clearUserIds();
    }
    widget.notificationsCubit.setIsAll(isAll ? "1" : "0");
  }

  @override
  void onDepartmentSelected(DepartmentEnum? department) {
    setState(() => selectedDepartment = department);
  }

  @override
  void onTryAgainTap() =>
      customersCubit.getCustomers(widget.role, perPage: null);

  @override
  void onSend() {
    if (!_formKey.currentState!.validate()) return;
    widget.notificationsCubit.addNotification(widget.role);
  }

  @override
  void onCancelTap() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final isAdmin = widget.role.isAdmin;
    final subs = isAll ? "all_subscribers".tr() : "certain_subscribers".tr();

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
                        icon: const Icon(Icons.arrow_back),
                      ),
                      const Spacer(),
                      Text(
                        'send_notification'.tr(),
                        style: context.tt.headlineSmall,
                      ),
                      const Spacer(),
                      const SizedBox(width: 30),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SwitchListTile(
                    value: isAll,
                    onChanged: onIsAllSelected,
                    title: Text(subs, style: context.tt.bodyLarge),
                    activeColor: context.cs.primary,
                    inactiveThumbColor: context.cs.secondary,
                    activeTrackColor: context.cs.primary.withValues(alpha: 0.4),
                    inactiveTrackColor:
                        context.cs.secondary.withValues(alpha: 0.2),
                    dense: true,
                    visualDensity: VisualDensity.compact,
                  ),
                  SizedBox(height: 10),
                  SwitchListTile(
                    value: widget.notificationsCubit.scheduleByTime,
                    onChanged: (v) {
                      setState(() {
                        widget.notificationsCubit.setScheduleByTime(v);
                      });
                      if (!v) {
                        _timeController.clear();
                      }
                    },
                    title: Text(
                      widget.notificationsCubit.scheduleByTime
                          ? "scheduled_notifications_on".tr()
                          : "scheduled_notifications_off".tr(),
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
                    show: widget.notificationsCubit.scheduleByTime,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: MainTextField2(
                        controller: _timeController,
                        icon: Icons.access_time,
                        label: "time".tr(),
                        readOnly: true,
                        onTap: () => _pickTime(context),
                        validator: (val) {
                          if (!widget.notificationsCubit.scheduleByTime) {
                            return null;
                          }
                          if (val == null || val.isEmpty) {
                            return 'required_field'.tr();
                          }
                          final ok = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$')
                              .hasMatch(val);
                          return ok ? null : "time_invalid_format".tr();
                        },
                      ),
                    ),
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
                            onChanged: onDepartmentSelected,
                            isEntityName: true,
                            isRequired: false,
                          ),
                        ],
                        const SizedBox(height: 16),
                        BlocBuilder<CustomersCubit, GeneralCustomersState>(
                          builder: (context, state) {
                            if (state is CustomersLoading) {
                              return const LoadingIndicator();
                            } else if (state is CustomersSuccess) {
                              return MutliSelectorDropDown(
                                items: state.customers.data,
                                prefixIcon: Icons.subscriptions,
                                errorMessage: "subscribers_required".tr(),
                                hintText: "subscribers".tr(),
                                labelText: "subscribers".tr(),
                                onChanged: widget.notificationsCubit.setUsers,
                              );
                            } else if (state is CustomersEmpty) {
                              return MainErrorWidget(error: state.message);
                            } else if (state is CustomersFail) {
                              return MainErrorWidget(
                                error: state.error,
                                onTryAgainTap: onTryAgainTap,
                              );
                            } else {
                              return const SizedBox.shrink();
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
                    validator: (val) =>
                        Utils.validateInput(val, InputTextType.none),
                  ),
                  const SizedBox(height: 12),
                  MainTextField2(
                    onChanged: widget.notificationsCubit.setMessage,
                    icon: Icons.message,
                    label: 'message'.tr(),
                    validator: (val) =>
                        Utils.validateInput(val, InputTextType.none),
                  ),
                  const SizedBox(height: 12),
                  ChooseImageWidget(
                    onSetImage: widget.notificationsCubit.setImage,
                  ),
                  const SizedBox(height: 100),
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
                    return MainActionButton(
                      text: 'send'.tr(),
                      onTap: onSend,
                      isLoading: state is AddNotificationLoading,
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickTime(BuildContext context) async {
    final now = TimeOfDay.now();
    final result = await showTimePicker(
      context: context,
      initialTime: now,
      builder: (ctx, child) => child!,
    );
    if (result != null) {
      final hh = result.hour.toString().padLeft(2, '0');
      final mm = result.minute.toString().padLeft(2, '0');
      final value = "$hh:$mm";
      _timeController.text = value;
      widget.notificationsCubit.setTz(DateTime.now().timeZoneOffset.toString());
      widget.notificationsCubit.setTime(value);
    }
  }
}
