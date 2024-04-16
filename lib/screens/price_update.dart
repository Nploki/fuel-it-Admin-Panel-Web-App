import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuel_it_admin_panel/services/sidebar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class PriceUpdate extends StatefulWidget {
  static const String id = "PriceUpdate";
  @override
  _PriceUpdateState createState() => _PriceUpdateState();
}

class _PriceUpdateState extends State<PriceUpdate> {
  final TextEditingController _petrolController = TextEditingController();
  final TextEditingController _dieselController = TextEditingController();

  final PriceServices _priceServices = PriceServices();

  @override
  void initState() {
    super.initState();
    _fetchPrices();
  }

  void _fetchPrices() async {
    try {
      QuerySnapshot priceSnapshot = await _priceServices.getPrice();
      if (priceSnapshot.docs.isNotEmpty) {
        setState(() {
          _petrolController.text =
              priceSnapshot.docs[0].get('petrol').toString();
          _dieselController.text =
              priceSnapshot.docs[0].get('diesel').toString();
        });
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching prices: $error')),
      );
    }
  }

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
      sideBar: SideBarWidget.sideBarMenus(context, PriceUpdate.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Price Update',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  const SizedBox(width: 100),
                  Image.network(
                    'https://static.vecteezy.com/system/resources/previews/024/207/632/original/vintage-bike-logo-cartoon-with-ai-generative-free-png.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 300),
                            child: Text("Petrol",
                                style: GoogleFonts.novaSquare(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 2,
                                    color: Colors.lightGreen)),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: TextFormField(
                              controller: _petrolController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Petrol Price',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.local_gas_station),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 225),
                            child: ElevatedButton(
                              onPressed: () {
                                _updatePetrolPrice();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                              ),
                              child: Text('Update Petrol Price',
                                  style: GoogleFonts.chakraPetch(
                                      letterSpacing: 3,
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  const SizedBox(width: 100),
                  Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLBpPsHKamgU782Oe-woViO4B1YYnlbSESDnggUXSnwaXe3uT8kuxAROVogRRxUsxPaOE&usqp=CAU',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 300),
                            child: Text("Diesel",
                                style: GoogleFonts.novaSquare(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 2,
                                    color: Colors.lightGreen)),
                          ),
                          SizedBox(height: 15),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .5,
                            child: TextFormField(
                              controller: _dieselController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Diesel Price',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.local_gas_station),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 225),
                            child: ElevatedButton(
                              onPressed: () {
                                _updateDieselPrice();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                              ),
                              child: Text('Update Diesel Price',
                                  style: GoogleFonts.chakraPetch(
                                      letterSpacing: 3,
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updatePetrolPrice() async {
    try {
      String petrolPrice = _petrolController.text.toString();

      await _priceServices.updatePetrolPrice(petrolPrice);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Petrol price updated successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update petrol price: $error')),
      );
    }
  }

  void _updateDieselPrice() async {
    try {
      String dieselPrice = _dieselController.text.toString();

      await _priceServices.updateDieselPrice(dieselPrice);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Diesel price updated successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update diesel price: $error')),
      );
    }
  }
}

class PriceServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getPrice() {
    return _firestore.collection('price').get();
  }

  Future<void> updatePetrolPrice(String petrolPrice) async {
    await _firestore
        .collection('price')
        .doc('price')
        .update({'petrol': petrolPrice});
  }

  Future<void> updateDieselPrice(String dieselPrice) async {
    await _firestore
        .collection('price')
        .doc('price')
        .update({'diesel': dieselPrice});
  }
}
