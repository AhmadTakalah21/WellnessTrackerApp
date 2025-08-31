part of '../customers_cubit.dart';

abstract class GeneralCustomersState {}

class GeneralCustomersInitial extends GeneralCustomersState {}

class SelectedSpecialistsState extends GeneralCustomersState {
  final UserModel? selectedDietitian;
  final UserModel? selectedCoach;
  final UserModel? selectedDoctor;
  final UserModel? selectedPsychologist;

  SelectedSpecialistsState(
    this.selectedDietitian,
    this.selectedCoach,
    this.selectedDoctor,
    this.selectedPsychologist,
  );
}
