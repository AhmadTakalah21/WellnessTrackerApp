// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';

abstract class ExercisesViewCallbacks {}

@RoutePage()
class ExercisesView extends StatelessWidget {
  const ExercisesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ExercisesPage();
  }
}

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage>
    implements ExercisesViewCallbacks {
  @override
  Widget build(BuildContext context) {
    final exercises = List.generate(
      6,
      (index) => ExerciseModel(
        title: "تمرين إحماء كامل الجسم",
        icon: Icons.fitness_center_rounded,
        description: "ثلاث جولات , تكرار 12 - 10 - 8",
      ),
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('exercises'.tr(), style: context.tt.titleLarge),
      ),
      body: Padding(
        padding: AppConstants.padding16,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            spacing: 20,
            children: [
              _buildTitle(),
              ...exercises.map((exercise) => _buildExerciseTile(exercise)),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Text(
        "تمارين اليوم بتاريخ ${DateFormat("dd/MM/yyyy").format(DateTime.now())}",
        style: context.tt.titleLarge?.copyWith(color: context.cs.primary),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildExerciseTile(ExerciseModel exercise) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: context.cs.primary.withOpacity(0.1),
          child: Icon(exercise.icon, color: context.cs.primary),
        ),
        title: Text(exercise.title, style: context.tt.bodyLarge),
        subtitle: Padding(
          padding: AppConstants.padding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exercise.description,
                style: context.tt.bodySmall?.copyWith(color: Colors.grey),
              ),
              Row(
                children: [
                  Text(
                    "اضغط هنا لمشاهدة كيفية أداء التمرين",
                    style: context.tt.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.play_circle, color: context.cs.error)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseModel {
  final String title;
  final IconData icon;
  final String description;
  ExerciseModel({
    required this.title,
    required this.icon,
    required this.description,
  });
}
