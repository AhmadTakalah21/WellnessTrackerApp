part of 'auth_manager_bloc.dart';

abstract class AuthManagerEvent {
  const AuthManagerEvent();
}

class IsAuthenticatedOrFirstTime extends AuthManagerEvent {}

class ShowSignIn extends AuthManagerEvent {
  const ShowSignIn({
    this.showBackButton = false,
    this.onSignedIn,
  });

  final bool showBackButton;
  final VoidCallback? onSignedIn;
}

class SignInRequested extends AuthManagerEvent {
  const SignInRequested(
    this.signInModel, {
    this.onSuccess,
  });

  final SignInModel signInModel;
  final VoidCallback? onSuccess;
}

class SignUpRequested extends AuthManagerEvent {
  const SignUpRequested(
    this.signInModel, {
    this.onSuccess,
  });

  final SignInModel signInModel;
  final VoidCallback? onSuccess;
}

class ProfileFormCompletedRequested extends AuthManagerEvent {}

class SignOutRequested extends AuthManagerEvent {}

class GuestRequested extends AuthManagerEvent {}

class VerifyRequested extends AuthManagerEvent {
  const VerifyRequested(this.email, this.message);

  final String email;
  final String message;
}

class ForgetPasswordRequested extends AuthManagerEvent {
  const ForgetPasswordRequested();
}

