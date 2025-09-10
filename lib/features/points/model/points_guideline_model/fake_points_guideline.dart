import 'package:wellnesstrackerapp/features/points/model/points_guideline_model/points_guideline_model.dart';
import 'package:wellnesstrackerapp/global/models/en_ar_model/en_ar_model.dart';
import 'package:wellnesstrackerapp/global/models/meta_model/fake_meta.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

final fakePointsGuidelines = PaginatedModel<PointsGuidelineModel>(
  data: List.generate(
    8,
    (index) => PointsGuidelineModel(
      id: index + 1,
      title: EnArModel(
          en: 'Guideline ${index + 1}', ar: 'طريقة كسب النقاط ${index + 1}'),
      isActive: true,
      link: index.isEven ? "https://www.google.com" : null,
      description: EnArModel(
        en: 'Description for Guideline ${index + 1}.',
        ar: 'وصف طريقة كسب النقاط ${index + 1}',
      ),
    ),
  ),
  meta: fakeMeta,
);
