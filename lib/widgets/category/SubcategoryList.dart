import 'package:fuel_it_admin_panel/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubcategoryList extends StatelessWidget {
  final String documentId;

  const SubcategoryList({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices _services = FirebaseServices();

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('vendor_category_image')
          .doc(documentId)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        var data = snapshot.data!.data()! as Map<String, dynamic>;
        var items = List<String>.from(data['sub_category']);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text("No Data Found"));
        }

        return Expanded(
          child: ListView.builder(
            // shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Center(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 0, 247, 123),
                    radius: 15,
                    child: Text((index + 1).toString()),
                  ),
                  title: Text(
                    "\t\t" + items[index],
                    style: GoogleFonts.basic(fontSize: 20),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.red,
                    ),
                    onPressed: () async {
                      await _services.vendor_category_image
                          .doc(documentId)
                          .update({
                        'sub_category': FieldValue.arrayRemove([items[index]]),
                      });
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
