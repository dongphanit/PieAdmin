import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin_panel/controllers/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/controllers/orders_controller.dart';
import 'package:ecommerce_admin_panel/models/ordermodel.dart';
import 'package:ecommerce_admin_panel/screens/main/main_screen.dart';
import 'package:ecommerce_admin_panel/screens/orders/view_order_screen.dart';
import 'package:ecommerce_admin_panel/shared/constants.dart';
import 'package:ecommerce_admin_panel/shared/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String? _discountType =
      'percentage'; // Loại giảm giá (theo phần trăm hoặc cố định)
  TextEditingController _discountValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chọn loại giảm giá
                  Text(
                    "The selected discount type: ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: _discountType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _discountType = newValue;
                      });
                    },
                    items: <String>['percentage', 'fixed']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value == 'percentage'
                              ? 'Percentage discount'
                              : 'Fixed discount'));
                    }).toList(),
                  ),
                  SizedBox(height: 20),

             
                  
                  TextField(
                    controller: _discountValueController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter discount value",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Nút lưu thiết lập
                  ElevatedButton(
                    onPressed: () {
                      String discountValue = _discountValueController.text;
                      if (discountValue.isNotEmpty) {
                        
                            context.read<OrdersController>()
                      ..onChangeDiscount(_discountType!, _discountValueController.text);

                        // Thực hiện lưu hoặc xử lý giá trị giảm giá
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Alert"),
                              content: Text(
                                  "The discount has been set: $_discountType - $discountValue"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Close"),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Hiển thị thông báo lỗi
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Please enter the discount value:")),
                        );
                      }
                    },
                    child: Text("Save"),
                  ),
                ],
              ),
            ),
                 // Nhập giá trị giảm giá
                  Row(
                    children: [
                        Text(
                    "Discount: " + context.read<OrdersController>().discountType!, 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                       Text(
                    "Discount Value: " +  context.read<OrdersController>().discountValue, 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Lastest update time: "+ context.read<OrdersController>().lastestUpdateTime,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                    ],
                  ),
                  
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<OrderStatus>(
                  value: context.watch<OrdersController>().table_orderStatus,
                  items: OrderStatus.values.map((OrderStatus orderstatus) {
                    return DropdownMenuItem<OrderStatus>(
                      value: orderstatus,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        child: Text(orderstatus.name),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                    context.read<OrdersController>()
                      ..onchangeTableOrderStatus(value!);
                  },
                ),
              ],
            ),
            Container(
              height: 400,
              child: Consumer<OrdersController>(
                  builder: (context, ordercontorller, child) {
                return DataTable2(
                  columnSpacing: defaultPadding,
                  //minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("Order Id"),
                    ),
                    DataColumn(
                      label: Text("Order Date"),
                    ),
                    DataColumn(
                      label: Text("Status"),
                    ),
                    DataColumn(
                      label: Text("Total Price"),
                    ),
                    DataColumn(
                      label: Text("Invoice"),
                    ),
                    DataColumn(
                      label: Text("Action"),
                    ),
                  ],
                  rows: List.generate(
                    ordercontorller.allOrders.length,
                    (index) => recentOrderDataRow(
                        ordercontorller.allOrders[index], context),
                  ),
                );
              }),
            ),
          ],
        ),
        if (context.watch<OrdersController>().isloadingupdate_orderStatus)
          CircularProgressIndicator(),
      ],
    );
  }

  DataRow recentOrderDataRow(Order1 order, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Text(order.id.toString()),
        ),
        DataCell(Text(order.createdAt.toString().split('.').first)),

        DataCell(buildDropDownList(
            context,
            ["pending", "accepted", "ordered", "received", "completed"],
            order)),
        DataCell(Text(order.productPrice.toString() + " \$")),
        //DataCell(Text(order.uId.toString())),

        // Thêm DataCell cho IconButton để hiển thị hóa đơn
        DataCell(
          IconButton(
            icon: Icon(Icons.receipt, color: Colors.blue),
            onPressed: () {
              // Thực hiện hành động khi nhấn vào biểu tượng, ví dụ: mở modal hiển thị hóa đơn
              showInvoice(context, order);
            },
          ),
        ),
        DataCell(
          TextButton(
            onPressed: () {
              // Thực hiện hành động khi nhấn vào nút "Hoàn thành"
              context.read<OrdersController>()
                ..onchangeOrderStatus(order.id.toString(), "completed");
              context.read<OrdersController>()..getAllorders();
            },
            child: Text(
              "Tick to complete",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        )
      ],
    );
  }

  void showInvoice(BuildContext context, Order1 order) {
    // Mở modal hoặc cửa sổ hiển thị hóa đơn
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invoice for Order #${order.id}'),
          content: Image.network(
            order.imageUrl.first.url,
            fit: BoxFit.cover,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  buildDropDownList(BuildContext context, List<String> list, Order1 order) {
    // Check if the list is empty
    if (list.isEmpty) {
      return Text("No items available");
    }

    // Set a valid value for the dropdown (fallback to the first item in the list if "view" isn't in the list)

    Map<String, String> orderStatusMap = {
      "pending": "Waiting for order placement",
      "accepted": "Order accepted by Card Holder",
      "ordered": "Order has been placed",
      "received": "Buyer has received the product",
      "completed": "Transaction completed",
    };
    return DropdownButton<String>(
      value: orderStatusMap.containsKey(order.status) ? order.status : null,
      items: orderStatusMap.keys.map((String orderstatus) {
        return DropdownMenuItem<String>(
          value: orderstatus,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Container(
              child: Text(
                orderStatusMap[orderstatus]!,
                style: TextStyle(
                  fontSize: 8,
                  color: orderstatus == "pending"
                      ? Colors.blue
                      : orderstatus == "accepted"
                          ? Colors.orange
                          : orderstatus == "ordered"
                              ? Colors.black
                              : orderstatus == "received"
                                  ? Colors.pink
                                  : orderstatus == "completed"
                                      ? Colors.green
                                      : Colors.blue.shade400, // Mặc định
                ),
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        print(value);
        if (value == "view") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewOrderScreen(order)),
          );
        } else {
          context.read<OrdersController>()
            ..onchangeOrderStatus(order.id.toString(), value!);
        }
      },
    );
  }
}
