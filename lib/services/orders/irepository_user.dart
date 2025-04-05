import 'package:ecommerce_admin_panel/models/UserModel.dart';
import 'package:ecommerce_admin_panel/models/ordermodel.dart';

abstract class IrepositoryUser {
  Future<List<UserModel>> getUsers() ;
  Future<void> updateUsers(String orderId, String statusvalue);
}
