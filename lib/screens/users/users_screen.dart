import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/controllers/user_controller.dart';
import 'package:ecommerce_admin_panel/models/UserModel.dart';
import 'package:ecommerce_admin_panel/screens/main/main_screen.dart';
import 'package:ecommerce_admin_panel/shared/constants.dart';
import 'package:ecommerce_admin_panel/shared/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  value: context.watch<UserController>().selectedRole,
                  items: ["All", "CardHolder", "Admin"].map((String role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Text(role),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                    // context.read<UserController>()
                    //   ..onchangeUserRole(value!);
                  },
                ),
              ],
            ),
            Container(
              height: 400,
              child: Consumer<UserController>(
                  builder: (context, userController, child) {
                return DataTable2(
                  columnSpacing: defaultPadding,
                  //minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("User Id"),
                    ),
                    DataColumn(
                      label: Text("Name"),
                    ),
                    DataColumn(
                      label: Text("Email"),
                    ),
                    DataColumn(
                      label: Text("Phone Number"),
                    ),
                    DataColumn(
                      label: Text("Role"),
                    ),
                    DataColumn(
                      label: Text("Action"),
                    ),
                  ],
                  rows: List.generate(
                    userController.allUsers.length,
                    (index) => recentUserDataRow(
                        userController.allUsers[index], context),
                  ),
                );
              }),
            ),
          ],
        ),
       
      ],
    );
  }

  DataRow recentUserDataRow(UserModel user, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Text(user.userId ?? ""),
        ),
        DataCell(Text(user.name ?? "No name")),
        DataCell(Text(user.email ?? "No email")),
        DataCell(Text(user.phoneNumber ?? "No phone number")),
        DataCell(Text(user.role ?? "No role")),
        DataCell(buildDropDownList(context, ["CardHolder", "Admin", "view"], user)),
      ],
    );
  }

  buildDropDownList(BuildContext context, List<String> list, UserModel user) {
    // Check if the list is empty
    if (list.isEmpty) {
      return Text("No items available");
    }

    // Set a valid value for the dropdown (fallback to the first item in the list if "view" isn't in the list)
    String currentValue = list.contains("view") ? "view" : list.first;

    return DropdownButton<String>(
      value: currentValue,
      items: list.map((String role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Container(
              child: Text(
                role,
                style: TextStyle(
                  color: role == "Admin"
                      ? Colors.green.shade400
                      : role == "view"
                          ? Colors.white70
                          : Colors.blue.shade400,
                ),
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        print(value);
        if (value == "view") {
          
        } else {
          
        }
      },
    );
  }
}
