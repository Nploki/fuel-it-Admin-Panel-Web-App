import 'package:fuel_it_admin_panel/services/firebase_services.dart';
import 'package:fuel_it_admin_panel/widgets/category/category_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class category_widget extends StatelessWidget {
  const category_widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();

    return StreamBuilder<QuerySnapshot>(
      stream: _services.vendor_category_image.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          width: MediaQuery.of(context).size.width * .7,
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              String documentId = document.id; // Get the document ID
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CategoryDataWidget(
                                  categoryName: documentId,
                                );
                              });
                        },
                        child: Container(
                          height: 500,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 125,
                                height: 125,
                                child: Card(
                                  color: Color.fromARGB(255, 233, 0, 0)
                                      .withOpacity(0.5),
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(data['image'] ?? "",
                                          width: 125,
                                          fit: BoxFit.fill,
                                          height: 125, errorBuilder:
                                              (BuildContext context,
                                                  Object exception,
                                                  StackTrace? stackTrace) {
                                        return const Center(
                                          child: Text(
                                              'Image not available \n Please Delete this Banner'),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data['name'].toString().toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.chakraPetch(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 5,
                        child: IconButton(
                          onPressed: () {
                            _services.deletecategory(documentId);
                          },
                          icon: const Icon(
                            Icons.clear_sharp,
                            size: 20,
                            color: Color.fromARGB(255, 127, 120, 120),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
