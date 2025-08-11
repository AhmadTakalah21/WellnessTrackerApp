import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field.dart';
import '../../../../global/router/app_router.gr.dart';

abstract class ForgotPasswordViewCallBacks {
  void onMainActionTap();
  void onLoginTap();
}

@RoutePage()
class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key, required this.authCubit});

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordPage(authCubit: authCubit);
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key, required this.authCubit});

  final AuthCubit authCubit;

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin
    implements ForgotPasswordViewCallBacks {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void onLoginTap() => Navigator.pop(context);

  @override
  void onMainActionTap() {
    widget.authCubit.sendResetCode();
  }

  @override
  void dispose() {
    _controller.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: context.cs.primary,
            child: FadeTransition(
              opacity: _fadeAnimation,
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
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _slideAnimation,
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
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Text(
                              'forgot_password'.tr(),
                              style: context.tt.headlineMedium?.copyWith(
                                color: context.cs.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildEmailTextField(),
                          const SizedBox(height: 20),
                          _buildMainActionButton(),
                          const SizedBox(height: 20),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Row(
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
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
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

  Widget _buildEmailTextField() {
    return SlideTransition(
      position: _slideAnimation,
      child: BlocBuilder<AuthCubit, AuthState>(
        bloc: widget.authCubit,
        buildWhen: (previous, current) =>
            (current is TextFieldState && current.type == TextFieldType.email),
        builder: (context, state) {
          bool b = state is TextFieldState && state.type == TextFieldType.email;
          return MainTextField(
            initialText: widget.authCubit.postSignUpModel.getEmail,
            errorText: b ? state.error : null,
            prefixIcon: Icon(Icons.email, color: context.cs.onSecondary),
            labelText: "email".tr(),
            onChanged: widget.authCubit.setEmail,
            onSubmitted: (_) => emailFocusNode.unfocus,
            focusNode: emailFocusNode,
          );
        },
      ),
    );
  }

  Widget _buildMainActionButton() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: BlocConsumer<AuthCubit, AuthState>(
        bloc: widget.authCubit,
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            MainSnackBar.showSuccessMessage(context, state.message);
            context.router.push(
              VerifyResetCodeRoute(authCubit: widget.authCubit),
            );
          } else if (state is ForgotPasswordFail) {
            MainSnackBar.showErrorMessage(context, state.error);
          }
        },
        builder: (context, state) {
          final isLoading = state is ForgotPasswordLoading;
          return MainActionButton(
            padding: AppConstants.padding8,
            onTap: isLoading ? () {} : onMainActionTap,
            text: 'reset_password'.tr(),
            child: isLoading ? LoadingIndicator(isInBtn: true) : null,
          );
        },
      ),
    );
  }
}
