import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/exercises/model/add_exercise_description_model/add_exercise_description_model.dart';
import 'package:wellnesstrackerapp/features/exercises/model/add_exercise_model/add_exercise_model.dart';
import 'package:wellnesstrackerapp/features/exercises/model/exercise_model/exercise_model.dart';
import 'package:wellnesstrackerapp/features/exercises/service/exercises_service.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/meta_model.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'states/exercises_state.dart';
part 'states/add_exercise_state.dart';
part 'states/general_exercises_state.dart';

@injectable
class ExercisesCubit extends Cubit<GeneralExercisesState> {
  ExercisesCubit(this.exercisesService) : super(GeneralExercisesInitial());

  final ExercisesService exercisesService;

  List<ExerciseModel> _allExercises = [];
  MetaModel? meta;

  AddExerciseModel model = const AddExerciseModel();
  AddExerciseDescriptionModel addDescriptionModel =
      const AddExerciseDescriptionModel();
  int rounds = 0;
  List<int> repeatsForRounds = [];
  String? filePath;

  void setModel(ExerciseModel? exercise) {
    setName(exercise?.name);
    setLink(exercise?.link);
    setExplain(exercise?.description.explain);
    setRounds(exercise?.description.rounds);
    repeatsForRounds = exercise?.description.repeats ?? [];
    setRepeats(repeatsForRounds);
  }

  void setName(String? name) {
    model = model.copyWith(name: () => name);
  }

  void setLink(String? link) {
    model = model.copyWith(link: () => link);
  }

  void setFile(String? filePath) {
    this.filePath = filePath;
    model = model.copyWith(file: () => filePath);
  }

  void setRounds(int? rounds) {
    addDescriptionModel = addDescriptionModel.copyWith(rounds: () => rounds);
  }

  void setExplain(String? explain) {
    addDescriptionModel = addDescriptionModel.copyWith(explain: () => explain);
  }

  void setRepeats(List<int> repeats) {
    addDescriptionModel = addDescriptionModel.copyWith(repeats: () => repeats);
    emit(RoundsUpdatedState(repeats));
  }

  void setDescription() {
    model = model.copyWith(description: () => addDescriptionModel);
  }

  void updateRounds(int? rounds) {
    if (rounds != null) {
      if (rounds > repeatsForRounds.length) {
        repeatsForRounds.addAll(List.generate(
          rounds - repeatsForRounds.length,
          (index) => 0,
        ));
        //repeatsForRounds.add(0);
      } else {
        repeatsForRounds.removeRange(
          rounds,
          repeatsForRounds.length,
        );
        //repeatsForRounds.removeLast();
      }
      emit(RoundsUpdatedState(repeatsForRounds));
    }
    setRounds(rounds);
  }

  void updateRepeatsForRound(int repeat, int index) {
    repeatsForRounds[index] = repeat;
    setRepeats(repeatsForRounds);
  }

  void resetModel() {
    rounds = 0;
    repeatsForRounds.clear();
    filePath = null;
    addDescriptionModel = const AddExerciseDescriptionModel();
    model = const AddExerciseModel();
  }

  Future<void> getExercises({
    int? perPage = 10,
    int? page,
  }) async {
    emit(ExercisesLoading());
    try {
      if (isClosed) return;
      final result = await exercisesService.getExercises(
        page: page,
        perPage: perPage,
      );
      _allExercises = result.data;
      meta = result.meta;

      if (_allExercises.isEmpty) {
        emit(ExercisesEmpty("no_exercises".tr()));
      } else {
        emit(ExercisesSuccess(result, null));
      }
    } catch (e) {
      if (isClosed) return;
      emit(ExercisesFail(e.toString()));
    }
  }

  Future<void> addExercise({int? id}) async {
    setDescription();
    emit(AddExerciseLoading());
    try {
      final result = await exercisesService.addExercise(model, id: id);
      final isAdd = id == null;
      final message = isAdd ? "exercise_added".tr() : "exercise_updated".tr();
      emit(AddExerciseSuccess(result, message));
    } catch (e) {
      emit(AddExerciseFail(e.toString()));
    }
  }
}
