import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/points/service/points_service.dart';

part 'states/points_state.dart';
part 'states/general_points_state.dart';

@injectable
class PointsCubit extends Cubit<GeneralPointsState> {
  PointsCubit(this.pointsService) : super(GeneralPointsInitial());
  final PointsService pointsService;
}
