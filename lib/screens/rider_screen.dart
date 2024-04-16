import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fuel_it_admin_panel/services/firebase_services.dart';
import 'package:fuel_it_admin_panel/services/sidebar.dart';

class RiderScreen extends StatelessWidget {
  static const String id = "RiderScreen";

  const RiderScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    SideBarWidget sidebar = SideBarWidget();

    Future<String?> getShopNameByShopId(String shopId) async {
      try {
        QuerySnapshot querySnapshot =
            await _services.vendors.where('uid', isEqualTo: shopId).get();
        if (querySnapshot.docs.isNotEmpty) {
          // return querySnapshot.docs.first.data()['shopName'] as String?;
        } else {
          return null;
        }
      } catch (e) {
        print('Error retrieving shop name: $e');
        return null;
      }
    }

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
      sideBar: SideBarWidget.sideBarMenus(context, RiderScreen.id),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Riders',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
            const SizedBox(height: 10),
            const Text("View All Rider Details."),
            const Divider(
              thickness: 3,
            ),
            StreamBuilder(
              stream: _services.riders.snapshots(),
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
                        label: Text("Rider ID"),
                      ),
                      DataColumn(
                        label: Text("Name"),
                      ),
                      DataColumn(
                        label: Text("Shop Name"),
                      ),
                      DataColumn(
                        label: Text("Phone"),
                      ),
                      DataColumn(
                        label: Text("Email"),
                      ),
                    ],
                    rows: _riderDetailRow(snapshot.data, _services, context),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _riderDetailRow(
      QuerySnapshot? snapshot, FirebaseServices _services, context) {
    if (snapshot == null) {
      return [];
    }

    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      return DataRow(
        cells: [
          DataCell(
            Text(
              data["id"] ?? '',
            ),
          ),
          DataCell(
            Text(
              data["name"] ?? '',
            ),
          ),
          DataCell(
            Text(
              data["name"] ?? '',
            ),
          ),
          DataCell(
            Text(
              data["phone"]?.toString() ?? '',
            ),
          ),
          DataCell(
            Text(
              data["email"]?.toString() ?? '',
            ),
          ),
        ],
      );
    }).toList();
    return newList;
  }
}
