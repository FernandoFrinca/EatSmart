import 'dart:convert';
import 'package:eatsmart/account_backend/global.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:http/http.dart' as http;

class GenerateMenuJuice extends StatefulWidget {
  @override
  _GenerateMenuState createState() => _GenerateMenuState();
}

class _GenerateMenuState extends State<GenerateMenuJuice> {
  final PostgreSQLConnection _conn = PostgreSQLConnection(
    '10.0.2.2', 5432, 'EatSmartDB',
    username: 'postgres', password: 'postgres',
  );

  String _chatGPTResponse = "";
  bool _buttonVisible = true;


  @override
  void initState() {
    super.initState();
  }

  Future<void> _sendProductsToChat(int userId) async {
    try {
      await _conn.open();
      print('Connected to Postgres database for retrieving products...');

      var objectiveResult = await _conn.query(
        'SELECT objective FROM users WHERE id = @user',
        substitutionValues: {'user': userId},
      );
      String objective = objectiveResult.isNotEmpty ? objectiveResult.first[0] as String : '';

      var pantryIds = await _conn.query(
        'SELECT id FROM pantries WHERE user_id = @user',
        substitutionValues: {'user': userId},
      ).then((result) => result.map((row) => row[0] as int).toList());

      List<Map<String, dynamic>> items = [];
      for (int pantryId in pantryIds) {
        var productResults = await _conn.query(
          'SELECT id, name, count, quantity, pantry_id FROM products WHERE pantry_id = @id_pantry',
          substitutionValues: {'id_pantry': pantryId},
        );

        items.addAll(productResults.map((row) => {
          'id': row[0],
          'name': row[1],
          'count': row[2],
          'quantity': row[3],
          'pantry_id': row[4],
        }));
      }

      var finalJson = jsonEncode({
        'objective': objective,
        'products': items,
      });

      print('JSON: $finalJson');
      _chatGPTResponse = await _sendToChatGPT(finalJson, 'OPENAI_API_KEY');
      _buttonVisible = false;
      setState(() {});
    } catch (e) {
      print('Error retrieving the products: $e');
      _buttonVisible = false;
      setState(() {
        _chatGPTResponse = "Error retrieving products: $e";
      });
    } finally {
      _buttonVisible = false;
      await _conn.close();
    }
  }

  Future<String> _sendToChatGPT(String jsonString, String apiKey) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo-0125',
        'messages': [
          {'role': 'system', 'content': 'Please create a juice/smoothie and provide the response in the following format: Recipe Name \n\n The ingredients: -\n\n Preparation methode:'},
          {'role': 'user', 'content': 'Here are the available products and the user objective:\n$jsonString'}
        ],
        'max_tokens': 350,
        'temperature': 0.7,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to get response from ChatGPT');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate juice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_buttonVisible)
                ElevatedButton(
                  onPressed: () => _sendProductsToChat(getID()),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Text(
                      'Generate Menu',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              SizedBox(height: 20),
              if (_chatGPTResponse.isNotEmpty)
                Expanded(
                  child: Card(
                    color: Color.fromARGB(173, 246, 246, 247),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Text(
                          _chatGPTResponse,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
