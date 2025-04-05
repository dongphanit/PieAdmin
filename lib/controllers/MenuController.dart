import 'package:ecommerce_admin_panel/controllers/auth_controller.dart';
import 'package:ecommerce_admin_panel/models/UserModel.dart';
import 'package:ecommerce_admin_panel/models/menu_model.dart';
import 'package:ecommerce_admin_panel/models/ordermodel.dart';
import 'package:ecommerce_admin_panel/screens/dashboard/dashboard_screen.dart';
import 'package:ecommerce_admin_panel/screens/login/login_screen.dart';
import 'package:ecommerce_admin_panel/screens/orders/orders_screen.dart';
import 'package:ecommerce_admin_panel/screens/orders/view_order_screen.dart';
import 'package:ecommerce_admin_panel/screens/products/products_screen.dart';
import 'package:ecommerce_admin_panel/screens/users/users_screen.dart';
import 'package:ecommerce_admin_panel/shared/constants.dart';
import 'package:flutter/material.dart';

class MenuControllerA extends ChangeNotifier {
  final AuthController? _authProvider;

  int currentSelectedIndex = 0;

  void onChangeSelectedMenu(index) {
    print(index);
    for (int i = 0; i < menuModelList.length; i++) {
      if (i == index) {
        print(menuModelList[i].title.toString() + " selected");
        menuModelList[i].isselected = true;
      } else
        menuModelList[i].isselected = false;
    }
    currentSelectedIndex = index;
    // menuModelList.forEach((element) {
    //   print(element.title.toString() + " - " + element.isselected.toString());
    // });
    notifyListeners();
  }

  final GlobalKey<ScaffoldState> getscaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> getviewOrderscaffoldKey =
      GlobalKey<ScaffoldState>();

  void main_controlMenu() {
    if (!getscaffoldKey.currentState!.isDrawerOpen) {
      getscaffoldKey.currentState!.openDrawer();
    }
  }

  void viewOrder_controlMenu() {
    if (!getviewOrderscaffoldKey.currentState!.isDrawerOpen) {
      getviewOrderscaffoldKey.currentState!.openDrawer();
    }
  }

  MenuControllerA(this._authProvider) {
    buildMenu();
  }

  final _offline_screen = [LoginScreen()];

  final _screens = [
    OrdersScreen(),
    UsersScreen(),
  ];

  final _offline_screens_title = ['Login'];
  final _screens_title = [
    'Orders',
    'Users',
  ];

  List<MenuModel> _offline_menuModelList = [
    MenuModel("login", "assets/icons/menu_login.svg")
  ];

  List<MenuModel> _menuModelList = [
    MenuModel("Orders", "assets/icons/menu_tran.svg"),
    MenuModel("Users", "assets/icons/menu_task.svg"),
    MenuModel("Logout", "assets/icons/menu_logout.svg"),
  ];

  List<MenuModel> menuModelList = [];
  var screens_title = [];
  var screens = [];
  void buildMenu() {
    if (_authProvider != null && _authProvider!.currentuserModel == null) {
      screens_title = _offline_screens_title;
      menuModelList = _offline_menuModelList;
      screens = _offline_screen;
    } else {
      screens_title = _screens_title;
      menuModelList = _menuModelList;
      screens = _screens;
    }
    notifyListeners();
  }
}
