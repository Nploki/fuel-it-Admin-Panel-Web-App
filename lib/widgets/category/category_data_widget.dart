import 'package:fuel_it_admin_panel/services/firebase_services.dart';
import 'package:fuel_it_admin_panel/widgets/category/SubcategoryList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryDataWidget extends StatefulWidget {
  final String categoryName;

  const CategoryDataWidget({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<CategoryDataWidget> createState() => _CategoryDataWidgetState();
}

class _CategoryDataWidgetState extends State<CategoryDataWidget> {
  late Future<DocumentSnapshot> future;

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();
    return Dialog(
      child: Container(
        alignment: Alignment.topLeft,
        height: MediaQuery.of(context).size.height,
        width: 400,
        color: Colors.white,
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('vendor_category_image')
              .doc(widget.categoryName)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("No Sub Category Added"),
                );
              }
              var data = snapshot.data!.data()! as Map<String, dynamic>;
              TextEditingController _catController = TextEditingController();
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Main Category : ',
                          style: GoogleFonts.graduate(
                              fontSize: 15, fontWeight: FontWeight.w200),
                        ),
                        Text(
                          data['name'].toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    SubcategoryList(documentId: widget.categoryName),
                    const Divider(
                      thickness: 2,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueGrey.shade200,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5.0),
                            child: Text(
                              "Add Sub Category : ",
                              style: GoogleFonts.teko(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, bottom: 8),
                            child: Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 300,
                                  child: TextField(
                                    controller: _catController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 0.5),
                                      ),
                                      fillColor: Colors.white,
                                      hintText: "Sub - Category Name",
                                      contentPadding:
                                          EdgeInsets.only(left: 20, top: 10),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    CupertinoIcons.add_circled,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  onPressed: () async {
                                    if (_catController.text.isNotEmpty) {
                                      await _services.vendor_category_image
                                          .doc(widget.categoryName)
                                          .update({
                                        'sub_category': FieldValue.arrayUnion(
                                            [_catController.text.toString()]),
                                      });
                                      _catController.clear();
                                    } else {
                                      showAboutDialog(
                                          context: context,
                                          applicationName: "Alert",
                                          children: [
                                            const Text(
                                                "Please Specify Sub Category Name"),
                                          ]);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
