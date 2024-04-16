import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fuel_it_admin_panel/services/firebase_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuel_it_admin_panel/services/sidebar.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Order_Screen extends StatelessWidget {
  static const String id = "Order_Screen";
  const Order_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    SideBarWidget sidebar = SideBarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Fuel - IT Admin Panel',
          style: GoogleFonts.ubuntu(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      sideBar: SideBarWidget.sideBarMenus(context, Order_Screen.id),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Orders',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 10),
              const Text("View All Order Details."),
              const Divider(
                thickness: 3,
              ),
              SingleChildScrollView(
                child: StreamBuilder(
                  stream: _services.orders.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something Went Wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        showBottomBorder: true,
                        dataRowMaxHeight: 60,
                        headingRowColor:
                            MaterialStateProperty.all(Colors.grey[200]),
                        // headings
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text("Order ID"),
                          ),
                          DataColumn(
                            label: Text("User ID"),
                          ),
                          DataColumn(
                            label: Text("ShopName"),
                          ),
                          DataColumn(
                            label: Text("Product Name"),
                          ),
                          DataColumn(
                            label: Text("Amount"),
                          ),
                          DataColumn(
                            label: Text("Status"),
                          ),
                        ],
                        // details
                        rows:
                            _orderDetailRow(snapshot.data, _services, context),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataRow> _orderDetailRow(
      QuerySnapshot? snapshot, FirebaseServices _services, context) {
    if (snapshot == null) {
      return [];
    }

    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()
          as Map<String, dynamic>; // Cast data to Map<String, dynamic>
      return DataRow(
        cells: [
          DataCell(
            Text(
              document.id, // Assuming Order ID is stored as the document ID
            ),
          ),
          DataCell(
            Text(
              data["userId"] ?? '',
            ),
          ),
          DataCell(
            Text(
              data["shopName"]?.toString() ?? ' ',
            ),
          ),
          DataCell(Text(
            data["PrdName"]?.toString() ?? ' ',
          )),
          DataCell(
            Text(
              "Rs:" + data["price"]!.toString() ?? ' ',
            ),
          ),
          DataCell(
            Row(
              children: [
                Icon(
                  data["orderStatus"] == ""
                      ? Icons.access_time
                      : data["orderStatus"] == "true"
                          ? Icons.check_circle
                          : Icons.cancel,
                  color: data["orderStatus"] == ""
                      ? Colors.blue
                      : data["orderStatus"] == "true"
                          ? Colors.green
                          : Colors.red,
                ),
                const SizedBox(width: 5),
                Text(
                  data["orderStatus"] == ""
                      ? "Pending"
                      : data["orderStatus"] == "true"
                          ? "Accepted"
                          : "Rejected",
                  style: TextStyle(
                    color: data["orderStatus"] == ""
                        ? Colors.blue
                        : data["orderStatus"] == "true"
                            ? Colors.green
                            : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList(); // Convert Iterable to List
    return newList;
  }
}
