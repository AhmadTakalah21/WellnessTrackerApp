import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
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
  void onCodeChanged(String code);
  void onCodeSubmitted(String code);
  void onConfirmTermsAndConditionsTap(bool? isChecked);
  Future<void> onGetCodeTap();
  void onForgetPasswordTap();
  void onShowPassword();
  void onMainAction();
  void onLoginWithFacebookTap();
  void onLoginWithGoogleTap();
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
  bool? _rememberMe = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final emailFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final codeFocusNode = FocusNode();

  bool isShowSignIn = true;
  bool isObsecure = true;

  late List<AnotherWaySignInButton> otherWaysButtons = [
    AnotherWaySignInButton(
      image: 'assets/images/icons8-facebook-48.png',
      text: 'Facebook',
      onPressed: onLoginWithFacebookTap,
    ),
    AnotherWaySignInButton(
      image: 'assets/images/icons8-google-48.png',
      text: 'Google',
      onPressed: onLoginWithGoogleTap,
    ),
  ];

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
      codeFocusNode.requestFocus();

  @override
  void onCodeChanged(String code) => authCubit.setSubscriptionCode(code);

  @override
  void onCodeSubmitted(String code) => codeFocusNode.unfocus();

  @override
  void onForgetPasswordTap() =>
      context.router.push(ForgotPasswordRoute(authCubit: authCubit));

  @override
  void onUsernameChanged(String username) => authCubit.setUsername(username);

  @override
  void onUsernameSubmitted(String username) => passwordFocusNode.requestFocus();

  @override
  Future<void> onGetCodeTap() async {
    final uri =
        Uri.parse("https://wa.me/963XXXXXXXXX?text=مرحباً، أحتاج كود الاشتراك");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      MainSnackBar.showErrorMessage(context, "لا يمكن فتح واتساب حالياً");
    }
  }

  @override
  void onShowPassword() => setState(() => isObsecure = !isObsecure);

  @override
  void onConfirmTermsAndConditionsTap(bool? isChecked) {
    setState(() {
      _rememberMe = isChecked;
    });
  }

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
    codeFocusNode.dispose();
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
  void onLoginWithFacebookTap() {
    // TODO: implement onLoginWithFacebookTap
  }

  @override
  void onLoginWithGoogleTap() {
    // TODO: implement onLoginWithGoogleTap
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildHeader(),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    color: context.cs.onSurface,
                    borderRadius: AppConstants.borderRadiusTlTr30,
                  ),
                  child: Padding(
                    padding: AppConstants.paddingH20,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _buildTitle(),
                          const SizedBox(height: 20),
                          _buildEmailTextField(),
                          _buildUsernameTextField(),
                          SizedBox(height: 10),
                          _buildPasswordTextField(),
                          _buildConfirmPasswordTextField(),
                          SizedBox(height: 10),
                          _buildCodeTextField(),
                          const SizedBox(height: 10),
                          _buildTermsAndForgetPassword(),
                          const SizedBox(height: 20),
                          _buildMainActionBtn(),
                          const SizedBox(height: 20),
                          _buildContinueWithText(),
                          const SizedBox(height: 20),
                          _buildOtherWaysSignIn(),
                          const SizedBox(height: 20),
                          _buildGoSignInOrUp(),
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

  Widget _buildHeader() {
    return Container(
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
    );
  }

  Widget _buildTitle() {
    final title = isShowSignIn ? "login".tr() : "sign_up".tr();
    return Text(
      title,
      style: context.tt.headlineMedium?.copyWith(
        color: context.cs.primary,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          (current is TextFieldState && current.type == TextFieldType.email),
      builder: (context, state) {
        final isBuild =
            state is TextFieldState && state.type == TextFieldType.email;
        return MainTextField(
          errorText: isBuild ? state.error : null,
          prefixIcon: Icon(Icons.email, color: context.cs.onSecondary),
          labelText: "email".tr(),
          onChanged: onEmailChanged,
          onSubmitted: onEmailSubmitted,
          focusNode: emailFocusNode,
          textInputType: TextInputType.emailAddress,
        );
      },
    );
  }

  Widget _buildUsernameTextField() {
    return AnimatedSizeAndFade.showHide(
      show: !isShowSignIn,
      child: Column(
        children: [
          SizedBox(height: 10),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) => (current is TextFieldState &&
                current.type == TextFieldType.username),
            builder: (context, state) {
              final isBuild = state is TextFieldState &&
                  state.type == TextFieldType.username;
              return MainTextField(
                errorText: isBuild ? state.error : null,
                prefixIcon: Icon(Icons.person, color: context.cs.onSecondary),
                labelText: "username".tr(),
                onChanged: onUsernameChanged,
                onSubmitted: onUsernameSubmitted,
                focusNode: usernameFocusNode,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          (current is TextFieldState && current.type == TextFieldType.password),
      builder: (context, state) {
        final isBuild =
            state is TextFieldState && state.type == TextFieldType.password;
        return MainTextField(
          obscureText: isObsecure,
          errorText: isBuild ? state.error : null,
          labelText: "password".tr(),
          onChanged: onPasswordChanged,
          onSubmitted: onPasswordSubmitted,
          focusNode: passwordFocusNode,
          prefixIcon: Icon(Icons.lock, color: context.cs.onSecondary),
          suffixIcon: IconButton(
            icon: Icon(
              isObsecure ? Icons.visibility : Icons.visibility_off,
              color: context.cs.onSecondary,
            ),
            onPressed: onShowPassword,
          ),
        );
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return AnimatedSizeAndFade.showHide(
      show: !isShowSignIn,
      child: Column(
        children: [
          SizedBox(height: 10),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) => (current is TextFieldState &&
                current.type == TextFieldType.confirmPassword),
            builder: (context, state) {
              final isBuild = state is TextFieldState &&
                  state.type == TextFieldType.confirmPassword;
              return MainTextField(
                obscureText: isObsecure,
                errorText: isBuild ? state.error : null,
                labelText: "confirm_password".tr(),
                onChanged: onConfirmPasswordChanged,
                onSubmitted: onConfirmPasswordSubmitted,
                focusNode: confirmPasswordFocusNode,
                prefixIcon: const Icon(Icons.lock, color: Colors.black54),
                suffixIcon: IconButton(
                  icon: Icon(
                    isObsecure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black54,
                  ),
                  onPressed: onShowPassword,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCodeTextField() {
    return AnimatedSizeAndFade.showHide(
      show: !isShowSignIn,
      child: Column(
        children: [
          SizedBox(height: 5),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) => (current is TextFieldState &&
                current.type == TextFieldType.code),
            builder: (context, state) {
              final isBuild =
                  state is TextFieldState && state.type == TextFieldType.code;
              return MainTextField(
                errorText: isBuild ? state.error : null,
                labelText: "subscription_code".tr(),
                onChanged: onCodeChanged,
                onSubmitted: onCodeSubmitted,
                focusNode: codeFocusNode,
                prefixIcon: const Icon(Icons.key, color: Colors.black54),
              );
            },
          ),
          const SizedBox(height: 10),
          Center(
            child: InkWell(
              onTap: onGetCodeTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_bluetooth_speaker_outlined,
                      size: 18, color: context.cs.primary),
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
    );
  }

  Widget _buildTermsAndForgetPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: onConfirmTermsAndConditionsTap,
              side: BorderSide(color: context.cs.secondary),
              checkColor: context.cs.onSurface,
              activeColor: context.cs.primary,
            ),
            Text('accept_terms'.tr()),
          ],
        ),
        AnimatedSizeAndFade(
          child: isShowSignIn
              ? TextButton(
                  onPressed: onForgetPasswordTap,
                  child: Text(
                    'forgot_password?'.tr(),
                    style: context.tt.labelLarge?.copyWith(
                      color: context.cs.primary,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildMainActionBtn() {
    return BlocConsumer<AuthCubit, AuthState>(
      buildWhen: (previous, current) => current is SignInState,
      listener: (context, state) {
        if (state is SignInSuccess) {
          MainSnackBar.showSuccessMessage(context, state.message);
          widget.onSignedIn?.call();
        } else if (state is SignUpSuccess) {
          MainSnackBar.showSuccessMessage(context, state.message);
        } else if (state is SignInFail) {
          MainSnackBar.showErrorMessage(context, state.error);
        }
      },
      builder: (context, state) {
        var onTap = onMainAction;
        Widget? child;
        if (state is SignInLoading) {
          child = LoadingIndicator(size: 30, color: context.cs.surface);
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
    );
  }

  Widget _buildContinueWithText() => Text('or_continue_with'.tr());

  Widget _buildOtherWaysSignIn() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Row(
        spacing: 12,
        children: otherWaysButtons.map((btn) => btn).toList(),
      ),
    );
  }

  Widget _buildGoSignInOrUp() {
    final text1 =
        isShowSignIn ? "not_have_account".tr() : "already_have_account".tr();
    final text2 = isShowSignIn ? "sign_up".tr() : "login".tr();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text1),
        GestureDetector(
          onTap: onShowSignInOrUp,
          child: Text(
            text2,
            style: TextStyle(
              color: context.cs.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
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
