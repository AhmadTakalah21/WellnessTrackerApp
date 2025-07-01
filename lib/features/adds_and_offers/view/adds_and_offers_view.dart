import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/app_colors.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

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

class _AddsAndOffersPageState extends State<AddsAndOffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text("الإعلانات", style: context.tt.headlineLarge),
            SizedBox(height: 10),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: AppConstants.padding8,
              scrollDirection: Axis.horizontal,
              child: Row(
                  spacing: 20,
                  children: List.generate(10, (index) {
                    return _buildAdvItem();
                  })),
            ),
            SizedBox(height: 20),
            Text("العروض", style: context.tt.headlineLarge),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                padding: AppConstants.padding8,
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                itemBuilder: (context, index) {
                  return _buildAdvItem();
                },
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvItem() {
    return DecoratedBox(
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
    );
  }
}
