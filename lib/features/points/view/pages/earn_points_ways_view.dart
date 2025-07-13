import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';

class EarnPointsWaysView extends StatelessWidget {
  const EarnPointsWaysView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            10,
            (index) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: context.cs.primary.withOpacity(0.1),
                  child: Icon(Icons.trending_up, color: context.cs.primary),
                ),
                title: Text(
                  "اكسب 500 نقطة عند خسارة 3 كغ هذا الأسبوع",
                  style: context.tt.bodyLarge,
                ),
                subtitle: Text(
                  "احصل على نقاط إضافية عبر الالتزام الأسبوعي",
                  style: context.tt.bodySmall?.copyWith(color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: 120),
        ],
      ),
    );
  }
}
