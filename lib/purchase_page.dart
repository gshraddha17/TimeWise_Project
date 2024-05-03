import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  late TextEditingController _textEditingController;
  List<String> suggestions = [];

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // Your JSON input

  Future<void> sendPostRequest(String inputText) async {
    print(inputText);
    inputText = '"' + inputText;
    inputText = inputText + '"';
    print(inputText);
    final String jsonInput = '{"link": $inputText}';
    print(jsonInput);
    try {
      var response = await http.post(
        Uri.parse(
            'https://katydid-equipped-equally.ngrok-free.app/ingredient_extraction'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonInput,
      );

      if (response.statusCode == 200) {
        // Request successful, handle response
        print('Response: ${response.body}');
        var jsonData = jsonDecode(response.body);
        List<dynamic> items = jsonData;
        List<String> suggestionsList = [];
        items.forEach((item) {
          suggestionsList.add(item.toString());
        });
        setState(() {
          suggestions = suggestionsList;
        });
        // Add your logic to handle the response, e.g., navigate to a success page
      } else {
        // Request failed with an error status code
        print('Request failed with status: ${response.statusCode}');
        // Add your logic to handle the error, e.g., show an error message
      }
    } catch (e) {
      // An error occurred during the request
      print('Error: $e');
      // Add your logic to handle the error, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Purchase Page',style: TextStyle(fontSize: 20),),
          ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Enter YouTube link',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  sendPostRequest(_textEditingController.text);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Color(0xFF004AAD),
                  backgroundColor: Colors.white, // Highlighted color
                  side: BorderSide(color: Color(0xFF004AAD)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                child: const Text("Purchase Suggestions"),
              ),
              SizedBox(height:20),
             Expanded(
  child: ListView.builder(
    itemCount: suggestions.length,
    itemBuilder: (context, index) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 10),
                    SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        suggestions[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PurchasePage(),
  ));
}
