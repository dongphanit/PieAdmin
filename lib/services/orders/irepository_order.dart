import 'package:ecommerce_admin_panel/models/ordermodel.dart';

abstract class IrepositoryOrder {
  Future<List<Order1>> getorders() ;
  Future<void> updateOrderStatus(String orderId, String statusvalue);
}
