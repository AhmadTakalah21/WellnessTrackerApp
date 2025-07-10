import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/items/model/add_item_model/add_item_model.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/features/items/service/items_service.dart';

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

  void setLevelId(int? levelId) {
    addItemModel = addItemModel.copyWith(levelId: () => levelId);
  }

  void setImage(XFile? image) {
    this.image = image;
  }

  void resetModel() {
    image = null;
    addItemModel = const AddItemModel();
  }

  Future<void> getItems({int perPage = 10, bool isLoadMore = true}) async {
    if (!hasMore && isLoadMore) return;
    if (!isLoadMore) {
      page = 1;
      hasMore = true;
      items.clear();
    }
    emit(ItemsLoading());
    try {
      if (isClosed) return;
      final newItems = await itemService.getItems(page: page, perPage: perPage);
      if (newItems.data.isEmpty) {
        hasMore = false;
        //emit(ItemsEmpty("no_items".tr()));
        if (page == 1) {
          emit(ItemsEmpty("no_items".tr()));
        }
      } else {
        items.addAll(newItems.data);
        page++;
        //emit(ItemsSuccess(items));
      }
      emit(ItemsSuccess(items));
    } catch (e) {
      if (isClosed) return;
      emit(ItemsFail(e.toString()));
    }
  }

  Future<void> addItem({required bool isAdd, int? itemId}) async {
    if (isAdd && image == null) {
      emit(AddItemFail("image_required".tr()));
      return;
    }
    emit(AddItemLoading());
    try {
      final item = await itemService.addItem(
        addItemModel,
        image: image,
        isAdd: isAdd,
        itemId: itemId,
      );
      final message = isAdd ? "item_added".tr() : "item_updated".tr();
      emit(AddItemSuccess(item, message));
    } catch (e) {
      emit(AddItemFail(e.toString()));
    }
  }
}
