part of '../adds_and_offers_cubit.dart';

@immutable
sealed class AddsAndOffersState extends GeneralAddsAndOffersState {}

class AddsAndOffersInitial extends AddsAndOffersState {}

class AddsAndOffersLoading extends AddsAndOffersState {}

class AddsAndOffersSuccess extends AddsAndOffersState {
  final PaginatedModel<AdvModel> addsAndOffers;
  final String? emptyMessage;

  AddsAndOffersSuccess(this.addsAndOffers, this.emptyMessage);
}

class AddsAndOffersEmpty extends AddsAndOffersState {
  final String message;

  AddsAndOffersEmpty(this.message);
}

class AddsAndOffersFail extends AddsAndOffersState {
  final String error;

  AddsAndOffersFail(this.error);
}
