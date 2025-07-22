part of 'app_manager_cubit.dart';

@immutable
sealed class AppManagerState {}

final class AppManagerInitial extends AppManagerState {}

// final class LanguageChanged extends AppManagerState {
//   final Locale locale;

//   LanguageChanged(this.locale);
// }

//final class InnerRouteChanged extends AppManagerState {}
