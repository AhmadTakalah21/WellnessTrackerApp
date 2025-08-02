import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/exercises/cubit/exercises_cubit.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/global/models/video_type_enum.dart';
import 'package:wellnesstrackerapp/global/theme/theme_x.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/check_box_selector_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/choose_file_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/counter_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/loading_indicator.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class AddExerciseViewCallBacks {
  void updateRounds(bool isAdd);
  void updateRepeatsForRound(bool isAdd, int index);
  void onVideoTypeChnaged(VideoTypeEnum type);
  void onSave();
}

@RoutePage()
class AddExerciseView extends StatelessWidget {
  const AddExerciseView({
    super.key,
    required this.exercisesCubit,
    this.exercise,
  });
  final ExercisesCubit exercisesCubit;
  final ExerciseModel? exercise;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: exercisesCubit,
      child: AddExercisePage(exercise: exercise),
    );
  }
}

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({super.key, this.exercise});
  final ExerciseModel? exercise;

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage>
    implements AddExerciseViewCallBacks {
  late final ExercisesCubit exercisesCubit = context.read();
  final roundsController = TextEditingController(text: "0");
  late List<TextEditingController> repeatsForRoundsController = [];
  final _formKey = GlobalKey<FormState>();
  bool isLink = true;

  @override
  void initState() {
    super.initState();
    exercisesCubit.setModel(widget.exercise);
    roundsController.text =
        widget.exercise?.description.rounds.toString() ?? "0";
    print(widget.exercise?.description.repeats);
    print(exercisesCubit.repeatsForRounds.length);
    repeatsForRoundsController = List.generate(
      exercisesCubit.repeatsForRounds.length,
      (index) => TextEditingController(
        text: exercisesCubit.repeatsForRounds[index].toString(),
      ),
    );
  }

  @override
  void updateRounds(bool isAdd) {
    exercisesCubit.updateRounds(isAdd);
    setState(() {
      roundsController.text = exercisesCubit.rounds.toString();
    });
    repeatsForRoundsController = List.generate(
      exercisesCubit.repeatsForRounds.length,
      (index) => TextEditingController(
        text: exercisesCubit.repeatsForRounds[index].toString(),
      ),
    );
  }

  @override
  void updateRepeatsForRound(bool isAdd, int index) {
    exercisesCubit.updateRepeatsForRound(isAdd, index);
    setState(() {
      repeatsForRoundsController[index].text =
          exercisesCubit.repeatsForRounds[index].toString();
    });
  }

  @override
  void onVideoTypeChnaged(VideoTypeEnum type) {
    setState(() {
      isLink = !isLink;
    });
  }

  @override
  void onSave() {
    if (_formKey.currentState!.validate()) {
      exercisesCubit.addExercise(id: widget.exercise?.id);
    }
  }

  @override
  void dispose() {
    roundsController.dispose();
    for (var repeatsForRoundController in repeatsForRoundsController) {
      repeatsForRoundController.dispose();
    }
    exercisesCubit.resetModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;
    return Scaffold(
      appBar: MainAppBar(
        automaticallyImplyLeading: true,
        title: "add_exercise".tr(),
        hasLogout: false,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: AppConstants.padding20,
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 20,
            children: [
              MainTextField2(
                initialText: exercise?.name,
                onChanged: exercisesCubit.setName,
                label: 'name'.tr(),
                icon: Icons.edit_outlined,
                validator: (val) =>
                    Utils.validateInput(val, InputTextType.none),
              ),
              CounterWidget(
                controller: roundsController,
                onIncreaseTap: () => updateRounds(true),
                onDecreaseTap: () => updateRounds(false),
                label: 'rounds'.tr(),
                icon: Icons.fitness_center_outlined,
              ),
              if (int.parse(roundsController.text) != 0)
                ...List.generate(
                  repeatsForRoundsController.length,
                  (index) {
                    return CounterWidget(
                      controller: repeatsForRoundsController[index],
                      onIncreaseTap: () => updateRepeatsForRound(true, index),
                      onDecreaseTap: () => updateRepeatsForRound(false, index),
                      label: "repeats_for".tr(args: [(index + 1).toString()]),
                      icon: Icons.repeat_outlined,
                    );
                  },
                ),
              MainTextField2(
                initialText: exercise?.description.explain,
                onChanged: exercisesCubit.setExplain,
                label: 'explanation'.tr(),
                icon: Icons.description,
                maxLines: null,
                validator: (val) =>
                    Utils.validateInput(val, InputTextType.none),
              ),
              Row(
                children: [
                  CheckBoxSelectorWidget(
                    title: "video".tr(),
                    selected: VideoTypeEnum.link,
                    items: VideoTypeEnum.values,
                    onSelected: onVideoTypeChnaged,
                  ),
                  SizedBox(width: 20),
                  if (isLink)
                    Expanded(
                      child: MainTextField2(
                        initialText: exercise?.link,
                        onChanged: exercisesCubit.setLink,
                        hint: 'link'.tr(),
                        icon: Icons.link,
                        validator: (val) =>
                            Utils.validateInput(val, InputTextType.none),
                      ),
                    ),
                  if (!isLink)
                    Expanded(
                        child: ChooseFileWidget(
                      onSetFile: exercisesCubit.setFile,
                      validator: (_) => exercisesCubit.filePath == null
                          ? 'file_required'.tr()
                          : null,
                    ))
                ],
              ),
              BlocConsumer<ExercisesCubit, GeneralExercisesState>(
                listener: (context, state) {
                  if (state is AddExerciseSuccess) {
                    Navigator.pop(context);
                    exercisesCubit.getExercises();
                    MainSnackBar.showSuccessMessage(context, state.message);
                  } else if (state is AddExerciseFail) {
                    MainSnackBar.showErrorMessage(context, state.error);
                  }
                },
                builder: (context, state) {
                  final isLoading = state is AddExerciseLoading;
                  final child = isLoading
                      ? LoadingIndicator(
                          size: 30,
                          color: context.cs.surface,
                        )
                      : null;
                  return MainActionButton(
                    onTap: isLoading ? () {} : onSave,
                    text: "save".tr(),
                    child: child,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
