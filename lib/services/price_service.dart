import 'package:cloud_firestore/cloud_firestore.dart';

class PriceServices {
  Future<QuerySnapshot> getPrice() {
    return FirebaseFirestore.instance.collection('price').get();
  }
}
