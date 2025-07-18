import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/features/codes/model/add_code_model/add_code_model.dart';
import 'package:wellnesstrackerapp/features/codes/model/code_model/code_model.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/models/paginated_model/paginated_model.dart';

part 'codes_service_imp.dart';

abstract class CodesService {
  Future<PaginatedModel<CodeModel>> getCodes({
    int perPage = 10,
    required int page,
  });

  Future<CodeModel> addCode(AddCodeModel addCodeModel, {int? id});
}
