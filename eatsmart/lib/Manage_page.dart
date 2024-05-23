import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: BarcodeManagerPage()));

class BarcodeManagerPage extends StatefulWidget {
  @override
  _BarcodeManagerPageState createState() => _BarcodeManagerPageState();
}

class _BarcodeManagerPageState extends State<BarcodeManagerPage> {
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    items = await fetchAllItems();
    setState(() {});
  }
  
  Future<List<String>> fetchAllItems() async {
  try {
    if (response.statusCode == 200) {
      final List<dynamic> itemList = json.decode(response.body);
      return itemList.map((item) => item.toString()).toList();
    } else {
      throw Exception('Failed to load items');
    }
  } catch (e) {
    print('Caught error: $e');
    return []; 
  }
}

  void addItem(String item) {
    setState(() {
      items.insert(0, item);
    });
  }

  void deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void editItem(int index, String newItem) {
    setState(() {
      items[index] = newItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Scanned Items'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final String newItem = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewItemPage()),
              );
              if (newItem != null) addItem(newItem);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(items[index]),
            onDismissed: (_) => deleteItem(index),
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(items[index]),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  final String editedItem = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditItemPage(currentItem: items[index]),
                    ),
                  );
                  if (editedItem != null) editItem(index, editedItem);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddNewItemPage extends StatefulWidget {
  @override
  _AddNewItemPageState createState() => _AddNewItemPageState();
}

class _AddNewItemPageState extends State<AddNewItemPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: Text('Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditItemPage extends StatefulWidget {
  final String currentItem;

  EditItemPage({required this.currentItem});

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _controller.text);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
