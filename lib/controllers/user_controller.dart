import 'package:ecommerce_admin_panel/models/UserModel.dart'; // Chỉnh sửa Model thành User
import 'package:ecommerce_admin_panel/services/orders/repository_user.dart';
import 'package:ecommerce_admin_panel/shared/remote/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserController extends ChangeNotifier {
  RepositoryUser repositoryUser = RepositoryUser(); // Sử dụng RepositoryUser
  // Get all users
  bool isloadingGetUser = false;
  String selectedRole = "All";
  List<UserModel> allUsers = [];
  List<UserModel> original_allUsers = [];

  Future<void> getAllUsers() async {
    print('Loading users...');
    allUsers = [];
    isloadingGetUser = true;
    notifyListeners();
    allUsers = await repositoryUser.getUsers();
    isloadingGetUser = false;
    print(allUsers.length);
    notifyListeners();
  }

  // Search for a user
  bool isloadingSearchUser = false;
  bool? ishasData = false;

  Future<void> searchUser(String name) async {
    allUsers = [];

    if (name.toString().trim() != "") {
      isloadingSearchUser = true;
      notifyListeners();
      DioHelper.dio!.get("users/search",
          queryParameters: {"name": '$name'}).then((value) {
        value.data.forEach((element) {
          allUsers.add((UserModel.fromjson(element)));
        });
        isloadingSearchUser = false;
        notifyListeners();
      }).catchError((error) {
        print(error.toString());
      });
    } else {
      allUsers = original_allUsers;
      notifyListeners();
    }
  }

  Future<void> updateUser(UserModel user) async {
    // //isloadingGetUser = true;
    // //notifyListeners();
    // DioHelper.dio!.put("users", data: {
    //   "id": user.uid,
    //   "name": user.name,
    //   "email": user.email,
    //   "role": user.role,
    //   "status": user.status,
    // }).then((value) {
    //   allUsers.map((u) => {
    //         if (u == user) {
    //           u.name = user.name,
    //           u.email = user.email,
    //           u.role = user.role,
    //           u.status = user.status
    //         }
    //       });

    //   original_allUsers = allUsers;
    //   //isloadingGetUser = false;

    //   allUsers.forEach((element) {
    //     print(element.toJson());
    //   });
    //   notifyListeners();
    // });
  }
}
