import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field.dart';

abstract class ResetPasswordViewCallBacks {
  void onPasswordChanged(String password);
  void onPasswordSubmitted(String password);
  void onConfirmPasswordChanged(String confirmPassword);
  void onConfirmPasswordSubmitted(String confirmPassword);
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
    super.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
  }

  @override
  void onConfirmPasswordChanged(String confirmPassword) =>
      widget.authCubit.setConfirmNewPassword(confirmPassword);

  @override
  void onConfirmPasswordSubmitted(String confirmPassword) =>
      confirmPasswordFocusNode.unfocus();

  @override
  void onLoginTap() => context.router.push(SignInRoute());

  @override
  void onMainActionTap() => widget.authCubit.resetPassword();

  @override
  void onPasswordChanged(String password) =>
      widget.authCubit.setNewPassword(password);

  @override
  void onPasswordSubmitted(String password) =>
      confirmPasswordFocusNode.requestFocus();

  @override
  void onShowPassword() {
    setState(() {
      isObsecurePassword = !isObsecurePassword;
    });
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
                SizedBox(height: 100),
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
                        // const CustomTextField(
                        //   label: 'New Password',
                        //   icon: Icons.lock,
                        //   icon2: Icons.visibility,
                        // ),
                        MainTextField(
                          obscureText: isObsecurePassword,
                          // errorText:
                          //     state is TextFieldState &&
                          //             state.type == TextFieldType.password
                          //         ? state.error
                          //         : null,
                          labelText: "password".tr(),
                          onChanged: onPasswordChanged,
                          onSubmitted: onPasswordSubmitted,
                          focusNode: passwordFocusNode,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: context.cs.onSecondary,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObsecurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: context.cs.onSecondary,
                            ),
                            onPressed: onShowPassword,
                          ),
                        ),
                        SizedBox(height: 10),
                        MainTextField(
                          obscureText: isObsecurePassword,
                          // errorText:
                          //     state is TextFieldState &&
                          //             state.type ==
                          //                 TextFieldType.confirmPassword
                          //         ? state.error
                          //         : null,
                          labelText: "confirm_password".tr(),
                          onChanged: onConfirmPasswordChanged,
                          onSubmitted: onConfirmPasswordSubmitted,
                          focusNode: confirmPasswordFocusNode,
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black54,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObsecurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black54,
                            ),
                            onPressed: onShowPassword,
                          ),
                        ),
                        // const CustomTextField(
                        //   label: 'Confirm Password',
                        //   icon: Icons.lock,
                        //   icon2: Icons.visibility,
                        // ),
                        const SizedBox(height: 20),
                        MainActionButton(
                          padding: AppConstants.padding8,
                          onTap: onMainActionTap,
                          text: 'reset_password'.tr(),
                        ),
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
}
