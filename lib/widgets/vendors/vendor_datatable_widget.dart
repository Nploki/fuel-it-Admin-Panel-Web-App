import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:fuel_it_admin_panel/services/firebase_services.dart';

import 'vendor_detail_widget.dart';

class VendorDataTable extends StatefulWidget {
  const VendorDataTable({Key? key}) : super(key: key);

  @override
  State<VendorDataTable> createState() => _VendorDataTableState();
}

class _VendorDataTableState extends State<VendorDataTable> {
  FirebaseServices _services = FirebaseServices();

  int tag = 0;
  List<String> options = [
    'All vendors',
    'Active Vendors',
    'In Active Vendors',
    'Top Picked',
    'Top Rated',
    'Free Gas',
    'Toilet',
    'Drinking Water',
  ];

  bool? topPicked;
  bool? active;
  bool? hasFreeGas;
  bool? hasToilet;
  bool? hasDrinkingWater;

  filter(val) {
    setState(() {
      switch (val) {
        case 0:
          active = null;
          topPicked = null;
          hasFreeGas = null;
          hasToilet = null;
          hasDrinkingWater = null;
          break;
        case 1:
          active = true;
          topPicked = null;
          hasFreeGas = null;
          hasToilet = null;
          hasDrinkingWater = null;
          break;
        case 2:
          active = false;
          topPicked = null;
          hasFreeGas = null;
          hasToilet = null;
          hasDrinkingWater = null;
          break;
        case 3:
          active = null;
          topPicked = true;
          hasFreeGas = null;
          hasToilet = null;
          hasDrinkingWater = null;
          break;
        case 4:
          active = null;
          topPicked = null;
          hasFreeGas = null;
          hasToilet = null;
          hasDrinkingWater = null;
          break;
        case 5:
          active = null;
          topPicked = null;
          hasFreeGas = true;
          hasToilet = null;
          hasDrinkingWater = null;
          break;
        case 6:
          active = null;
          topPicked = null;
          hasFreeGas = null;
          hasToilet = true;
          hasDrinkingWater = null;
          break;
        case 7:
          active = null;
          topPicked = null;
          hasFreeGas = null;
          hasToilet = null;
          hasDrinkingWater = true;
          break;
        default:
          active = null;
          topPicked = null;
          hasFreeGas = null;
          hasToilet = null;
          hasDrinkingWater = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChipsChoice<int>.single(
          choiceStyle: C2ChipStyle.filled(
            selectedStyle: const C2ChipStyle(
              backgroundColor: Colors.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
          ),
          choiceCheckmark: true,
          value: tag,
          onChanged: (val) {
            setState(() => tag = val);
            filter(val);
          },
          choiceItems: C2Choice.listFrom<int, String>(
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
        ),
        const Divider(
          thickness: 3,
        ),
        StreamBuilder(
          stream: _services.vendors
              .where('isTopPicked', isEqualTo: topPicked)
              .where('accVerified', isEqualTo: active)
              .where('gas', isEqualTo: hasFreeGas)
              .where('restroom', isEqualTo: hasToilet)
              .where('drinking_water', isEqualTo: hasDrinkingWater)
              .snapshots(),
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
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                //headings
                columns: const <DataColumn>[
                  DataColumn(
                      label: Text(
                    "Actie\nInactive",
                    textAlign: TextAlign.center,
                  )),
                  DataColumn(
                      label: Text("Top\nPicked", textAlign: TextAlign.center)),
                  DataColumn(label: Text("Shop Name")),
                  DataColumn(label: Text("Rating")),
                  DataColumn(
                      label: Text("Total\nSales", textAlign: TextAlign.center)),
                  DataColumn(label: Text("Mobile")),
                  DataColumn(label: Text("Email")),
                  DataColumn(label: Text("Details")),
                  DataColumn(label: Text("Gas")),
                  DataColumn(label: Text("Toilet")),
                  DataColumn(label: Text("Water")),
                ],
                //details
                rows: _vendorDetailRow(snapshot.data, _services, context),
              ),
            );
          },
        ),
      ],
    );
  }

  List<DataRow> _vendorDetailRow(
      QuerySnapshot? snapshot, FirebaseServices _services, context) {
    if (snapshot == null) {
      return []; // Return an empty list if snapshot is null
    }

    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()
          as Map<String, dynamic>; // Cast data to Map<String, dynamic>
      return DataRow(
        cells: [
          DataCell(
            IconButton(
              onPressed: () {
                _services.updateVendorSttatus(
                  documentId: data['uid'],
                  status: data['accVerified'],
                  type: 'accVerified',
                );
                if (!data['accVerified']) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.lightGreen,
                      content: Text('Account Verified successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Account has been Deactivated'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              icon: (data['accVerified'] ?? false)
                  ? const Icon(
                      CupertinoIcons.checkmark_shield_fill,
                      color: Colors.green,
                    )
                  : const Icon(
                      CupertinoIcons.clear_circled_solid,
                      color: Colors.red,
                    ),
            ),
          ),
          DataCell(
            IconButton(
              onPressed: () {
                _services.updateVendorSttatus(
                  documentId: data['uid'],
                  status: data['isTopPicked'],
                  type: 'isTopPicked',
                );
                if (!data['isTopPicked']) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.lightGreen,
                      content: Text('Changed to Top Picked Store'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Removed from Top Picked Store'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              icon: (data['isTopPicked'] ?? false)
                  ? const Icon(
                      CupertinoIcons.check_mark_circled,
                      color: Colors.green,
                    )
                  : const Icon(
                      CupertinoIcons.clear_circled,
                      color: Colors.redAccent,
                    ),
            ),
          ),
          DataCell(
            Text(
              data["shopName"] ?? '',
            ),
          ),
          DataCell(
            Row(
              children: [
                const Icon(CupertinoIcons.star_fill),
                const SizedBox(width: 4),
                Text(data['rating']?.toString() ?? ''),
              ],
            ),
          ),
          const DataCell(Text("20,000")),
          DataCell(
            Text(
              data["mobileno"] ?? '',
            ),
          ),
          DataCell(
            Text(
              data["email"] ?? '',
            ),
          ),
          DataCell(
            IconButton(
              icon: const Icon(CupertinoIcons.doc_on_clipboard_fill),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return VendorDetailBox(
                        uid: data["uid"],
                      );
                    });
              },
            ),
          ),
          DataCell(
            (data['gas'] ?? false)
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.clear,
                    color: Colors.redAccent,
                  ),
          ),
          DataCell(
            (data['restroom'] ?? false)
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.clear,
                    color: Colors.redAccent,
                  ),
          ),
          DataCell(
            (data['drinking_water'] ?? false)
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.clear,
                    color: Colors.redAccent,
                  ),
          ),
        ],
      );
    }).toList(); // Convert Iterable to List
    return newList;
  }
}
