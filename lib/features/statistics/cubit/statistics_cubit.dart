import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/statistics/model/stats_model/stats_model.dart';
import 'package:wellnesstrackerapp/features/statistics/service/statistics_service.dart';

part 'states/statistics_state.dart';
part 'states/general_statistics_state.dart';

@injectable
class StatisticsCubit extends Cubit<GeneralStatisticsState> {
  StatisticsCubit(this.statisticsService) : super(GeneralStatisticsInitial());
  final StatisticsService statisticsService;

  Future<void> getStats() async {
    emit(StatisticsLoading());
    try {
      if (isClosed) return;
      final result = await statisticsService.getStats();
      emit(StatisticsSuccess(result));
    } catch (e) {
      if (isClosed) return;
      emit(StatisticsFail(e.toString()));
    }
  }
}
