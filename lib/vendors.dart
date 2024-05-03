import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(VendorsApp());
}

class VendorsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VendorHomePage(),
    );
  }
}

class VendorHomePage extends StatelessWidget {
  final String jsonString = '''
    {
      "vendors": [
        {
          "name": "GreenGrocer",
          "fruits": [
            {"name": "Apple", "price": 2.5},
            {"name": "Banana", "price": 1.8},
            {"name": "Orange", "price": 3.0},
            {"name": "Grapes", "price": 3.2},
            {"name": "Pineapple", "price": 2.7},
            {"name": "Watermelon", "price": 4.5}
          ],
          "vegetables": [
            {"name": "Carrot", "price": 1.2},
            {"name": "Broccoli", "price": 2.0},
            {"name": "Tomato", "price": 1.5},
            {"name": "Spinach", "price": 1.0},
            {"name": "Onion", "price": 1.3},
            {"name": "Bell Pepper", "price": 1.8}
          ],
          "spices": [
            {"name": "Cinnamon", "price": 0.5},
            {"name": "Turmeric", "price": 0.8},
            {"name": "Cumin", "price": 0.7},
            {"name": "Ginger", "price": 1.2},
            {"name": "Garlic", "price": 1.0},
            {"name": "Paprika", "price": 0.9}
          ],
          "sentiments": {"positive": 80, "neutral": 15, "negative": 5}
        },
        // Add other vendor data here...
      ]
    }
  ''';

  @override
  Widget build(BuildContext context) {
    final List<dynamic> vendors = json.decode(jsonString)['vendors'];
    vendors.sort((a, b) {
      final aSentiments = a['sentiments'];
      final bSentiments = b['sentiments'];
      final aPos = aSentiments['positive'];
      final bPos = bSentiments['positive'];
      final aNeut = aSentiments['neutral'];
      final bNeut = bSentiments['neutral'];
      final aNeg = aSentiments['negative'];
      final bNeg = bSentiments['negative'];
      if (aPos != bPos) {
        return bPos.compareTo(aPos); // Higher positive sentiment first
      } else if (aNeg != bNeg) {
        return aNeg.compareTo(bNeg); // Lower negative sentiment first
      } else {
        return bNeut.compareTo(aNeut); // Higher neutral sentiment first
      }
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            // Background Image covering AppBar
            Image.asset(
              'images/background_image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Customized AppBar
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  Icon(Icons.shopping_cart, color: Colors.green),
                  SizedBox(width: 10),
                  Text('Vendors List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image covering the rest of the screen
          Image.asset(
            'images/background_image.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Content with Vendors List
          ListView.builder(
            itemCount: vendors.length,
            itemBuilder: (context, index) {
              final vendor = vendors[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VendorDetailsPage(vendor: vendor)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xFF004AAD),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Color(0xFF004AAD)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        vendor['name'],
                        style: TextStyle(fontSize: 16.0, color: Color(0xFF004AAD)),
                      ),
                      SizedBox(width: 10), // Add spacing between vendor name and "Highly Rated" text
                      if (index == 0) // Render "Highly Rated" text only for the first vendor
                        Text(
                          'Highly Rated',
                          style: TextStyle(fontSize: 12.0, color: Colors.green),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class VendorDetailsPage extends StatelessWidget {
  final Map<String, dynamic> vendor;

  const VendorDetailsPage({Key? key, required this.vendor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vendor['name']),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Fruits'),
          ),
          for (var fruit in vendor['fruits'])
            ListTile(
              title: Text(fruit['name']),
              subtitle: Text('Price: \$${fruit['price']}'),
            ),
          ListTile(
            title: Text('Vegetables'),
          ),
          for (var vegetable in vendor['vegetables'])
            ListTile(
              title: Text(vegetable['name']),
              subtitle: Text('Price: \$${vegetable['price']}'),
            ),
          ListTile(
            title: Text('Spices'),
          ),
          for (var spice in vendor['spices'])
            ListTile(
              title: Text(spice['name']),
              subtitle: Text('Price: \$${spice['price']}'),
            ),
        ],
      ),
    );
  }
}
