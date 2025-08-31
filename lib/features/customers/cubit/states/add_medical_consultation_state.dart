part of '../customers_cubit.dart';

@immutable
sealed class AddMedicalConsultationState extends GeneralCustomersState {}

final class AddMedicalConsultationInitial extends AddMedicalConsultationState {}

final class AddMedicalConsultationLoading extends AddMedicalConsultationState {}

final class AddMedicalConsultationSuccess extends AddMedicalConsultationState {
  final String message;

  AddMedicalConsultationSuccess(this.message);
}

final class AddMedicalConsultationFail extends AddMedicalConsultationState {
  final String error;

  AddMedicalConsultationFail(this.error);
}
