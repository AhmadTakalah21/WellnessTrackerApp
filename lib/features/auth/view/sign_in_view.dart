import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/features/auth/view/profile_form_view.dart';
import 'package:wellnesstrackerapp/features/auth/view/widgets/another_way_sign_in_button.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field.dart';

abstract class SignInViewCallbacks {
  void onEmailChanged(String email);
  void onEmailSubmitted(String email);
  void onUsernameChanged(String username);
  void onUsernameSubmitted(String username);
  void onPasswordChanged(String password);
  void onPasswordSubmitted(String password);
  void onConfirmPasswordChanged(String confirmPassword);
  void onConfirmPasswordSubmitted(String confirmPassword);
  void onForgetPasswordTap();
  void onShowPassword();
  void onMainAction();
  void onShowSignInOrUp();
}

@RoutePage()
class SignInView extends StatelessWidget {
  const SignInView({super.key, this.onSignedIn});

  final VoidCallback? onSignedIn;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<AuthCubit>(),
      child: SignInPage(onSignedIn: onSignedIn),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, this.onSignedIn});

  final VoidCallback? onSignedIn;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage>
    with SingleTickerProviderStateMixin
    implements SignInViewCallbacks {
  late final AuthCubit authCubit = context.read();
  bool _rememberMe = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final emailFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  bool isShowSignIn = true;
  bool isObsecurePassword = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppConstants.duration1500ms,
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void onEmailChanged(String email) => authCubit.setEmail(email);

  @override
  void onEmailSubmitted(String email) {
    if (isShowSignIn) {
      passwordFocusNode.requestFocus();
    } else {
      usernameFocusNode.requestFocus();
    }
  }

  @override
  void onPasswordChanged(String password) => authCubit.setPassword(password);

  @override
  void onPasswordSubmitted(String password) {
    if (isShowSignIn) {
      onMainAction();
    } else {
      confirmPasswordFocusNode.requestFocus();
    }
  }

  @override
  void onConfirmPasswordChanged(String confirmPassword) =>
      authCubit.setConfirmPassword(confirmPassword);

  @override
  void onConfirmPasswordSubmitted(String confirmpassword) =>
      confirmPasswordFocusNode.unfocus();

  @override
  void onForgetPasswordTap() =>
      context.router.push(ForgotPasswordRoute(authCubit: authCubit));

  @override
  void onUsernameChanged(String username) => authCubit.setUsername(username);

  @override
  void onUsernameSubmitted(String username) => passwordFocusNode.requestFocus();

  @override
  void onShowPassword() =>
      setState(() => isObsecurePassword = !isObsecurePassword);

  @override
  void onShowSignInOrUp() {
    setState(() {
      isShowSignIn = !isShowSignIn;
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void onMainAction() {
    if (isShowSignIn) {
      authCubit.signIn();
    } else {
      authCubit.signUp();
    }
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
                    'Health & Wellness App',
                    style: context.tt.headlineMedium?.copyWith(
                      color: context.cs.onSurface,
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
                  decoration: BoxDecoration(
                    color: context.cs.onSurface,
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
                            isShowSignIn ? "login".tr() : "sign_up".tr(),
                            style: context.tt.headlineMedium?.copyWith(
                              color: context.cs.primary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<AuthCubit, AuthState>(
                            buildWhen:
                                (previous, current) =>
                                    (current is TextFieldState &&
                                        current.type == TextFieldType.email),
                            builder: (context, state) {
                              return MainTextField(
                                errorText:
                                    state is TextFieldState &&
                                            state.type == TextFieldType.email
                                        ? state.error
                                        : null,
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: context.cs.onSecondary,
                                ),
                                labelText: "email".tr(),
                                onChanged: onEmailChanged,
                                onSubmitted: onEmailSubmitted,
                                focusNode: emailFocusNode,
                                textInputType: TextInputType.emailAddress,
                              );
                            },
                          ),
                          AnimatedSizeAndFade.showHide(
                            show: !isShowSignIn,
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                BlocBuilder<AuthCubit, AuthState>(
                                  buildWhen:
                                      (previous, current) =>
                                          (current is TextFieldState &&
                                              current.type ==
                                                  TextFieldType.username),
                                  builder: (context, state) {
                                    return MainTextField(
                                      errorText:
                                          state is TextFieldState &&
                                                  state.type ==
                                                      TextFieldType.username
                                              ? state.error
                                              : null,
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: context.cs.onSecondary,
                                      ),
                                      labelText: "username".tr(),
                                      onChanged: onUsernameChanged,
                                      onSubmitted: onUsernameSubmitted,
                                      focusNode: usernameFocusNode,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          BlocBuilder<AuthCubit, AuthState>(
                            buildWhen:
                                (previous, current) =>
                                    (current is TextFieldState &&
                                        current.type == TextFieldType.password),
                            builder: (context, state) {
                              return MainTextField(
                                obscureText: isObsecurePassword,
                                errorText:
                                    state is TextFieldState &&
                                            state.type == TextFieldType.password
                                        ? state.error
                                        : null,
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
                              );
                            },
                          ),
                          AnimatedSizeAndFade.showHide(
                            show: !isShowSignIn,
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                BlocBuilder<AuthCubit, AuthState>(
                                  buildWhen:
                                      (previous, current) =>
                                          (current is TextFieldState &&
                                              current.type ==
                                                  TextFieldType
                                                      .confirmPassword),
                                  builder: (context, state) {
                                    return MainTextField(
                                      obscureText: isObsecurePassword,
                                      errorText:
                                          state is TextFieldState &&
                                                  state.type ==
                                                      TextFieldType
                                                          .confirmPassword
                                              ? state.error
                                              : null,
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
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          AnimatedSizeAndFade.showHide(
                            show: !isShowSignIn,
                            child: Column(
                              children: [
                                MainTextField(
                                  prefixIcon: Icon(Icons.key, color: context.cs.onSecondary),
                                  labelText: "subscription_code".tr(),
                                  onChanged: (code) {
                                  },
                                ),

                                const SizedBox(height: 10),

                                Center(
                                  child: InkWell(
                                    onTap: () async {
                                      final uri = Uri.parse("https://wa.me/963XXXXXXXXX?text=مرحباً، أحتاج كود الاشتراك");
                                      if (await canLaunchUrl(uri)) {
                                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                                      } else {
                                        MainSnackBar.showErrorMessage(context, "لا يمكن فتح واتساب حالياً");
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.phone_bluetooth_speaker_outlined, size: 18, color: context.cs.primary),
                                        const SizedBox(width: 6),
                                        Text(
                                          "get_code_via_whatsapp".tr(),
                                          style: context.tt.bodyMedium?.copyWith(
                                            color: context.cs.primary,
                                            fontWeight: FontWeight.w600,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 10),
                              ],
                            ),
                          ),


                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value!;
                                      });
                                    },
                                    side: BorderSide(
                                      color: context.cs.secondary,
                                    ),
                                    checkColor: context.cs.onSurface,
                                    activeColor: context.cs.primary,
                                  ),
                                  Text('accept_terms'.tr()),
                                ],
                              ),
                              AnimatedSizeAndFade(
                                child:
                                    isShowSignIn
                                        ? TextButton(
                                          onPressed: onForgetPasswordTap,
                                          child: Text(
                                            'forgot_password?'.tr(),
                                            style: context.tt.labelLarge
                                                ?.copyWith(
                                                  color: context.cs.primary,
                                                ),
                                          ),
                                        )
                                        : SizedBox.shrink(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          BlocConsumer<AuthCubit, AuthState>(
                            buildWhen: (previous, current) => current is SignInState,
                            listener: (context, state) {
                              if (state is SignInSuccess) {
                                MainSnackBar.showSuccessMessage(
                                  context,
                                  state.message,
                                );
                                widget.onSignedIn?.call();
                              } else if (state is SignUpSuccess) {
                                MainSnackBar.showSuccessMessage(
                                  context,
                                  "تم إنشاء الحساب بنجاح",
                                );
                                context.router.push(const CompleteProfileFormRoute());

                              } else if (state is SignInFail) {
                                context.router.push(const CompleteProfileFormRoute());
                                MainSnackBar.showErrorMessage(
                                  context,
                                  state.error,
                                );
                              }
                            },
                            builder: (context, state) {
                              var onTap = onMainAction;
                              Widget? child;
                              if (state is SignInLoading) {
                                child = const LoadingIndicator(size: 20);
                                onTap = () {};
                              }
                              return Row(
                                children: [
                                  Expanded(
                                    child: MainActionButton(
                                      padding: AppConstants.padding10,
                                      onTap: onTap,
                                      text: isShowSignIn ? "login".tr() : "sign_up".tr(),
                                      fontSize: 18,
                                      borderRadius: AppConstants.borderRadius10,
                                      child: child,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 20),
                          Text('or_continue_with'.tr()),
                          const SizedBox(height: 20),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Row(
                              children: [
                                Expanded(
                                  child: AnotherWaySignInButton(
                                    image: 'assets/images/icons8-facebook-48.png',
                                    text: 'Facebook',
                                    onPressed: () {
                                      // TODO: استدعِ loginWithFacebook هنا
                                      print('Facebook login');
                                    },
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: AnotherWaySignInButton(
                                    image: 'assets/images/icons8-google-48.png',
                                    text: 'Google',
                                    onPressed: () {
                                      // TODO: استدعِ loginWithGoogle هنا
                                      print('Google login');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isShowSignIn
                                    ? "not_have_account".tr()
                                    : "already_have_account".tr(),
                              ),
                              GestureDetector(
                                onTap: onShowSignInOrUp,
                                child: Text(
                                  isShowSignIn ? "sign_up".tr() : "login".tr(),
                                  style: TextStyle(
                                    color: context.cs.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 100),
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

  // PageRouteBuilder _createRoute(Widget page) {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => page,
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(1.0, 0.0);
  //       const end = Offset.zero;
  //       const curve = Curves.easeInOut;

  //       var tween = Tween(
  //         begin: begin,
  //         end: end,
  //       ).chain(CurveTween(curve: curve));

  //       return SlideTransition(position: animation.drive(tween), child: child);
  //     },
  //   );
  // }
}
