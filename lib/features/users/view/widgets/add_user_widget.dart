import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/users/cubit/users_cubit.dart';
import 'package:wellnesstrackerapp/features/users/model/user_model/user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_drop_down_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

class AddUserView extends StatelessWidget {
  const AddUserView({
    super.key,
    this.user,
    required this.selectedPage,
    required this.usersCubit,
    this.onSuccess,
  });

  final UsersCubit usersCubit;
  final UserModel? user;
  final int selectedPage;
  final VoidCallback? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: usersCubit,
      child: AddUserWidget(
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
    this.user,
    required this.selectedPage,
    this.onSuccess,
  });

  final UserModel? user;
  final int selectedPage;
  final VoidCallback? onSuccess;

  @override
  State<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  UsersCubit get usersCubit => context.read<UsersCubit>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usersCubit.setModel(widget.user);
  }

  void _saveUser() {
    if (_formKey.currentState?.validate() ?? false) {
      usersCubit.addUser(userId: widget.user?.id);
    }
  }

  void selectRole(DepartmentEnum? role) => usersCubit.setRole(role);

  void onCancelTap() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTitle(),
                    const SizedBox.shrink(),
                    _buildNameTextField(user),
                    _buildEmailTextField(user),
                    _buildPasswordTextField(),
                    _buildPhoneTextField(user),
                    _buildRoleDropDown(user),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() => Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
          Spacer(),
          Text(
            widget.user != null ? 'edit_user'.tr() : 'add_user'.tr(),
            style: context.tt.headlineSmall,
          ),
          Spacer(),
          SizedBox(width: 30)
        ],
      );

  Widget _buildNameTextField(UserModel? user) => MainTextField2(
        initialText: user?.name,
        label: 'name'.tr(),
        icon: LucideIcons.user,
        hint: 'John Doe',
        onChanged: usersCubit.setName,
        validator: (val) => Utils.validateInput(val, InputTextType.none),
      );

  Widget _buildEmailTextField(UserModel? user) => MainTextField2(
        initialText: user?.email,
        label: 'email'.tr(),
        icon: LucideIcons.mail,
        hint: 'example@mail.com',
        keyboardType: TextInputType.emailAddress,
        onChanged: usersCubit.setEmail,
        validator: (val) => Utils.validateInput(val, InputTextType.email),
      );

  Widget _buildPasswordTextField() => MainTextField2(
        label: 'password'.tr(),
        icon: LucideIcons.lock,
        onChanged: usersCubit.setPassword,
        validator: (val) => Utils.validateInput(val, InputTextType.password),
      );

  Widget _buildPhoneTextField(UserModel? user) => MainTextField2(
        initialText: user?.phone,
        label: 'phone'.tr(),
        icon: LucideIcons.phone,
        onChanged: usersCubit.setPhone,
        validator: (val) => Utils.validateInput(val, InputTextType.phone),
      );

  Widget _buildRoleDropDown(UserModel? user) {
    final selectedRole = DepartmentEnum.values
        .firstWhereOrNull((role) => role.name == user?.role.name);
    return MainDropDownWidget(
      items: DepartmentEnum.values,
      selectedValue: selectedRole,
      onChanged: selectRole,
      hintText: 'select_role'.tr(),
      labelText: 'role'.tr(),
      prefixIcon: LucideIcons.shieldCheck,
      errorMessage: 'role_required'.tr(),
    );
  }

  Widget _buildButtons() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
                    MainSnackBar.showSuccessMessage(context, state.message);
                  }
                },
                builder: (context, state) {
                  var onTap = _saveUser;
                  Widget? child;
                  if (state is AddUserLoading) {
                    onTap = () {};
                    child =
                        LoadingIndicator(size: 30, color: context.cs.surface);
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
          SizedBox(height: 20),
        ],
      );
}
