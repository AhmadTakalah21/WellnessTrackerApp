import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/cubit/adds_and_offers_cubit.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/add_adv_view.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/adv_details_widget.dart';
import 'package:wellnesstrackerapp/global/blocs/delete_cubit/cubit/delete_cubit.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class AddsAndOffersViewCallBacks {
  void onAdvTap(AdvModel adv);
  void onAdvLongPress(AdvModel adv);
  void onEditTap(AdvModel adv);
  void onDeleteTap(AdvModel adv);
  void onTryAgainTap();
  void onAddTap();
}

@RoutePage()
class AddsAndOffersView extends StatelessWidget {
  const AddsAndOffersView({super.key, required this.role});

  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => get<AddsAndOffersCubit>(),
        ),
        BlocProvider(create: (context) => get<DeleteCubit>()),
      ],
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
  late final DeleteCubit deleteCubit = context.read();

  @override
  void initState() {
    super.initState();
    addsAndOffersCubit.getAddsAndOffers(widget.role, perPage: null);
  }

  @override
  void onAddTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAdvView(
          advCubit: addsAndOffersCubit,
          isEdit: false,
          onSuccess: () =>
              addsAndOffersCubit.getAddsAndOffers(widget.role, perPage: null),
        ),
      ),
    );
  }

  @override
  void onAdvLongPress(AdvModel adv) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Row(
        children: [
          Expanded(
            child: Padding(
              padding: AppConstants.padding16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "additional_options".tr(),
                      style: context.tt.headlineMedium,
                    ),
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.edit),
                    onPressed: () => onEditTap(adv),
                    label: Text(
                      "edit".tr(),
                      style: context.tt.labelMedium?.copyWith(
                        color: context.cs.primary,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.delete, color: context.cs.error),
                    onPressed: () => onDeleteTap(adv),
                    label: Text(
                      "delete".tr(),
                      style: context.tt.labelMedium?.copyWith(
                        color: context.cs.error,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onDeleteTap(AdvModel adv) {
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
        deleteCubit: deleteCubit,
        item: adv,
        onSaveTap: (c) => deleteCubit.deleteItem<AdvModel>(adv),
        onSuccess: () =>
            addsAndOffersCubit.getAddsAndOffers(widget.role, perPage: null),
      ),
    );
  }

  @override
  void onEditTap(AdvModel adv) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAdvView(
          advCubit: addsAndOffersCubit,
          isEdit: true,
          adv: adv,
          onSuccess: () {
            addsAndOffersCubit.getAddsAndOffers(widget.role, perPage: null);
          },
        ),
      ),
    );
  }

  @override
  void onTryAgainTap() =>
      addsAndOffersCubit.getAddsAndOffers(widget.role, perPage: null);

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
          builder: (context, state) {
            if (state is AddsAndOffersLoading) {
              return LoadingIndicator();
            } else if (state is AddsAndOffersSuccess) {
              final data = state.addsAndOffers.data;
              final ads = data.where((ad) => ad.type.isAdv).toList();
              final offers = data.where((ad) => !ad.type.isAdv).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  SizedBox(height: 10),
                  Text("الإعلانات", style: context.tt.headlineLarge),
                  _buildAdsList(ads),
                  SizedBox.shrink(),
                  Text("العروض", style: context.tt.headlineLarge),
                  _buildOffersList(offers),
                  if (widget.role != UserRoleEnum.admin) SizedBox(height: 70),
                ],
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

  Widget _buildAdsList(List<AdvModel> ads) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: AppConstants.padding8,
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 20,
        children: List.generate(ads.length, (index) {
          final ad = ads[index];
          return _buildAdvItem(ad);
        }),
      ),
    );
  }

  Widget _buildOffersList(List<AdvModel> offers) {
    return Expanded(
      child: GridView.builder(
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
      ),
    );
  }

  Widget _buildAdvItem(AdvModel adv) {
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
        child: Image.asset(
          "assets/images/app_logo.png",
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
