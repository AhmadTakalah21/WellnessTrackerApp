import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/items/model/add_item_model/add_item_model.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/features/items/service/items_service.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'states/items_state.dart';
part 'states/general_items_state.dart';
part 'states/add_item_state.dart';

@injectable
class ItemsCubit extends Cubit<GeneralItemsState> {
  ItemsCubit(this.itemService) : super(GeneralItemsInitial());

  final ItemService itemService;
  AddItemModel addItemModel = const AddItemModel();
  XFile? image;

  int page = 1;
  bool hasMore = true;
  List<ItemModel> items = [];

  void setNameAr(String? name) {
    addItemModel = addItemModel.copyWith(nameAr: () => name);
  }

  void setNameEn(String? name) {
    addItemModel = addItemModel.copyWith(nameEn: () => name);
  }

  void setPrice(String? price) {
    addItemModel = addItemModel.copyWith(price: () => price);
  }

  void setDescriptionEn(String? desc) {
    addItemModel = addItemModel.copyWith(descriptionEn: () => desc);
  }

  void setDescriptionAr(String? desc) {
    addItemModel = addItemModel.copyWith(descriptionAr: () => desc);
  }

  void setLink(String? link) {
    addItemModel = addItemModel.copyWith(link: () => link);
  }

  void setLevelId(LevelModel? level) {
    addItemModel = addItemModel.copyWith(levelId: () => level?.id);
  }

  void setImage(XFile? image) {
    this.image = image;
  }

  void resetModel() {
    image = null;
    addItemModel = const AddItemModel();
  }

  Future<void> getItems(
    UserRoleEnum role, {
    int perPage = 10,
    bool isLoadMore = true,
    int? levelId,
  }) async {
    if (!hasMore && isLoadMore) return;
    if (!isLoadMore) {
      page = 1;
      hasMore = true;
      items.clear();
    }
    emit(ItemsLoading());
    try {
      if (isClosed) return;
      final newItems = await itemService.getItems(
        page: page,
        perPage: perPage,
        role: role,
        levelId: levelId,
      );
      if (newItems.data.isEmpty) {
        hasMore = false;
        if (page == 1) {
          emit(ItemsEmpty("no_items".tr()));
        }
      } else {
        items.addAll(newItems.data);
        page++;
      }
      if (items.isEmpty) {
        emit(ItemsEmpty("no_items".tr()));
      } else {
        emit(ItemsSuccess(items));
      }
    } catch (e) {
      if (isClosed) return;
      emit(ItemsFail(e.toString()));
    }
  }

  Future<void> addItem({required bool isAdd, int? id}) async {
    emit(AddItemLoading());
    try {
      final item = await itemService.addItem(
        addItemModel,
        image: image,
        isAdd: isAdd,
        itemId: id,
      );
      final message = isAdd ? "item_added".tr() : "item_updated".tr();
      emit(AddItemSuccess(item, message));
    } catch (e) {
      emit(AddItemFail(e.toString()));
    }
  }
}
