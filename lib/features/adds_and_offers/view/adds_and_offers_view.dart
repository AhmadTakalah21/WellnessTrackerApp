import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/features/adds_and_offers/view/widgets/adv_details_widget.dart';
import 'package:wellnesstrackerapp/global/models/adv_type_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class AddsAndOffersViewCallBacks {
  void onAdvTap(AdvModel adv);
}

@RoutePage()
class AddsAndOffersView extends StatelessWidget {
  const AddsAndOffersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AddsAndOffersPage();
  }
}

class AddsAndOffersPage extends StatefulWidget {
  const AddsAndOffersPage({super.key});

  @override
  State<AddsAndOffersPage> createState() => _AddsAndOffersPageState();
}

class _AddsAndOffersPageState extends State<AddsAndOffersPage>
    implements AddsAndOffersViewCallBacks {
  List<AdvModel> ads = List.generate(
    10,
    (index) {
      return AdvModel(
        id: index + 1,
        address: "address",
        description:
            "شاهد خدمتنا الجديدة !! الأن يمكنك متابعة صحتك من خلال تحميل تطبيقنا من غوغل بلاي",
        image: "image",
        expDate: "20-7-2025",
        type: AdvTypeEnum.advertisement,
        isActive: true,
      );
    },
  );

  List<AdvModel> offers = List.generate(
    10,
    (index) {
      return AdvModel(
        id: index + 1,
        address: "address",
        description:
            "هذا المنتج متاح الان ب 500 نقطة بدلا من 1000 ! اذا ماذا تنتظر الان ؟؟ تواصل معنا للاستفادة من هذا العرض",
        image: "image",
        expDate: "20-7-2025",
        type: AdvTypeEnum.offer,
        isActive: true,
      );
    },
  );

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
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            SizedBox(height: 10),
            Text("الإعلانات", style: context.tt.headlineLarge),
            _buildAdsList(),
            SizedBox.shrink(),
            Text("العروض", style: context.tt.headlineLarge),
            _buildOffersList(),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget _buildAdsList() {
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

  Widget _buildOffersList() {
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
