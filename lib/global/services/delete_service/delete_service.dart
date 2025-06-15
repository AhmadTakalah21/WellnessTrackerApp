import 'package:injectable/injectable.dart';
import 'package:wellnesstrackerapp/global/dio/dio_client.dart';
import 'package:wellnesstrackerapp/global/widgets/insure_delete_widget.dart';

part 'delete_service_imp.dart';

abstract class DeleteService {
  Future<void> deleteItem<T extends DeleteModel>(T item);
}
