import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuel_it_admin_panel/services/sidebar.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class admin_users extends StatelessWidget {
  static const String id = "admin_users";
  const admin_users({super.key});

  @override
  Widget build(BuildContext context) {
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
      sideBar: SideBarWidget.sideBarMenus(context, admin_users.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Admin User',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
