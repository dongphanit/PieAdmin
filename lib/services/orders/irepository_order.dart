import 'package:ecommerce_admin_panel/models/ordermodel.dart';

abstract class IrepositoryOrder {
  Future<List<Order1>> getorders() ;
  Future<Map<String, dynamic>?> getSettings();
  Future<void> settingDiscount(String key, String value);
  Future<void> updateOrderStatus(String orderId, String statusvalue);
}
