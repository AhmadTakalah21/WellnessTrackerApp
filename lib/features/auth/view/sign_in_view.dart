import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/features/auth/view/widgets/another_way_sign_in_button.dart';
import 'package:wellnesstrackerapp/features/auth/view/widgets/contact_options_widget.dart';
import 'package:wellnesstrackerapp/features/settings/cubit/settings_cubit.dart';
import 'package:wellnesstrackerapp/features/settings/model/settings_model/settings_model.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field.dart';
import 'package:wellnesstrackerapp/global/widgets/phone_text_field.dart';

abstract class SignInViewCallbacks {
  void onEmailSubmitted(String email);
  void onPasswordSubmitted(String password);
  void onConfirmTermsAndConditionsTap(bool? isChecked);
  void onTermsAndConditionsTap();
  void onGetCodeTap(SettingsModel? setting);
  Future<void> onLaunchPhoneTap(String? whatsappPhone);
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => get<AuthCubit>()),
        BlocProvider(create: (context) => get<SettingsCubit>()),
      ],
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
  late final SettingsCubit settingsCubit = context.read();
  bool? _rememberMe = false;
  final _formKey = GlobalKey<FormState>();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final emailFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
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
    settingsCubit.getSettings();
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
  void onEmailSubmitted(String email) {
    if (isShowSignIn) {
      passwordFocusNode.requestFocus();
    } else {
      usernameFocusNode.requestFocus();
    }
  }

  @override
  void onPasswordSubmitted(String password) {
    if (isShowSignIn) {
      onMainAction();
    } else {
      confirmPasswordFocusNode.requestFocus();
    }
  }

  @override
  void onForgetPasswordTap() =>
      context.router.push(ForgotPasswordRoute(authCubit: authCubit));

  @override
  void onTermsAndConditionsTap() =>
      context.router.push(TermsAndConditionsRoute());

  @override
  void onGetCodeTap(SettingsModel? setting) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (context) => ContactOptionsWidget(setting: setting),
    );
  }

  @override
  Future<void> onLaunchPhoneTap(String? whatsappPhone) async {
    if (whatsappPhone == null || whatsappPhone.isEmpty) return;

    final cleaned = whatsappPhone.replaceAll(RegExp(r'[^\d]'), '');
    final message = Uri.encodeComponent("مرحباً، أحتاج كود الاشتراك");
    final url = "https://wa.me/$cleaned?text=$message";

    final success =
        await launchUrlString(url, mode: LaunchMode.externalApplication);
    if (!success && context.mounted) {
      if (mounted) {
        MainSnackBar.showErrorMessage(context, "cant_open_whatsapp".tr());
      }
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
  void onMainAction() {
    if (_formKey.currentState!.validate()) {
      if (isShowSignIn) {
        authCubit.signIn();
      } else {
        authCubit.signUp();
      }
    } else {
      MainSnackBar.showErrorMessage(context, "plz_accept".tr(),
          flushbarPosition: FlushbarPosition.BOTTOM);
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
  void dispose() {
    emailFocusNode.dispose();
    usernameFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    codeFocusNode.dispose();
    _controller.dispose();
    super.dispose();
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
                    color: context.cs.surface,
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
                          _buildMobileNumebrField(),
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
              AppConstants.appName,
              style: context.tt.headlineMedium?.copyWith(
                color: context.cs.surface,
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
          onChanged: authCubit.setEmail,
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
                onChanged: authCubit.setUsername,
                onSubmitted: (_) => phoneFocusNode.requestFocus(),
                focusNode: usernameFocusNode,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMobileNumebrField() {
    return AnimatedSizeAndFade.showHide(
      show: !isShowSignIn,
      child: Column(
        children: [
          SizedBox(height: 10),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) => (current is TextFieldState &&
                current.type == TextFieldType.phone),
            builder: (context, state) {
              final isBuild =
                  state is TextFieldState && state.type == TextFieldType.phone;
              return PhoneTextField(
                focusNode: phoneFocusNode,
                onChanged: authCubit.setPhone,
                onSubmitted: (_) => passwordFocusNode.requestFocus(),
                errorText: isBuild ? state.error : null,
                prefixIcon: Icon(Icons.phone, color: context.cs.onSecondary),
                labelText: "phone_number".tr(),
                textInputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
          onChanged: authCubit.setPassword,
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
                onChanged: authCubit.setConfirmPassword,
                onSubmitted: (_) => codeFocusNode.requestFocus(),
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
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => current is SubscriptionExpiredState,
      builder: (context, state) {
        return AnimatedSizeAndFade.showHide(
          show: !isShowSignIn || state is SubscriptionExpiredState,
          child: Column(
            children: [
              SizedBox(height: 5),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) => (current is TextFieldState &&
                    current.type == TextFieldType.code),
                builder: (context, innerState) {
                  final isBuild = innerState is TextFieldState &&
                      innerState.type == TextFieldType.code;
                  return MainTextField(
                    errorText: isBuild ? innerState.error : null,
                    labelText: "subscription_code".tr(),
                    onChanged: authCubit.setSubscriptionCode,
                    onSubmitted: (_) => codeFocusNode.unfocus(),
                    focusNode: codeFocusNode,
                    prefixIcon: const Icon(Icons.key, color: Colors.black54),
                  );
                },
              ),
              const SizedBox(height: 10),
              BlocBuilder<SettingsCubit, GeneralSettingsState>(
                buildWhen: (previous, current) => current is SettingsState,
                builder: (context, state) {
                  SettingsModel? settings;
                  if (state is SettingsSuccess) {
                    settings = state.settings;
                  }
                  return Center(
                    child: InkWell(
                      onTap: () => onGetCodeTap(settings),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            "assets/images/whatsapp.svg",
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              context.cs.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "get_code_via_whatsapp".tr(),
                            style: context.tt.bodyLarge?.copyWith(
                              color: context.cs.primary,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTermsAndForgetPassword() {
    return Row(
      children: [
        Form(
          key: _formKey,
          child: FormField<bool>(
            builder: (field) {
              final color =
                  field.hasError ? context.cs.error : context.cs.secondary;
              return Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: onConfirmTermsAndConditionsTap,
                    side: BorderSide(color: color),
                    checkColor: context.cs.surface,
                    activeColor: context.cs.primary,
                  ),
                  InkWell(
                    onTap: onTermsAndConditionsTap,
                    child: Text(
                      'accept_terms'.tr(),
                      style: TextStyle(
                        color: color,
                        decorationColor: color,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              );
            },
            validator: (_) =>
                _rememberMe == null || !_rememberMe! ? "required".tr() : null,
          ),
        ),
        Expanded(
          child: AnimatedSizeAndFade(
            child: isShowSignIn
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: onForgetPasswordTap,
                          child: Text(
                            'forgot_password?'.tr(),
                            style: context.tt.labelLarge?.copyWith(
                              color: context.cs.primary,
                            ),
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ),
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
        return Row(
          children: [
            Expanded(
              child: MainActionButton(
                padding: AppConstants.padding10,
                onTap: onMainAction,
                text: isShowSignIn ? "login".tr() : "sign_up".tr(),
                fontSize: 18,
                borderRadius: AppConstants.borderRadius10,
                isLoading: state is SignInLoading,
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
        spacing: 6,
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
}
