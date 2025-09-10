import 'package:wellnesstrackerapp/features/items/model/item_model/item_model.dart';
import 'package:wellnesstrackerapp/features/levels/model/level_model/fake_levels.dart';
import 'package:wellnesstrackerapp/global/models/en_ar_model/en_ar_model.dart';

final fakeItems = List.generate(
  8,
  (index) => ItemModel(
    id: index + 1,
    name: EnArModel(en: "Item ${index + 1}", ar: "العنصر ${index + 1}"),
    price: (index + 1) * 100,
    level: fakeLevels.data[0],
    link: index.isEven ? "https://www.google.com" : null,
    description: EnArModel(
      en: "Description for item ${index + 1}",
      ar: "الوصف للعنصر ${index + 1}",
    ),
  ),
);
