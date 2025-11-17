import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellnesstrackerapp/features/exercises/cubit/exercises_cubit.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/global/models/video_type_enum.dart';
import 'package:wellnesstrackerapp/global/utils/constants.dart';
import 'package:wellnesstrackerapp/global/utils/utils.dart';
import 'package:wellnesstrackerapp/global/widgets/check_box_selector_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/choose_file_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_action_button.dart';
import 'package:wellnesstrackerapp/global/widgets/main_app_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_counter_widget.dart';
import 'package:wellnesstrackerapp/global/widgets/main_snack_bar.dart';
import 'package:wellnesstrackerapp/global/widgets/main_text_field_2.dart';

abstract class AddExerciseViewCallBacks {
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

  final _formKey = GlobalKey<FormState>();
  bool isLink = true;

  @override
  void initState() {
    super.initState();
    exercisesCubit.setModel(widget.exercise);
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
    if (widget.exercise == null) {
      exercisesCubit.resetModel();
    }
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
            children: [
              MainTextField2(
                initialText: exercise?.name,
                onChanged: exercisesCubit.setName,
                label: 'name'.tr(),
                icon: Icons.edit_outlined,
                validator: (val) =>
                    Utils.validateInput(val, InputTextType.none),
              ),
              SizedBox(height: 20),
              MainCounterWidget(
                label: 'rounds'.tr(),
                icon: Icons.fitness_center_outlined,
                maxCount: 9,
                initialCount: widget.exercise?.description.rounds,
                onChanged: (value) => exercisesCubit.updateRounds(value),
                inputFormatters: [LengthLimitingTextInputFormatter(1)],
                isRequired: true,
              ),
              SizedBox(height: 20),
              BlocBuilder<ExercisesCubit, GeneralExercisesState>(
                buildWhen: (previous, current) => current is RoundsUpdatedState,
                builder: (context, state) {
                  if (state is RoundsUpdatedState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(
                          state.repeats.length,
                          (index) {
                            return MainCounterWidget(
                              initialCount: state.repeats[index],
                              onChanged: (value) => exercisesCubit
                                  .updateRepeatsForRound(value, index),
                              label: "repeats_for"
                                  .tr(args: [(index + 1).toString()]),
                              icon: Icons.repeat_outlined,
                              isRequired: true,
                            );
                          },
                        ),
                        if (state.repeats.isNotEmpty) SizedBox(height: 20),
                      ],
                    );
                  }
                  return SizedBox.shrink();
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
                  return MainActionButton(
                    onTap: onSave,
                    text: "save".tr(),
                    isLoading: state is AddExerciseLoading,
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
