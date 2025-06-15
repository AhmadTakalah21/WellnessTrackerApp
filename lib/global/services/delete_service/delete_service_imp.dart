part of 'delete_service.dart';

@Injectable(as: DeleteService)
class DeleteServiceImp implements DeleteService {
  final dio = DioClient();

  @override
  Future<void> deleteItem<T extends DeleteModel>(T item) async {
    try {
      await dio.post("/api/${item.apiDeleteUrl}", data: {"_method": "DELETE"});
    } catch (e) {
      rethrow;
    }
  }
}
