import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_it_admin_panel/services/firebase_services.dart';
import 'package:provider/provider.dart';

class VendorDetailBox extends StatefulWidget {
  final String uid;

  const VendorDetailBox({Key? key, required this.uid}) : super(key: key);

  @override
  State<VendorDetailBox> createState() => _VendorDetailBoxState();
}

class _VendorDetailBoxState extends State<VendorDetailBox> {
  FirebaseServices _services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _services.vendors.doc(widget.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if data is available and not null
        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return const Center(child: Text("No data available"));
        }

        // Accessing data from the snapshot
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
        String imageUrl = data['url'] ?? '';
        String shopName = data['shopName'] ?? '';
        String number = data['mobileno'] ?? '';
        String email = data['email'] ?? '';
        String address = data['address'] ?? '';
        bool TopPicked = data['isTopPicked'] ?? '';
        bool verified = data['accVerified'] ?? '';

        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.network(imageUrl,
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 200,
                            child: Text(
                              shopName,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.averiaLibre(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      const Divider(
                        thickness: 3,
                      ),
                      _buildContactInfo('Contact Number', number),
                      _buildContactInfo('Email', email),
                      _buildContactInfo('Address', address),
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Container(
                                  child: Text(
                                    "Top Picked",
                                    style: GoogleFonts.mina(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 0, right: 7.5),
                                  child: Text(":"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  child: TopPicked
                                      ? const Chip(
                                          backgroundColor: Colors.green,
                                          label: Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Top Picked",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container()),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Divider(
                          thickness: 2,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Wrap(
                          verticalDirection: VerticalDirection.down,
                          // alignment: WrapAlignment.end,
                          direction: Axis.horizontal,
                          spacing: 10,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: Card(
                                color: Colors.orangeAccent.withOpacity(.9),
                                elevation: 4,
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          CupertinoIcons.money_dollar_circle,
                                          size: 50,
                                          color: Colors.black54,
                                        ),
                                        Text("Total Revenue"),
                                        Text("12,000"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: Card(
                                color: Colors.orangeAccent.withOpacity(.9),
                                elevation: 4,
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          CupertinoIcons.cart_fill,
                                          size: 50,
                                          color: Colors.black54,
                                        ),
                                        Text("Active Orders"),
                                        Text("6"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: Card(
                                color: Colors.orangeAccent.withOpacity(.9),
                                elevation: 4,
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.shopping_bag,
                                          size: 50,
                                          color: Colors.black54,
                                        ),
                                        Text("Orders"),
                                        Text("130"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: Card(
                                color: Colors.orangeAccent.withOpacity(.9),
                                elevation: 4,
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.grain_rounded,
                                          size: 50,
                                          color: Colors.black54,
                                        ),
                                        Text("Products"),
                                        Text("7 Products"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              height: 120,
                              child: Card(
                                color: Colors.orangeAccent.withOpacity(.9),
                                elevation: 4,
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.list_alt_rounded,
                                          size: 50,
                                          color: Colors.black54,
                                        ),
                                        Text("Statement"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: verified
                      ? const Chip(
                          backgroundColor: Colors.green,
                          label: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Active",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )
                      : const Chip(
                          backgroundColor: Colors.red,
                          label: Row(
                            children: [
                              Icon(
                                CupertinoIcons.clear_circled,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "In Active",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: Text(
                  title,
                  style: GoogleFonts.tomorrow(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2),
                ),
              ),
            ),
            Container(
              child: const Padding(
                padding: EdgeInsets.only(left: 0, right: 7.5),
                child: Text(":"),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
