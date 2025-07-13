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
      final endPoint = "/v1/${role.getApiRoute}/items?$levelIdParam&$pageParam&$perPageParam";
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
  Future<ItemModel> addItem(
    AddItemModel addItemModel, {
    XFile? image,
    required bool isAdd,
    int? itemId,
  }) async {
    try {
      final endpoint = isAdd ? "/v1/admin/items" : "/v1/admin/items/$itemId";
      final map = addItemModel.toJson();
      if (image != null) {
        map['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      final response = await dio.postOrPut(
        endpoint,
        isAdd: isAdd,
        data: addItemModel.toJson(),
      );
      final item = response.data["data"] as Map<String, dynamic>;
      return ItemModel.fromJson(item);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(stackTrace);
      }
      rethrow;
    }
  }
}
