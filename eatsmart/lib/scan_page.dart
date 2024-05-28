import 'dart:async';
import 'dart:convert';
import 'package:eatsmart/account_backend/global.dart';
import 'package:eatsmart/pantry_products_backend/pantry_data.dart';
import 'package:eatsmart/pantry_products_backend/type.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(home: BarcodeScannerPage()));

class BarcodeScannerPage extends StatefulWidget {
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  List<String> scannedItems = [];
  bool isScanning = false;
  String selectedPantry = 'Pantry1'; // Default selected pantry
  List<Pantry> pantries = [];

  @override
  void initState() {
    super.initState();
    loadPantries();
  }

  Future<void> loadPantries() async {
    int userId = getID();
    final List<Pantry> loadedPantries = await getPantryData(userId);
    setState(() {
      pantries = loadedPantries;
      if (pantries.isNotEmpty) {
        selectedPantry = pantries[0].name; // Default to the first pantry
      }
    });
  }

  Future<String> fetchProductName(String barcode) async {
    final String apiEndpoint = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';

    try {
      final response = await http.get(Uri.parse(apiEndpoint));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == 1 && responseData['product']['product_name'] != null) {
          final String productName = responseData['product']['product_name'];
          return productName;
        } else {
          return 'Product not found';
        }
      } else {
        print('Server error: ${response.statusCode}');
        return 'Product not found';
      }
    } catch (e) {
      print('Error fetching product data: $e');
      return 'Error retrieving product';
    }
  }

  Future<void> scanBarcode() async {
    if (isScanning) return;

    setState(() {
      isScanning = true;
    });

    var options = ScanOptions(
      strings: {
        'cancel': 'Cancel',
        'flash_on': 'Flash on',
        'flash_off': 'Flash off',
      },
      autoEnableFlash: false,
      android: AndroidOptions(
        aspectTolerance: 0.00,
        useAutoFocus: true,
      ),
    );

    try {
      var result = await BarcodeScanner.scan(options: options);
      if (result.rawContent.isNotEmpty) {
        final String barcode = result.rawContent;

        final String productName = await fetchProductName(barcode);

        setState(() {
          scannedItems.insert(0, productName);
        });
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          scannedItems.insert(0, 'Camera permission not granted');
        });
      } else {
        setState(() {
          scannedItems.insert(0, 'Unknown error occurred');
        });
      }
    } catch (e) {
      setState(() {
        scannedItems.insert(0, 'Error occurred while scanning');
      });
    } finally {
      setState(() {
        isScanning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: scannedItems.length,
          itemBuilder: (context, index) {
            return Card(
              color: Color.fromARGB(255, 253, 214, 173),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text(
                  scannedItems[index],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: const Color.fromARGB(255, 25, 25, 25)),
                  onPressed: () {
                    setState(() {
                      scannedItems.removeAt(index);
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            left: 60,
            bottom: 30,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 253, 214, 173),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: 100,
                height: 57,
                child: DropdownButton<String>(
                  value: selectedPantry,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPantry = newValue!;
                    });
                  },
                  dropdownColor: Color.fromARGB(255, 253, 214, 173),
                  iconEnabledColor: Colors.white,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  items: pantries.map<DropdownMenuItem<String>>((Pantry pantry) {
                    return DropdownMenuItem<String>(
                      value: pantry.name,
                      child: Text(pantry.name),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            bottom: 30,
            child: FloatingActionButton.extended(
              onPressed: scanBarcode,
              icon: Icon(Icons.camera_alt),
              label: Text('Scan'),
              backgroundColor: Color.fromARGB(255, 253, 214, 173),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
