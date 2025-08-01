part of 'auth_manager_bloc.dart';

abstract class GeneralAuthManagerState {
  const GeneralAuthManagerState();
}

class InitialAuthManagerState extends GeneralAuthManagerState {}

class FirstTimeState extends GeneralAuthManagerState {}

class ShowSignInState extends GeneralAuthManagerState {
  const ShowSignInState({this.action});

  final VoidCallback? action;
}

class ProfileFormState extends GeneralAuthManagerState {}

// class ProfileFormCompletedState extends GeneralAuthManagerState {}

class AuthenticatedState extends GeneralAuthManagerState {
  final SignInModel user;
  AuthenticatedState(this.user);
}

// class SignedUpState extends GeneralAuthManagerState {
//   final SignInModel user;

//   SignedUpState(this.user);
// }

//class AuthenticatedWithoutHealthAssesmentState extends GeneralAuthManagerState {}

class UnauthenticatedState extends GeneralAuthManagerState {}

class GuestState extends GeneralAuthManagerState {}

class VerificationState extends GeneralAuthManagerState {}

class ForgetPasswordState extends GeneralAuthManagerState {}
