// ignore_for_file: avoid_print, non_constant_identifier_names, library_private_types_in_public_api

import 'package:eatsmart/account_backend/global.dart';
import 'package:eatsmart/pantry_products_backend/pantry_data.dart';
import 'package:eatsmart/pantry_products_backend/type.dart';
import 'package:flutter/material.dart';

class PantryScreen extends StatefulWidget {
  const PantryScreen({super.key});
  @override
  _PantryScreenState createState() => _PantryScreenState();
}

class _PantryScreenState extends State<PantryScreen> {
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
    });
  }

  void _EditDialog(BuildContext context, PantryItem item) {
    TextEditingController nameController =
        TextEditingController(text: item.name);
    TextEditingController countController =
        TextEditingController(text: item.count.toString());
    String? selectedUnit = item.quantity;
    List<String> units = ['ml', 'g', 'l', 'kg', 'pieces'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Edit Item"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        hintText: "Enter product name",
                      ),
                    ),
                    TextField(
                      controller: countController,
                      decoration: const InputDecoration(
                        labelText: "Count",
                        hintText: "Enter quantity",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    DropdownButton<String>(
                      value: selectedUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUnit = newValue;
                        });
                      },
                      items:
                          units.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    loadPantries();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    updatePantryItem(item.id, nameController.text,
                        int.parse(countController.text), selectedUnit!);
                    loadPantries();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, PantryItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Item"),
          content: Text("Are you sure you want to delete '${item.name}'?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                loadPantries();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                deletePantryData(item.id);
                loadPantries();
                print("Deleted ${item.name}");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _DeletePantryDialog(BuildContext context, Pantry pantry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Pantry"),
          content: Text(
              "Are you sure you want to delete the pantry '${pantry.name}' and all its contents?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () async {
                await deletePantry(pantry.id);
                await loadPantries();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editPantryDialog(BuildContext context, Pantry pantry) {
    TextEditingController pantryNameController =
        TextEditingController(text: pantry.name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Pantry"),
          content: TextField(
            controller: pantryNameController,
            decoration: const InputDecoration(
              labelText: "Pantry Name",
              hintText: "Enter new pantry name",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
                loadPantries();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () {
                updatePantry(pantry.id, pantryNameController.text);
                loadPantries();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addPantryDialog(BuildContext context) {
    TextEditingController pantryNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("New Pantry"),
          content: TextField(
            controller: pantryNameController,
            decoration: const InputDecoration(
              labelText: "Create Pantry",
              hintText: "Pantry Name",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
                loadPantries();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () async {
                int userId = getID();
                await addPantry(pantryNameController.text, userId);
                await loadPantries();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addItemDialog(BuildContext context, int pantry_id) {
    TextEditingController nameController = TextEditingController();
    TextEditingController countController = TextEditingController();
    String? selectedUnit;
    List<String> units = ['ml', 'g', 'l', 'kg', 'pieces'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Add New Item"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        hintText: "Enter product name",
                      ),
                    ),
                    TextField(
                      controller: countController,
                      decoration: const InputDecoration(
                        labelText: "Count",
                        hintText: "Enter Count",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    DropdownButton<String>(
                      value: selectedUnit,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUnit = newValue;
                        });
                      },
                      items: units.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    addProduct(nameController.text, pantry_id, int.parse(countController.text), selectedUnit!);
                    loadPantries();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pantries'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: pantries
              .map((pantry) => ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                                '${pantry.name} (${pantry.items.length} items)')),
                        IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              _editPantryDialog(context, pantry);
                              loadPantries();
                            }),
                        IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _DeletePantryDialog(context, pantry);
                              loadPantries();
                            })
                      ],
                    ),
                    children: <Widget>[
                      ...pantry.items
                          .map((item) => ListTile(
                                title: Text(
                                    '${item.name} - ${item.count} - ${item.quantity}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.green),
                                        onPressed: () {
                                          _EditDialog(context, item);
                                          loadPantries();
                                        }),
                                    IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          _showDeleteConfirmation(
                                              context, item);
                                          loadPantries();
                                        })
                                  ],
                                ),
                              ))
                          .toList(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0), 
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {
                              _addItemDialog(context,pantry.id);
                              print("Pantry id: ${pantry.id}");
                            },
                            child: Text('Add Item'),
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  const Color.fromRGBO(165, 221, 155, 1.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              side: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white10,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _addPantryDialog(context);
              },
              child: Text('Add Pantry'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(165, 221, 155, 1.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                side: BorderSide.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
