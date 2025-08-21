part of 'app_manager_cubit.dart';

@immutable
sealed class AppManagerState {}

final class AppManagerInitial extends AppManagerState {}

final class BottomNavTabChanged extends AppManagerState {
  final int index;

  BottomNavTabChanged(this.index);
}
