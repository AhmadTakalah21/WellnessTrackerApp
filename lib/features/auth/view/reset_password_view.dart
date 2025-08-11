import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field.dart';

abstract class ResetPasswordViewCallBacks {
  void onShowPassword();
  void onMainActionTap();
  void onLoginTap();
}

@RoutePage()
class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.authCubit});

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return ResetPasswordPage(authCubit: authCubit);
  }
}

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required this.authCubit});

  final AuthCubit authCubit;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage>
    implements ResetPasswordViewCallBacks {
  bool isObsecurePassword = true;
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  void onLoginTap() => context.router.replace(SignInRoute());

  @override
  void onMainActionTap() => widget.authCubit.resetPassword();

  @override
  void onShowPassword() {
    setState(() => isObsecurePassword = !isObsecurePassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: context.cs.primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  AppConstants.appName,
                  style: context.tt.headlineMedium?.copyWith(
                    color: context.cs.surface,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          'reset_password'.tr(),
                          style: context.tt.headlineMedium?.copyWith(
                            color: context.cs.primary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildPasswordTextField(),
                        const SizedBox(height: 10),
                        _buildConfirmPasswordTextField(),
                        const SizedBox(height: 20),
                        _buildMainActionButton(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('remembered_pass'.tr()),
                            GestureDetector(
                              onTap: onLoginTap,
                              child: Text(
                                'login'.tr(),
                                style: TextStyle(
                                  color: context.cs.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordTextField() {
    final icon = isObsecurePassword ? Icons.visibility : Icons.visibility_off;
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: widget.authCubit,
      buildWhen: (prev, curr) =>
          curr is TextFieldState && curr.type == TextFieldType.password,
      builder: (context, state) {
        bool b =
            state is TextFieldState && state.type == TextFieldType.password;
        return MainTextField(
          obscureText: isObsecurePassword,
          labelText: "password".tr(),
          onChanged: widget.authCubit.setNewPassword,
          onSubmitted: (_) => confirmPasswordFocusNode.requestFocus(),
          focusNode: passwordFocusNode,
          errorText: b ? state.error : null,
          prefixIcon: Icon(Icons.lock, color: context.cs.onSecondary),
          suffixIcon: IconButton(
            icon: Icon(icon, color: context.cs.onSecondary),
            onPressed: onShowPassword,
          ),
        );
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {
    final icon = isObsecurePassword ? Icons.visibility : Icons.visibility_off;
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: widget.authCubit,
      buildWhen: (prev, curr) =>
          curr is TextFieldState && curr.type == TextFieldType.confirmPassword,
      builder: (context, state) {
        bool b = state is TextFieldState &&
            state.type == TextFieldType.confirmPassword;
        return MainTextField(
          obscureText: isObsecurePassword,
          labelText: "confirm_password".tr(),
          onChanged: widget.authCubit.setConfirmNewPassword,
          onSubmitted: (_) => confirmPasswordFocusNode.unfocus(),
          focusNode: confirmPasswordFocusNode,
          errorText: b ? state.error : null,
          prefixIcon: const Icon(Icons.lock, color: Colors.black54),
          suffixIcon: IconButton(
            icon: Icon(icon, color: Colors.black54),
            onPressed: onShowPassword,
          ),
        );
      },
    );
  }

  Widget _buildMainActionButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: widget.authCubit,
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          MainSnackBar.showSuccessMessage(context, state.message);
          context.router.replace(SignInRoute());
        } else if (state is ResetPasswordFail) {
          MainSnackBar.showErrorMessage(context, state.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is ResetPasswordLoading;
        return MainActionButton(
          padding: AppConstants.padding8,
          onTap: isLoading ? () {} : onMainActionTap,
          text: 'reset_password'.tr(),
          child: isLoading ? LoadingIndicator(isInBtn: true) : null,
        );
      },
    );
  }
}
