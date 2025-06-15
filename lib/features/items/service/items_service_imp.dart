part of 'items_service.dart';

@Injectable(as: ItemService)
class ItemServiceImp implements ItemService {
  final dio = DioClient();

  @override
  Future<PaginatedModel<ItemModel>> getItems({
    int perPage = 10,
    required int page,
  }) async {
    try {
      final perPageParam = "per_page=$perPage";
      final pageParam = "page=$page";
      final response = await dio.get("/item?$pageParam&$perPageParam");
      final items = response.data as Map<String, dynamic>;
      return PaginatedModel.fromJson(
        items,
        (json) => ItemModel.fromJson(json as Map<String, dynamic>),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ItemModel> getItem(int itemId) async {
    try {
      final response = await dio.get("/item/$itemId");
      final item = response.data["data"] as Map<String, dynamic>;
      return ItemModel.fromJson(item);
    } catch (e) {
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
      final endpoint = isAdd ? "/item" : "/item/$itemId";
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
    } catch (e) {
      rethrow;
    }
  }
}
