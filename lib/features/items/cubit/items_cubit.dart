import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:wellnesstrackerapp/features/items/model/add_item_model/add_item_model.dart';
import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/features/items/service/items_service.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/models/en_ar_add_model/en_ar_add_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

part 'states/items_state.dart';
part 'states/general_items_state.dart';
part 'states/add_item_state.dart';

@injectable
class ItemsCubit extends Cubit<GeneralItemsState> {
  ItemsCubit(this.itemService) : super(GeneralItemsInitial());

  final ItemService itemService;
  AddItemModel model = const AddItemModel();
  EnArAddModel itemName = const EnArAddModel();
  EnArAddModel itemDescription = const EnArAddModel();
  XFile? image;

  int page = 1;
  bool hasMore = true;
  List<ItemModel> items = [];

  void setModel(ItemModel? item, LevelModel? level) {
    setLevelId(level);
    setNameAr(item?.name.ar);
    setNameEn(item?.name.en);
    setDescriptionAr(item?.description?.ar);
    setDescriptionEn(item?.description?.en);
    setLink(item?.link);
    setPrice(item?.price.toString());
  }

  void setNameAr(String? name) {
    itemName = itemName.copyWith(ar: () => name);
    model = model.copyWith(name: () => itemName);
  }

  void setNameEn(String? name) {
    itemName = itemName.copyWith(en: () => name);
    model = model.copyWith(name: () => itemName);
  }

  void setPrice(String? price) {
    model = model.copyWith(price: () => price);
  }

  void setDescriptionEn(String? desc) {
    itemDescription = itemDescription.copyWith(en: () => desc);
    model = model.copyWith(description: () => itemDescription);
  }

  void setDescriptionAr(String? desc) {
    itemDescription = itemDescription.copyWith(ar: () => desc);
    model = model.copyWith(description: () => itemDescription);
  }

  void setLink(String? link) {
    model = model.copyWith(link: () => link);
  }

  void setLevelId(LevelModel? level) {
    model = model.copyWith(levelId: () => level?.id);
  }

  void setImage(XFile? image) {
    this.image = image;
  }

  void resetModel() {
    image = null;
    model = const AddItemModel();
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
      if (newItems.meta.count == newItems.meta.total) {
        hasMore = false;
      }
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

  Future<void> addItem({int? id}) async {
    emit(AddItemLoading());
    try {
      final item = await itemService.addItem(model, image: image, id: id);
      final isAdd = id == null;
      final message = isAdd ? "item_added".tr() : "item_updated".tr();
      emit(AddItemSuccess(item, message));
    } catch (e) {
      emit(AddItemFail(e.toString()));
    }
  }
}
