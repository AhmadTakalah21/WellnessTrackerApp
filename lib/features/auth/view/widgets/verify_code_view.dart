import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/auth/cubit/auth_cubit.dart';
import 'package:wellnesstrackerapp/global/router/app_router.gr.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field.dart';

abstract class VerifyResetCodeViewCallbacks {
  void onVerifyTap();
  void onBackToLoginTap();
}

@RoutePage()
class VerifyResetCodeView extends StatelessWidget {
  const VerifyResetCodeView({super.key, required this.authCubit});

  final AuthCubit authCubit;

  @override
  Widget build(BuildContext context) {
    return _VerifyResetCodePage(authCubit: authCubit);
  }
}

class _VerifyResetCodePage extends StatefulWidget {
  const _VerifyResetCodePage({required this.authCubit});

  final AuthCubit authCubit;

  @override
  State<_VerifyResetCodePage> createState() => _VerifyResetCodePageState();
}

class _VerifyResetCodePageState extends State<_VerifyResetCodePage>
    with SingleTickerProviderStateMixin
    implements VerifyResetCodeViewCallbacks {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  final _codeFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slide = Tween<Offset>(begin: const Offset(0, .2), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _codeFocus.dispose();
    super.dispose();
  }

  @override
  void onVerifyTap() => widget.authCubit.verifyResetCode();

  @override
  void onBackToLoginTap() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            color: context.cs.primary,
            child: FadeTransition(
              opacity: _fade,
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
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _slide,
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        const SizedBox(height: 20),
                        FadeTransition(
                          opacity: _fade,
                          child: Text(
                            'verify_code'.tr(),
                            style: context.tt.headlineMedium?.copyWith(
                              color: context.cs.primary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildCodeTextField(),
                        const SizedBox(height: 20),
                        _buildMainActionButton(),
                        const SizedBox(height: 20),
                        FadeTransition(
                          opacity: _fade,
                          child: GestureDetector(
                            onTap: onBackToLoginTap,
                            child: Text(
                              'back_to_login'.tr(),
                              style: TextStyle(
                                color: context.cs.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ]),
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

  Widget _buildCodeTextField() {
    return SlideTransition(
      position: _slide,
      child: BlocBuilder<AuthCubit, AuthState>(
        bloc: widget.authCubit,
        buildWhen: (prev, curr) =>
            curr is TextFieldState && curr.type == TextFieldType.code,
        builder: (context, state) {
          bool b = state is TextFieldState && state.type == TextFieldType.code;
          return MainTextField(
            initialText: widget.authCubit.resetCode ?? '',
            errorText: b ? state.error : null,
            prefixIcon: Icon(Icons.verified, color: context.cs.onSecondary),
            labelText: 'enter_code'.tr(),
            textInputType: TextInputType.number,
            onChanged: widget.authCubit.setResetCode,
            onSubmitted: (_) => _codeFocus.unfocus(),
            focusNode: _codeFocus,
          );
        },
      ),
    );
  }

  Widget _buildMainActionButton() {
    return FadeTransition(
      opacity: _fade,
      child: BlocConsumer<AuthCubit, AuthState>(
        bloc: widget.authCubit,
        listener: (context, state) {
          if (state is VerifyResetCodeSuccess) {
            MainSnackBar.showSuccessMessage(context, state.message);
            context.router.push(
              ResetPasswordRoute(authCubit: widget.authCubit),
            );
          } else if (state is VerifyResetCodeFail) {
            MainSnackBar.showErrorMessage(context, state.error);
          }
        },
        builder: (context, state) {
          return MainActionButton(
            padding: AppConstants.padding8,
            onTap:onVerifyTap,
            text: 'confirm'.tr(),
            isLoading: state is VerifyResetCodeLoading,
          );
        },
      ),
    );
  }
}
