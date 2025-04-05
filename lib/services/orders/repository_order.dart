import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/models/ordermodel.dart';
import 'package:ecommerce_admin_panel/services/orders/irepository_order.dart';

class RepositoryOrder implements IrepositoryOrder {
  final databasereference = FirebaseFirestore.instance;
@override
  Future<List<Order1>> getorders() async {
  List<Order1> _orders = [];
  try {
    var value = await databasereference.collection('orders').get();
    print("order length: ${value.docs.length}");
    
    if (value.docs.isNotEmpty) {
      for (var element in value.docs) {
        _orders.add(Order1.fromJson({...element.data(), "id": element.id}));
      }
    }
  } catch (e) {
    print("Error fetching orders: $e");
  }
  
  return _orders; 
}
  @override
  Future<Map<String, dynamic>?> getSettings() async {
  try {
    DocumentSnapshot orderSnapshot = await databasereference.collection('settings').doc("discount").get();
    
    return orderSnapshot.data() as Map<String, dynamic>?;
   
  } catch (e) {
    print("Error fetching orders: $e");
  }
  return null;
  
}

  @override
  Future<void> settingDiscount(String key, String value) async {
        await databasereference
            .collection('settings')
            .doc("discount")
            .update({"discountType": key, "discountValue": value, "lastestTime": DateTime.now().toIso8601String()});
      }

  @override
  Future<void> updateOrderStatus(String orderId, String statusvalue) async {
    // // await databasereference
    // //     .collection('orders')
    // //     .where('orderId', isEqualTo: orderId)
    // //     .get()
    // //     .then((value) async {
    // //   if (value.docs.length > 0) {
    //     String docId = value.docs.first.id;
        await databasereference
            .collection('orders')
            .doc(orderId)
            .update({'status': statusvalue});
      }
    // });
  // }
}
