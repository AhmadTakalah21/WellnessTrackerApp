import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class SelectPlanViewCallBacks {}

@RoutePage()
class SelectPlanView extends StatelessWidget {
  const SelectPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SelectPlanPage();
  }
}

class SelectPlanPage extends StatefulWidget {
  const SelectPlanPage({super.key});

  @override
  State<SelectPlanPage> createState() => _SelectPlanPageState();
}

class _SelectPlanPageState extends State<SelectPlanPage>
    implements SelectPlanViewCallBacks {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('follow_up'.tr())),
      body: SingleChildScrollView(
        padding: AppConstants.padding20,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildGridItem(
              context,
              'medical_follow',
              '0912345678',
              Icons.medication_rounded,
              Colors.red.shade400,
            ),
            _buildGridItem(
              context,
              'nutrition_follow',
              '0912345678',
              Icons.restaurant_menu_rounded,
              Colors.green.shade400,
            ),
            _buildGridItem(
              context,
              'sport_follow',
              '0912345678',
              Icons.fitness_center_rounded,
              Colors.blue.shade400,
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(
    BuildContext context,
    String name,
    String phone,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () {
        // TODO
      },
      child: Padding(
        padding: AppConstants.padding20,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
          color: Colors.white,
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: color.withAlpha((0.2 * 255).toInt()),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 37, color: color),
              ),
              SizedBox(height: 5),
              Text(
                name.tr(),
                textAlign: TextAlign.center,
                style: context.tt.titleLarge,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    phone,
                    textAlign: TextAlign.center,
                    style: context.tt.titleMedium,
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    "assets/images/whatsapp.svg",
                    color: context.cs.primary,
                  ),
                ],
              ),
              SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
