import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class AddUserView extends StatelessWidget {
  const AddUserView({
    super.key,
    required this.isEdit,
    this.user,
    required this.selectedPage,
    required this.usersCubit,
    this.onSuccess,
  });

  final UsersCubit usersCubit;
  final bool isEdit;
  final UserModel? user;
  final int selectedPage;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: usersCubit,
      child: AddUserWidget(
        isEdit: isEdit,
        user: user,
        selectedPage: selectedPage,
        onSuccess: onSuccess,
      ),
    );
  }
}

class AddUserWidget extends StatefulWidget {
  const AddUserWidget({
    super.key,
    required this.isEdit,
    this.user,
    required this.selectedPage,
    this.onSuccess,
  });

  final bool isEdit;
  final UserModel? user;
  final int selectedPage;
  final VoidCallback? onSuccess;

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  UsersCubit get usersCubit => context.read<UsersCubit>();
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

      usersCubit.setName(widget.user!.name);
      usersCubit.setEmail(widget.user!.email);
      usersCubit.setPhone(widget.user!.phone);
      usersCubit.setRole(widget.user!.role);
    }
  }

  void _saveUser() {
    if (_formKey.currentState?.validate() ?? false) {
      usersCubit.setName(nameController.text);
      usersCubit.setEmail(emailController.text);
      usersCubit.setPassword(passwordController.text);
      usersCubit.setPhone(phoneController.text);

      usersCubit.addUser(isAdd: !widget.isEdit, userId: widget.user?.id);
    }
  }

  void selectRole(DepartmentEnum? role) => usersCubit.setRole(role?.name);

  void onCancelTap() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final spacing = const SizedBox(height: 16);
    final selectedRole = DepartmentEnum.values
        .firstWhereOrNull((role) => role.name == widget.user?.role);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
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
                      widget.isEdit ? 'edit_user'.tr() : 'add_user'.tr(),
                      style: context.tt.headlineSmall,
                    ),
                    Spacer(),
                    SizedBox(width: 30)
                  ],
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
                  validator: (val) =>
                      val == null || val.isEmpty ? 'required'.tr() : null,
                ),
                spacing,
                MainDropDownWidget(
                  items: DepartmentEnum.values,
                  selectedValue: selectedRole,
                  onChanged: selectRole,
                  hintText: 'select_role'.tr(),
                  labelText: 'role'.tr(),
                  prefixIcon: LucideIcons.shieldCheck,
                  errorMessage: 'role_required'.tr(),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: MainActionButton(
                        text: 'cancel'.tr(),
                        buttonColor: context.cs.surface,
                        border: Border.all(color: context.cs.primary),
                        textColor: context.cs.primary,
                        onTap: onCancelTap,
                      ),
                    ),
                    SizedBox(width: 20),
                    BlocConsumer<UsersCubit, GeneralUsersState>(
                      listener: (context, state) {
                        if (state is AddUserFail) {
                          MainSnackBar.showErrorMessage(context, state.error);
                        } else if (state is AddUserSuccess) {
                          widget.onSuccess?.call();
                          onCancelTap();
                          MainSnackBar.showSuccessMessage(
                              context, state.message);
                        }
                      },
                      builder: (context, state) {
                        var onTap = _saveUser;
                        Widget? child;
                        if (state is AddUserLoading) {
                          onTap = () {};
                          child = const LoadingIndicator(size: 30);
                        }
                        return Expanded(
                          child: MainActionButton(
                            text: 'save'.tr(),
                            onTap: onTap,
                            child: child,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
