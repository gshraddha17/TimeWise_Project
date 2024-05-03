import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timewise/dashboard_page.dart';
import 'package:timewise/login_dialog.dart';
import 'package:timewise/product_page (1).dart'; // Corrected import path

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Set<String> vendors_ = {};
  final List<String> vendors = [];
  final List<Product> productsWithPrice = [];

  void printDataForEachIndex(String collectionName, String documentName) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentName)
          .get();
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      // List<Product> singleProductDetails = [];
      if (data != null) {
        for (int i = 0; i <= 10; i++) {
          if (data.containsKey('$i')) {
            // print('$i:');
            Map<String, dynamic> indexData = data['$i'] as Map<String, dynamic>;
            print(indexData);
            Product product = Product(
              imageUrl: indexData['image'],
              name: indexData['name'],
              cost: indexData['cost'].toDouble(),
            );
            // print()
            productsWithPrice.add(product);
            print(productsWithPrice);
          }
        }

        // productsWithPrice.add(singleProductDetails);
      } else {
        // productsWithPrice.add(singleProductDetails);
        // print(2323);
        print(
            'Document $documentName in collection $collectionName does not exist or is empty.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> getCollection() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection('Products');
      final querySnapshot = await collectionRef.get();

      for (final DocumentSnapshot doc in querySnapshot.docs) {
        vendors_.add(doc.id);
        // print(5555);
        print(doc.id);
        printDataForEachIndex('Products', doc.id);
      }
      if (vendors.isEmpty) {
        for (final singleVendor in vendors_) {
          vendors.add(singleVendor);
        }
      }
    } catch (error) {
      print("Error getting collection: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        FirebaseAuth.instance.currentUser; // Get the current user

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            // Background Image covering AppBar
            Image.asset(
              'assets/images/background_image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Customized AppBar (optional)
            AppBar(
              backgroundColor: Colors.transparent,
              // Make AppBar transparent
              elevation: 0,
              // Remove AppBar shadow
              leading: GestureDetector(
                onTap: currentUser != null
                    ? () async {
                        await getCollection();

                        print(vendors);
                        // Navigate to the product page when home icon is pressed
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashBoardPage(
                                vendors: vendors,
                                productsWithPrice: productsWithPrice),
                          ),
                        );
                      }
                    : null,
                child: const IconButton(
                  icon: Icon(Icons.home), // Home icon
                  onPressed: null,
                ),
              ),
              // You can customize the AppBar further if needed
              // For example, add title, actions, etc.
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image covering the rest of the screen
          Image.asset(
            'assets/images/background_image.png', // Corrected image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Content with Time Wise title
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/time_wise.png', // Corrected image path
                width: 400, // Adjust the width as needed
              ),
              const SizedBox(height: 10), // Reduce the gap here
              const Center(
                child: Text(
                  'Bringing Freshness to Groceries',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20), // Adjust the gap as needed
              ElevatedButton(
                onPressed: () {
                  showLoginSignUpDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004AAD),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Login or SignUp'),
              ),
              const SizedBox(height: 10), // Add some spacing
              ElevatedButton(
                onPressed: () async {
                  await _signOut(context); // Perform logout action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Change button color to red
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      // Sign out from Firebase Authentication
      await FirebaseAuth.instance.signOut();

      // Sign out from Google Sign-In
      await GoogleSignIn().signOut();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out successfully')),
      );

      // Optionally navigate to another page after sign out
      // Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
