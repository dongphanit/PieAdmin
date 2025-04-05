import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin_panel/models/UserModel.dart';
import 'package:ecommerce_admin_panel/models/ordermodel.dart';
import 'package:ecommerce_admin_panel/services/orders/irepository_order.dart';
import 'package:ecommerce_admin_panel/services/orders/irepository_user.dart';

class RepositoryUser implements IrepositoryUser {
  final databasereference = FirebaseFirestore.instance;

  @override
  Future<List<UserModel>> getUsers() async {
    List<UserModel> _users = [];
    try {
      // Truy vấn để lấy danh sách người dùng từ Firestore
      var value = await databasereference.collection('users').get();
      print("User length: ${value.docs.length}");
      
      if (value.docs.isNotEmpty) {
        // Chuyển đổi các tài liệu thành đối tượng UserModel
        for (var element in value.docs) {
          _users.add(UserModel.fromjson(element.data()));
        }
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
    
    return _users;
  }

  @override
  Future<void> updateUserInfo(String userId, String fieldName, dynamic newValue) async {
    try {
      // Cập nhật thông tin của người dùng theo userId
      await databasereference
          .collection('users')
          .where('uid', isEqualTo: userId)
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          String docId = value.docs.first.id;
          
          // Cập nhật thông tin người dùng tại Firestore
          await databasereference
              .collection('users')
              .doc(docId)
              .update({fieldName: newValue});
        }
      });
    } catch (e) {
      print("Error updating user info: $e");
    }
  }
  
  @override
  Future<void> updateUsers(String orderId, String statusvalue) {
    // TODO: implement updateUsers
    throw UnimplementedError();
  }

}
