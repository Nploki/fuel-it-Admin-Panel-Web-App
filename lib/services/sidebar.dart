import 'package:fuel_it_admin_panel/screens/home_screen.dart';
import 'package:fuel_it_admin_panel/screens/vendor_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuel_it_admin_panel/screens/admin_users.dart';
import 'package:fuel_it_admin_panel/screens/login_screen.dart';
import 'package:fuel_it_admin_panel/screens/manage_banner.dart';
import 'package:fuel_it_admin_panel/screens/order_screen.dart';
import 'package:fuel_it_admin_panel/screens/price_update.dart';
import 'package:fuel_it_admin_panel/screens/rider_screen.dart';
import 'package:fuel_it_admin_panel/screens/category_screen.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SideBarWidget {
  static sideBarMenus(context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: Colors.black54,
      activeIconColor: Colors.white,
      activeTextStyle: TextStyle(color: Colors.white),
      items: [
        const AdminMenuItem(
          title: 'Dashboard',
          route: home_screen.id,
          icon: Icons.dashboard,
        ),
        const AdminMenuItem(
          title: 'Banners',
          route: BannerScreen.id,
          icon: CupertinoIcons.photo_fill_on_rectangle_fill,
        ),
        AdminMenuItem(
          title: 'Vendors',
          route: VendorScreen.id,
          icon: CupertinoIcons.person_2_alt,
        ),
        const AdminMenuItem(
          title: 'Categories',
          route: category_Screen.id,
          icon: Icons.category,
        ),
        const AdminMenuItem(
          title: 'Orders',
          route: Order_Screen.id,
          icon: CupertinoIcons.cart_fill,
        ),
        const AdminMenuItem(
          title: 'price update',
          route: PriceUpdate.id,
          icon: CupertinoIcons.money_rubl_circle,
        ),
        const AdminMenuItem(
          title: 'riders',
          route: RiderScreen.id,
          icon: Icons.electric_bike_sharp,
        ),
        const AdminMenuItem(
          title: 'Exit',
          route: login_screen.id,
          icon: Icons.exit_to_app_sharp,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: const Color(0xff444444),
        child: Center(
          child: Text(
            'Menu',
            style: GoogleFonts.rem(
                color: Colors.white, fontSize: 20, letterSpacing: 2),
          ),
        ),
      ),
      footer: Container(
        height: 60,
        width: double.infinity,
        color: const Color(0xff444444),
        child: Image.network(
            "https://fuel-it.com/cdn/shop/t/47/assets/fuel-it--logo.png?v=112929530141685107371696030508"),
      ),
    );
  }
}
