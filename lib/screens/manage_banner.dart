import 'package:fuel_it_admin_panel/services/firebase_services.dart';
import 'package:fuel_it_admin_panel/widgets/banner/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuel_it_admin_panel/services/sidebar.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class BannerScreen extends StatefulWidget {
  static const String id = "banner_screen";
  const BannerScreen({Key? key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  var _urlController = TextEditingController(); // Controller for URL input
  SideBarWidget sidebar = SideBarWidget();
  FirebaseServices _services = FirebaseServices(); // Firebase services instance

  @override
  Widget build(BuildContext context) {
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
      sideBar: SideBarWidget.sideBarMenus(context, BannerScreen.id),
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Banner Screen',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
            const Text("Add / Delete Home Screen Banner Image "),
            const Divider(
              thickness: 3,
            ),
            BannerWidget(), // Display existing banner images
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 320),
              child: Text(
                "Add a New Banner by Specifying its URL",
                style: GoogleFonts.chakraPetch(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 35),
                              child: Center(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  height: 50,
                                  child: TextField(
                                    controller: _urlController,
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Enter Image URL",
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.only(left: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _services.addImage(
                                    context, _urlController.text);
                                _urlController.clear();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black54),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
