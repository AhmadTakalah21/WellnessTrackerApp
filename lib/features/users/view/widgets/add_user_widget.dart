import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/models/activity_status_enum.dart';
import 'package:wellnesstrackerapp/global/models/user_role_model/user_role_model.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';
import '../../../../global/blocs/user_roles_cubit/cubit/user_roles_cubit.dart';

class AddUserWidget extends StatefulWidget {
  final bool isEdit;
  final UserModel? user;
  final int selectedPage;

  const AddUserWidget({
    super.key,
    required this.isEdit,
    this.user,
    required this.selectedPage,
  });

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  UsersCubit get cubit => context.read<UsersCubit>();
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.user != null) {
      nameController.text = widget.user!.name;
      emailController.text = widget.user!.email;
      phoneController.text = widget.user!.phone;
      cubit.setRole(widget.user!.role);
      cubit.setIsActive(widget.user!.isActive);
    }

    context.read<UserRolesCubit>().getRoles();
  }

  void _saveUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      cubit.setName(nameController.text);
      cubit.setEmail(emailController.text);
      cubit.setPassword(passwordController.text);
      cubit.setPhone(phoneController.text);

      await cubit.addUser(isAdd: !widget.isEdit, userId: widget.user?.id);

      // if (mounted) {
      //   Navigator.pop(context);
      //   cubit.getUsers(page: widget.selectedPage);
      // }
    }
  }

  void selectRole(UserRoleModel? role) {
    cubit.setRole(role?.name);
  }

  void selectStatus(ActivityStatusEnum? status) {
    cubit.setIsActive(status?.isActive);
  }

  @override
  Widget build(BuildContext context) {
    final spacing = const SizedBox(height: 16);
    final selectedStatus = ActivityStatusEnum.values
        .firstWhereOrNull((status) => status.isActive == widget.user?.isActive);
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      backgroundColor: context.cs.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: BlocListener<UsersCubit, GeneralUsersState>(
        listener: (context, state) {
          if (state is AddUserFail) {
            MainSnackBar.showErrorMessage(context, state.error);
          } else if (state is AddUserSuccess) {
            MainSnackBar.showSuccessMessage(context, state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      widget.isEdit ? 'edit_user'.tr() : 'add_user'.tr(),
                      style: context.tt.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 24),
                  MainTextField2(
                    controller: nameController,
                    label: 'name'.tr(),
                    icon: LucideIcons.user,
                    hint: 'John Doe',
                    validator: (val) =>
                        val == null || val.isEmpty ? 'required'.tr() : null,
                  ),
                  spacing,
                  MainTextField2(
                    controller: emailController,
                    label: 'email'.tr(),
                    icon: LucideIcons.mail,
                    hint: 'example@mail.com',
                    validator: (val) => val == null || !val.contains('@')
                        ? 'invalid_email'.tr()
                        : null,
                  ),
                  spacing,
                  MainTextField2(
                    controller: passwordController,
                    label: 'password'.tr(),
                    icon: LucideIcons.lock,
                    validator: (val) =>
                        val == null || val.length < 6 ? 'too_short'.tr() : null,
                    isPassword: true,
                  ),
                  spacing,
                  MainTextField2(
                    controller: phoneController,
                    label: 'phone'.tr(),
                    icon: LucideIcons.phone,
                  ),
                  spacing,
                  BlocBuilder<UserRolesCubit, UserRolesState>(
                    builder: (context, state) {
                      if (state is UserRolesLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: context.cs.primary,
                          ),
                        );
                      } else if (state is UserRolesSuccess) {
                        final selectedRole = state.userRoles.firstWhereOrNull(
                          (role) => role.name == widget.user?.role,
                        );
                        return MainDropDownWidget(
                          items: state.userRoles,
                          selectedValue: selectedRole,
                          onChanged: selectRole,
                          hintText: 'select_role'.tr(),
                          labelText: 'role'.tr(),
                          errorMessage: 'role_required'.tr(),
                          prefixIcon: LucideIcons.badgeCheck,
                        );
                      } else if (state is UserRolesEmpty) {
                        return Text(
                          'no_roles'.tr(),
                          style: TextStyle(color: Colors.red),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                  spacing,
                  MainDropDownWidget(
                    items: ActivityStatusEnum.values,
                    selectedValue: selectedStatus,
                    onChanged: selectStatus,
                    hintText: 'select_status'.tr(),
                    labelText: 'status'.tr(),
                    prefixIcon: LucideIcons.shieldCheck,
                    icon: LucideIcons.circleDot,
                    errorMessage: 'status_required'.tr(),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                            foregroundColor: context.cs.secondary),
                        child: Text('cancel'.tr()),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _saveUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.cs.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(
                          widget.isEdit ? 'save'.tr() : 'add'.tr(),
                          style: context.tt.labelLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
