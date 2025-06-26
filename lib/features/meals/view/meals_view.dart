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
          child: Column(
            spacing: 20,
            children: [
              Text(
                 "وجبات اليوم بتاريخ ${DateFormat("dd/MM/yyyy").format(DateTime.now())}",
                style: context.tt.titleLarge
                    ?.copyWith(color: context.cs.primary),
                    textAlign: TextAlign.center,
              ),
              ...List.generate(
                4,
                (index) {
                  return Card(
                    child: Padding(
                      padding: AppConstants.padding16,
                      child: Column(
                        spacing: 10,
                        children: [
                          Center(
                            child: Text(
                              "الوجبة الأولى - الفطور",
                              style: context.tt.titleLarge
                                  ?.copyWith(color: context.cs.primary),
                            ),
                          ),
                          Divider(color: context.cs.secondary, thickness: 0.7),
                          ...List.generate(
                            3,
                            (index) {
                              return Column(
                                children: [
                                  Row(
                                    spacing: 10,
                                    children: [
                                      Text(
                                        "حليب",
                                        style: context.tt.titleMedium,
                                      ),
                                      SizedBox(width: 5),
                                      Column(
                                        children: [
                                          Text(
                                            "المقدار",
                                            style: context.tt.titleSmall,
                                          ),
                                          Text(
                                            "كوب واحد",
                                            style: context.tt.titleMedium,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "س حرارية",
                                            style: context.tt.titleSmall,
                                          ),
                                          Text(
                                            "120",
                                            style: context.tt.titleMedium,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "بروتين",
                                            style: context.tt.titleSmall,
                                          ),
                                          Text(
                                            "24",
                                            style: context.tt.titleMedium,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "كربوهيدرات",
                                            style: context.tt.titleSmall,
                                          ),
                                          Text(
                                            "3",
                                            style: context.tt.titleMedium,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                      color: context.cs.secondary,
                                      thickness: 0.7),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
