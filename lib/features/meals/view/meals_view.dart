import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class MealsViewCallbacks {}

@RoutePage()
class MealsView extends StatelessWidget {
  const MealsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MealsPage();
  }
}

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> implements MealsViewCallbacks {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('meals'.tr(), style: context.tt.titleLarge),
      ),
      body: Padding(
        padding: AppConstants.padding16,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            spacing: 20,
            children: [
              Text(
                "وجبات اليوم بتاريخ ${DateFormat("dd/MM/yyyy").format(DateTime.now())}",
                style:
                    context.tt.titleLarge?.copyWith(color: context.cs.primary),
                textAlign: TextAlign.center,
              ),
              _buildMealItem(
                mealName: "الوجبة الأولى - الفطور",
                mealIcon: Icons.breakfast_dining,
                ingredients: [
                  {
                    'name': 'حليب',
                    'quantity': 'كوب واحد',
                    'calories': '120',
                    'protein': '8g',
                    'carbs': '12g',
                  },
                  {
                    'name': 'بيض',
                    'quantity': '2 حبات',
                    'calories': '140',
                    'protein': '12g',
                    'carbs': '1g',
                  },
                ],
              ),
              _buildMealItem(
                mealName: "الوجبة الثانية - الغداء",
                mealIcon: Icons.lunch_dining,
                ingredients: [
                  {
                    'name': 'دجاج',
                    'quantity': '100g',
                    'calories': '200',
                    'protein': '30g',
                    'carbs': '0g',
                  },
                  {
                    'name': 'رز',
                    'quantity': 'كوب',
                    'calories': '180',
                    'protein': '4g',
                    'carbs': '40g',
                  },
                ],
              ),
              // ...List.generate(4, (index) {
              //   return _buildMealItem();
              // }),
              SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealItem({
    required String mealName,
    required IconData mealIcon,
    required List<Map<String, dynamic>> ingredients,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(mealIcon, color: context.cs.primary),
                const SizedBox(width: 10),
                Text(
                  mealName,
                  style: context.tt.titleLarge?.copyWith(
                    color: context.cs.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...ingredients.map((ingredient) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.cs.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ingredient['name'],
                      style: context.tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutrient(
                            icon: Icons.local_drink,
                            label: "الكمية",
                            value: ingredient['quantity']),
                        _buildNutrient(
                            icon: Icons.local_fire_department,
                            label: "السعرات",
                            value: ingredient['calories']),
                        _buildNutrient(
                            icon: Icons.fitness_center,
                            label: "البروتين",
                            value: ingredient['protein']),
                        _buildNutrient(
                          icon: Icons.bubble_chart,
                          label: "الكربوهيدرات",
                          value: ingredient['carbs'],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            Column(
              children: [
                Padding(
                  padding: AppConstants.paddingH20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("طريقة التحضير :", style: context.tt.titleLarge),
                      Icon(Icons.play_circle, color: context.cs.error)
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "اولا نقوم بفقس البيض في وعاء , ثم نضع القليل من الملح ونخلطهم خلطا جيدا  , ثم نضع المقلاة على النار ونضع عليها زيت الزيتون وننتظر حوالي دقيقتان, ثم نقوم بسكب البيض على المقلاة ونقوم بتحركهم قليلا وثانيا نضع الحليب على النار حتى يسخن و ممكن اضافة القليل من السكر ",
                  style: context.tt.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget _buildMealItem() {
  //   return Card(
  //     elevation: 6,
  //     child: Padding(
  //       padding: AppConstants.padding16,
  //       child: Column(
  //         spacing: 20,
  //         children: [
  //           Center(
  //             child: Text(
  //               "الوجبة الأولى - الفطور",
  //               style:
  //                   context.tt.titleLarge?.copyWith(color: context.cs.primary),
  //             ),
  //           ),
  //           ...List.generate(3, (index) {
  //             return Column(
  //               children: [
  //                 Row(
  //                   spacing: 10,
  //                   children: [
  //                     Text("حليب", style: context.tt.titleMedium),
  //                     SizedBox(width: 5),
  //                     Column(
  //                       children: [
  //                         Text("المقدار", style: context.tt.titleSmall),
  //                         Text("كوب واحد", style: context.tt.titleMedium),
  //                       ],
  //                     ),
  //                     Column(
  //                       children: [
  //                         Text("س حرارية", style: context.tt.titleSmall),
  //                         Text("120", style: context.tt.titleMedium),
  //                       ],
  //                     ),
  //                     Column(
  //                       children: [
  //                         Text("بروتين", style: context.tt.titleSmall),
  //                         Text("24", style: context.tt.titleMedium),
  //                       ],
  //                     ),
  //                     Column(
  //                       children: [
  //                         Text("كربوهيدرات", style: context.tt.titleSmall),
  //                         Text("3", style: context.tt.titleMedium),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             );
  //           })
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildNutrient({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blueAccent),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
