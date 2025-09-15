part of 'items_service.dart';

@Injectable(as: ItemService)
class ItemServiceImp implements ItemService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<ItemModel>> getItems({
    int perPage = 10,
    required int page,
    int? levelId,
    required UserRoleEnum role,
  }) async {
    try {
      final perPageParam = "per_page=$perPage";
      final pageParam = "page=$page";
      final levelIdParam = levelId != null ? "filter[level_id]=$levelId" : "";
      final endPoint =
          "/v1/${role.getApiRoute}/items?$levelIdParam&$pageParam&$perPageParam";
      final response = await dio.get(endPoint);
      final items = response.data as Map<String, dynamic>;
      return PaginatedModel.fromJson(
        items,
        (json) => ItemModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(stackTrace);
      }
      rethrow;
    }
  }

  @override
  Future<ItemModel> getItem(int itemId) async {
    try {
      final response = await dio.get("/item/$itemId");
      final item = response.data["data"] as Map<String, dynamic>;
      return ItemModel.fromJson(item);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(stackTrace);
      }
      rethrow;
    }
  }

  @override
  Future<ItemModel> addItem(AddItemModel model, {XFile? image, int? id}) async {
    try {
      final isAdd = id == null;
      final endpoint = isAdd ? "/v1/admin/items" : "/v1/admin/items/$id";
      final map = model.toJson();
      if (!isAdd) {
        map["_method"] = "PUT";
      }
      if (image != null) {
        map['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      final formData = FormData.fromMap(map);

      final response = await dio.post(endpoint,
          data: formData, duration: AppConstants.duration30s);
      final item = response.data["data"] as Map<String, dynamic>;
      return ItemModel.fromJson(item);
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> buyItem(int id) async {
    try {
      await dio.post("/v1/users/items/purchase", data: {"item_id": id});
    } catch (e, stackTrace) {
      if (kDebugMode) print(stackTrace);
      rethrow;
    }
  }
}
