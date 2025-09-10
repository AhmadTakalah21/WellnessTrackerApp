import 'package:wellnesstrackerapp/features/adds_and_offers/model/adv_model/adv_model.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/models/adv_type_enum.dart';
import 'package:wellnesstrackerapp/global/models/en_ar_model/en_ar_model.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/fake_meta.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

final fakeAdvs = PaginatedModel<AdvModel>(
  data: List.generate(
    8,
    (index) => AdvModel(
      id: index + 1,
      title: EnArModel(
        ar: index < 4 ? "عرض ${index + 1}" : "اعلان ${index - 3}",
        en: index < 4 ? "offer ${index + 1}" : "advertisement ${index - 3}",
      ),
      description: EnArModel(
        ar: index < 4 ? "وصف العرض ${index + 1}" : "وضف الاعلان ${index - 3}",
        en: index < 4
            ? "offer description ${index + 1}"
            : "advertisement description ${index - 3}",
      ),
      type: index < 4 ? AdvTypeEnum.offer : AdvTypeEnum.advertisement,
      image: "Image ${index + 1}",
      startDate: DateTime.now().formatYYYYMMDD,
      endDate: DateTime.now().add(Duration(days: 7)).formatYYYYMMDD,
    ),
  ),
  meta: fakeMeta,
);
