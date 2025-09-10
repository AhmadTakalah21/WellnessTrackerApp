import 'package:wellnesstrackerapp/features/levels/model/level_model/level_model.dart';
import 'package:wellnesstrackerapp/global/extensions/date_x.dart';
import 'package:wellnesstrackerapp/global/models/department_enum.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/fake_meta.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

final fakeLevels = PaginatedModel<LevelModel>(
  data: List.generate(
    5,
    (index) => LevelModel(
      id: index + 1,
      name: "level ${index + 1}",
      type: DepartmentEnum.dietitian,
      time: DateTime.now().formatYYYYMMDD,
      description: "description for level ${index + 1}",
    ),
  ),
  meta: fakeMeta,
);
