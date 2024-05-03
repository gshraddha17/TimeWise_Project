import 'package:flutter/material.dart';
import 'package:timewise/dashboard_page.dart';
import 'package:timewise/final_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String _address = '123 Main St';
  String _city = 'New York';
  String _zipCode = '10001';

  void _changeAddress() async {
    final TextEditingController addressController = TextEditingController(text: _address);
    final TextEditingController cityController = TextEditingController(text: _city);
    final TextEditingController zipCodeController = TextEditingController(text: _zipCode);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: zipCodeController,
                decoration: InputDecoration(labelText: 'ZIP Code'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _address = addressController.text;
                  _city = cityController.text;
                  _zipCode = zipCodeController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _pay() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  'https://th.bing.com/th/id/OIP.uhyI_9cp2KXSsVqVGCUEpAAAAA?w=188&h=188&c=7&r=0&o=5&dpr=1.5&pid=1.7',
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 10,),
                Text(
                  'Thank You for Shopping!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                   Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FinalPage()),
    );
                  },
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),

            ),
            SizedBox(height: 20,),
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 10),
                    Text('Address: $_address'),
                    Text('City: $_city'),
                    Text('ZIP Code: $_zipCode'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _changeAddress,
                      child: Text('Change Address'),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _pay,
                        child: Text('Pay Now'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    )
                  ],

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
