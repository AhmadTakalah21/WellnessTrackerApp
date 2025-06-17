part of "points_service.dart";

@Injectable(as: PointsService)
class PointsServiceImp implements PointsService {
  final dio = DioClient();
}
