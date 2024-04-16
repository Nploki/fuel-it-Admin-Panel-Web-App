import 'package:fuel_it_admin_panel/services/firebase_services.dart';
import 'package:fuel_it_admin_panel/widgets/banner/banner_widget.dart';
import 'package:fuel_it_admin_panel/widgets/category/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuel_it_admin_panel/services/sidebar.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class category_Screen extends StatelessWidget {
  static const String id = "category_Screen";
  const category_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    var _urlController = TextEditingController();
    var _nameController = TextEditingController();
    SideBarWidget sidebar = SideBarWidget();
    FirebaseServices _services = FirebaseServices();
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
      sideBar: SideBarWidget.sideBarMenus(context, category_Screen.id),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category Screen',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                const Divider(
                  thickness: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 320),
                  child: Text(
                    "Add a New Category by Specifying its URL and Name",
                    style: GoogleFonts.chakraPetch(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 35),
                                child: Row(
                                  children: [
                                    Text(
                                      "Name        :  ",
                                      style: GoogleFonts.chakraPetch(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      width: 200,
                                      height: 30,
                                      child: TextField(
                                        controller: _nameController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 0.5),
                                          ),
                                          fillColor: Colors.white,
                                          hintText: "Enter Category Name ",
                                          contentPadding: EdgeInsets.only(
                                              left: 20, top: 10),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5.0, left: 35),
                                child: Row(
                                  children: [
                                    Text(
                                      "Image Url :  ",
                                      style: GoogleFonts.chakraPetch(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      height: 30,
                                      child: TextField(
                                        controller: _urlController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width: 0.5),
                                          ),
                                          fillColor: Colors.white,
                                          hintText: "Enter Category Name ",
                                          contentPadding: EdgeInsets.only(
                                              left: 20, top: 10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_urlController.text.isNotEmpty &&
                                            _nameController.text.isNotEmpty) {
                                          _services.addImage(
                                              context, _urlController.text,
                                              name: _nameController.text);

                                          _urlController.clear();
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              Future.delayed(
                                                  const Duration(seconds: 1),
                                                  () {
                                                Navigator.of(context).pop();
                                              });
                                              return const AlertDialog(
                                                title: Text('Alert'),
                                                content: Text(
                                                    'Please Specified Image URL and Category Name!'),
                                              );
                                            },
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 8, 127, 12)),
                                      child: const Text(
                                        "Add Banner",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 3,
                ),
                category_widget(), //
              ],
            ),
          ],
        ),
      ),
    );
  }
}
