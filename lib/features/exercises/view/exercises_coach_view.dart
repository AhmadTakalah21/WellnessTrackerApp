import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/exercises/cubit/exercises_cubit.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/features/exercises/view/add_exercise_view.dart';
import 'package:wellnesstrackerapp/global/di/di.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/widgets/additional_options_bottom_sheet.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_add_floating_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_error_widget.dart';

abstract class ExercisesCoachViewCallbacks {
  void onAddTap();
  void onTap(ExerciseModel exercise);
  void onEditTap(ExerciseModel exercise);
  void onDeleteTap(ExerciseModel exercise);
  void onTryAgainTap();
  Future<void> onRefresh();
}

@RoutePage()
class ExercisesCoachView extends StatelessWidget {
  const ExercisesCoachView({super.key, required this.role});
  final UserRoleEnum role;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => get<ExercisesCubit>(),
      child: ExercisesCoachPage(role: role),
    );
  }
}

class ExercisesCoachPage extends StatefulWidget {
  const ExercisesCoachPage({super.key, required this.role});
  final UserRoleEnum role;

  @override
  State<ExercisesCoachPage> createState() => _ExercisesCoachPageState();
}

class _ExercisesCoachPageState extends State<ExercisesCoachPage>
    with TickerProviderStateMixin
    implements ExercisesCoachViewCallbacks {
  late final ExercisesCubit exercisesCubit = context.read();

  @override
  void initState() {
    super.initState();
    exercisesCubit.getExercises();
  }

  @override
  void onAddTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExerciseView(exercisesCubit: exercisesCubit),
      ),
    );
  }

  @override
  void onTap(ExerciseModel exercise) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: AppConstants.borderRadiusT20),
      builder: (context) => AdditionalOptionsBottomSheet(
        item: exercise,
        onEditTap: onEditTap,
        onDeleteTap: onDeleteTap,
      ),
    );
  }

  @override
  void onDeleteTap(ExerciseModel exercise) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => InsureDeleteWidget(
        item: exercise,
        onSuccess: () {
          Navigator.pop(context);
          exercisesCubit.getExercises();
        },
      ),
    );
  }

  @override
  void onEditTap(ExerciseModel exercise) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddExerciseView(
          exercisesCubit: exercisesCubit,
          exercise: exercise,
        ),
      ),
    );
  }

  @override
  Future<void> onRefresh() async => onTryAgainTap();

  @override
  void onTryAgainTap() => exercisesCubit.getExercises();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.cs.primary,
        elevation: 10,
        title: Text('exercises'.tr(), style: context.tt.titleLarge),
      ),
      body: BlocBuilder<ExercisesCubit, GeneralExercisesState>(
        buildWhen: (previous, current) => current is ExercisesState,
        builder: (context, state) {
          if (state is ExercisesLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is ExercisesSuccess) {
            final exercises = state.exercises.data;
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                padding: AppConstants.padding20,
                physics: BouncingScrollPhysics(),
                child: Column(
                  spacing: 20,
                  children: [
                    ...exercises.map((e) => _buildExerciseTile(e)),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            );
          } else if (state is ExercisesEmpty) {
            return MainErrorWidget(
              error: state.message,
              isRefresh: true,
              onTryAgainTap: onTryAgainTap,
            );
          } else if (state is ExercisesFail) {
            return MainErrorWidget(
              error: state.error,
              onTryAgainTap: onTryAgainTap,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: MainFloatingButton(onTap: onAddTap),
    );
  }

  Widget _buildExerciseTile(ExerciseModel exercise) {
    return InkWell(
      onTap: () => onTap(exercise),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: ListTile(
          title: Text(exercise.name, style: context.tt.headlineSmall),
          subtitle: Padding(
            padding: AppConstants.padding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  "rounds count : ${exercise.description.rounds.toString()} rounds",
                  style: context.tt.bodySmall?.copyWith(color: Colors.grey),
                ),
                Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: List.generate(
                      exercise.description.repeats.length,
                      (index) {
                        final repeat = exercise.description.repeats[index];
                        return Text(
                          "repeats for round ${index + 1} is $repeat",
                          style:
                              context.tt.bodySmall?.copyWith(color: Colors.grey),
                        );
                      },
                    )),
                // Text(
                //   exercise.description.repeats.toString(),
                //   style: context.tt.bodySmall?.copyWith(color: Colors.grey),
                // ),
                Text(
                  exercise.description.explain,
                  style: context.tt.bodySmall?.copyWith(color: Colors.grey),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "اضغط هنا لمشاهدة كيفية أداء التمرين",
                        style: context.tt.bodySmall?.copyWith(color: Colors.grey),
                      ),
                    ),
                    Icon(Icons.play_circle, color: context.cs.error)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
