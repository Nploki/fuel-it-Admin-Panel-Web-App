import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection('slider');
  CollectionReference vendors = FirebaseFirestore.instance.collection('seller');
  CollectionReference orders = FirebaseFirestore.instance.collection('order');
  CollectionReference riders =
      FirebaseFirestore.instance.collection('delivery_persons');
  CollectionReference vendor_category_image =
      FirebaseFirestore.instance.collection('vendor_category_image');

  Future<void> deleteBanner(String documentId) {
    return banners.doc(documentId).delete();
  }

  Future<void> deletecategory(String documentId) {
    return vendor_category_image.doc(documentId).delete();
  }

  Future<void> addItemToArray(
      String collectionName, String docId, dynamic newItem) async {
    await vendor_category_image.doc(docId).update({
      'your_array_field': FieldValue.arrayUnion([newItem]),
    });
  }

  Future<void> updateVendorSttatus(
      {required String documentId,
      required bool status,
      required String type}) {
    return vendors.doc(documentId).update({type: status ? false : true});
  }

  Future<void> addImage(BuildContext context, String imageUrl,
      {String? name}) async {
    bool confirm = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Please make sure the URL is correct.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      if (name == null) {
        await FirebaseFirestore.instance
            .collection('slider')
            .add({'image': imageUrl});
      } else {
        await FirebaseFirestore.instance
            .collection('vendor_category_image')
            .add({'image': imageUrl, 'name': name, 'sub_category': []});
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.lightGreen,
          content: Text('Banner added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<QuerySnapshot> getAdminCredentials() {
    var result = FirebaseFirestore.instance.collection('Admin').get();
    return result;
  }
}
