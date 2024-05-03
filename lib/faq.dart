import 'package:flutter/material.dart';

class FAQ_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FAQ Section',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffeae9e9),
          elevation: 5,
          toolbarHeight: 70,
          title: Text(
            'FAQ Section',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: Row(children: [
            const SizedBox(
              width: 8,
            ),
            InkWell(
              child: Container(
                  // height: 60,
                  // padding: const EdgeInsets.all(4.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1,
                        ),
                      ]),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.black,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(
                          context); // Navigate back to the previous page
                    },
                  )),
            ),
          ]),
        ),
        body: FAQPage(),
      ),
    );
  }
}

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I place an order?',
      'answer':
          'To place an order, simply download our app, browse through our wide selection of products, add items to your cart, proceed to checkout, and choose your preferred payment and delivery options. Its that easy!'
    },
    {
      'question': 'Are there any restrictions on the items I can order?',
      'answer':
          'While we strive to offer a wide variety of products, there may be certain restrictions on items due to availability or local regulations. You can check product availability in your area through our app.'
    },
    {
      'question': 'Do you offer discounts or promotions?',
      'answer':
          'Yes, we frequently offer discounts, promotions, and special offers to our customers. You can stay updated on our latest deals by subscribing to our newsletter or following us on social media.'
    },
    {
      'question': 'Is my personal information secure?',
      'answer':
          'Yes, we take the security and privacy of your personal information very seriously. We use industry-standard encryption and security measures to protect your data. Your information will never be shared with third parties without your consent.'
    },
    {
      'question': 'How do you handle perishable items during delivery?',
      'answer':
          'Perishable items are carefully packaged and transported in temperature-controlled vehicles to ensure their freshness and quality upon delivery. Our delivery team follows strict guidelines to maintain the integrity of perishable products during transit.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          title: Text(
            faqs[index]['question']!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: <Widget>[
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                faqs[index]['answer']!,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 10,),
          ],
        );
      },
    );
  }
}
