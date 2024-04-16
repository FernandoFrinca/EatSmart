import 'dart:async';
import 'dart:convert';
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
    floatingActionButton: FloatingActionButton.extended(
  onPressed: scanBarcode,
  icon: Icon(Icons.camera_alt),
  label: Text('Scan'),  
  backgroundColor: Color.fromARGB(255, 253, 214, 173),
  foregroundColor: Colors.white,
),
  );
}

}
