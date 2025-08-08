import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/items/model/add_item_model/add_item_model.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'items_service_imp.dart';

abstract class ItemService {
  Future<PaginatedModel<ItemModel>> getItems({
    int perPage = 10,
    required int page,
    int? levelId,
    required UserRoleEnum role,
  });
  Future<ItemModel> getItem(int itemId);
  Future<ItemModel> addItem(AddItemModel model, {XFile? image, int? id});
  Future<void> buyItem(int id);
}
