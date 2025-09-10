import 'package:wellnesstrackerapp/features/customers/model/customer_model/customer_model.dart';
import 'package:wellnesstrackerapp/global/models/user_role_enum.dart';

final fakeCustomer = CustomerModel(
  id: 1,
  name: "user",
  email: "user@gmail.com",
  status: "active",
  role: UserRoleEnum.user,
  createdAt: DateTime.now().toString(),
);
