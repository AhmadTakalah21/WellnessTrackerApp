import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/add_adv_view.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/adv_details_widget.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/app_image_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class AddsAndOffersViewCallBacks {
  void onAdvTap(AdvModel adv);
  void onAdvLongPress(AdvModel adv);
  void onEditTap(AdvModel adv);
  void onDeleteTap(AdvModel adv);
  void onTryAgainTap();
  Future<void> onRefresh();
  void onAddTap();
}

@RoutePage()
class AddsAndOffersView extends StatelessWidget {
  const AddsAndOffersView({super.key, required this.role});

  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<AddsAndOffersCubit>(),
      child: AddsAndOffersPage(role: role),
    );
  }
}

class AddsAndOffersPage extends StatefulWidget {
  const AddsAndOffersPage({super.key, required this.role});

  final UserRoleEnum role;

  @override
  State<AddsAndOffersPage> createState() => _AddsAndOffersPageState();
}

class _AddsAndOffersPageState extends State<AddsAndOffersPage>
    implements AddsAndOffersViewCallBacks {
  late final AddsAndOffersCubit addsAndOffersCubit = context.read();

  @override
  void initState() {
    super.initState();
    addsAndOffersCubit.getAddsAndOffers(widget.role, perPage: 1000000);
  }

  @override
  void onAddTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAdvView(
          advCubit: addsAndOffersCubit,
          onSuccess: () => addsAndOffersCubit.getAddsAndOffers(
            widget.role,
            perPage: 1000000,
          ),
        ),
      ),
    );
  }

  @override
  void onAdvLongPress(AdvModel adv) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (context) => AdditionalOptionsBottomSheet(
        item: adv,
        onEditTap: onEditTap,
        onDeleteTap: onDeleteTap,
      ),
    );
  }

  @override
  void onDeleteTap(AdvModel adv) {
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
          item: adv,
          onSuccess: () {
            Navigator.pop(context);
            addsAndOffersCubit.getAddsAndOffers(widget.role, perPage: 1000000);
          }),
    );
  }

  @override
  void onEditTap(AdvModel adv) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAdvView(
          advCubit: addsAndOffersCubit,
          adv: adv,
          onSuccess: () {
            addsAndOffersCubit.getAddsAndOffers(widget.role, perPage: 1000000);
          },
        ),
      ),
    );
  }

  @override
  void onTryAgainTap() =>
      addsAndOffersCubit.getAddsAndOffers(widget.role, perPage: 1000000);

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onAdvTap(AdvModel adv) {
    showDialog(
      context: context,
      builder: (context) {
        return AdvDetailsWidget(adv: adv);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: widget.role == UserRoleEnum.admin
          ? AppBar(
              centerTitle: true,
              backgroundColor: context.cs.primary,
              elevation: 10,
              title: Text('adds_and_offers'.tr(), style: context.tt.titleLarge),
            )
          : null,
      body: Padding(
        padding: AppConstants.padding16,
        child: BlocBuilder<AddsAndOffersCubit, GeneralAddsAndOffersState>(
          buildWhen: (previous, current) => current is AddsAndOffersState,
          builder: (context, state) {
            if (state is AddsAndOffersLoading) {
              return LoadingIndicator();
            } else if (state is AddsAndOffersSuccess) {
              final data = state.addsAndOffers.data;
              final ads = data.where((ad) => ad.type.isAdv).toList();
              final offers = data.where((ad) => !ad.type.isAdv).toList();
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      SizedBox(height: 10),
                      Text("الإعلانات", style: context.tt.headlineLarge),
                      _buildAdsList(ads, width / 2.4),
                      SizedBox.shrink(),
                      Text("العروض", style: context.tt.headlineLarge),
                      _buildOffersList(offers),
                      if (!widget.role.isUser) SizedBox(height: 80),
                    ],
                  ),
                ),
              );
            } else if (state is AddsAndOffersEmpty) {
              return MainErrorWidget(
                isRefresh: true,
                error: state.message,
                onTryAgainTap: onTryAgainTap,
              );
            } else if (state is AddsAndOffersFail) {
              return MainErrorWidget(
                error: state.error,
                onTryAgainTap: onTryAgainTap,
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
      floatingActionButton: widget.role == UserRoleEnum.admin
          ? Padding(
              padding: AppConstants.padding8,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: AppConstants.borderRadiusCircle,
                ),
                onPressed: onAddTap,
                child: Icon(Icons.add, color: context.cs.secondary, size: 30),
              ),
            )
          : null,
    );
  }

  Widget _buildAdsList(List<AdvModel> ads, double width) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: AppConstants.padding8,
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 20,
        children: List.generate(ads.length, (index) {
          final ad = ads[index];
          return _buildAdvItem(ad, width: width);
        }),
      ),
    );
  }

  Widget _buildOffersList(List<AdvModel> offers) {
    return GridView.builder(
      shrinkWrap: true,
      padding: AppConstants.padding8,
      physics: BouncingScrollPhysics(),
      itemCount: offers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        final offer = offers[index];
        return _buildAdvItem(offer);
      },
    );
  }

  Widget _buildAdvItem(AdvModel adv, {double width = 150}) {
    return InkWell(
      onLongPress: () => onAdvLongPress(adv),
      onTap: () => onAdvTap(adv),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.cs.surface,
          borderRadius: AppConstants.borderRadius30,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              color: AppColors.black.withValues(alpha: 0.3),
              blurRadius: 4,
            )
          ],
        ),
        child: AppImageWidget(
          url: adv.image,
          width: width,
          height: width,
        ),
      ),
    );
  }
}
