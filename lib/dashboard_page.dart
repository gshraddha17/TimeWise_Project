import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:timewise/product_detail_page.dart';
import 'package:timewise/product_page%20(1).dart';
import '../faq.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import './firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import './User_profile.dart';

class Product {
  String imageUrl;
  String name;
  double cost;

  Product({
    required this.imageUrl,
    required this.name,
    required this.cost,
  });
}

class DashBoardPage extends StatefulWidget {
  final List<String> vendors;
  List<Product> productsWithPrice;

  DashBoardPage({
    Key? key,
    required this.vendors,
    required this.productsWithPrice,
  }) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  String dropdownValue = 'Fresh Produce';
  final Set<String> test = {};
  List<Product> displayAccordingToVendor = [];

  void _openBottomSheet(BuildContext context, String name) {
    print(name);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.88,
        maxChildSize: 1,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: const ProductDetailPage(name: "Orange"),
        ),
      ),
    );
  }

  Future<void> printDataForEachIndex(
      String collectionName, String documentName) async {
    // displayAccordingToVendor = [];
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentName)
          .get();
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        for (int i = 0; i <= 10; i++) {
          if (data.containsKey('$i')) {
            Map<String, dynamic> indexData = data['$i'] as Map<String, dynamic>;

            Product product = Product(
              imageUrl: indexData['image'],
              name: indexData['name'],
              cost: indexData['cost'].toDouble(),
            );
            print(product.name);
            displayAccordingToVendor.add(product);
          }
        }
      } else {
        print(
            'Document $documentName in collection $collectionName does not exist or is empty.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 180,
          child: Image.network(
              'https://i.postimg.cc/m2gLyvZQ/a-removebg-preview-1-1.png'),
        ),
        backgroundColor: Color(0xffeae9e9),
        elevation: 5,
        toolbarHeight: 70,
        actions: <Widget>[
          IconButton(
              iconSize: 30,
              icon: Icon(Icons.question_answer, color: Color(0xff004aad)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FAQ_Page()),
                );
              }),
          IconButton(
            iconSize: 30,
            icon: Icon(Icons.person, color: Color(0xff004aad)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                items: [
                  // List of carousel items
                  Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzroNzTnte7IkX37lRsmnZ0a1Or8QzwdXLBXpaP-ql3BACbsPIEylG_7SGTDwFM_U3-Io&usqp=CAU'),
                  Image.network(
                    'https://img.etimg.com/photo/msid-97712139/FSSAI%20TO%20ENFORCE%20HEALTH%20RATING%20ECOMMERCE.jpg',
                    width: 280,
                  ),
                  Image.network(
                      'https://www.nepaloffers.com/public/blog/926B2A076244066-offer.jpg'),
                  Image.network(
                      'https://img.freepik.com/free-vector/people-choosing-products-grocery-store-trolley-vegetables-basket-flat-vector-illustration-shopping-supermarket-concept_74855-10122.jpg?size=626&ext=jpg&ga=GA1.1.1224184972.1714348800&semt=ais'),
                  // Image.network(''),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                ),
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: DropdownButton<String>(
                  isExpanded: true,
                  // value: dropdownValue,
                  hint: Text('Select a Vendor'),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      // print(dropdownValue);

                      printDataForEachIndex('Products', dropdownValue);
                      // print(1122334455);
                      print(displayAccordingToVendor);
                      widget.productsWithPrice = displayAccordingToVendor;
                    });
                  },
                  items: widget.vendors
                      .map<DropdownMenuItem<String>>((String value) {
                    // print('Value: $value');
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),

            SizedBox(height: 20),
            // Shopping items grid
            Padding(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.productsWithPrice.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  if (index == widget.productsWithPrice.length - 1) return null;

                  return GestureDetector(
                    onTap: () {
                      // Navigate to another page
                      String name = widget.productsWithPrice[index].name;
                      String imageUrl =
                          widget.productsWithPrice[index].imageUrl;
                      double cost = widget.productsWithPrice[index].cost;

                      FirebaseFirestore.instance
                          .collection('Cart')
                          .doc('cart_items')
                          .set({
                        'name': name,
                        'imageUrl': imageUrl,
                        'cost': cost,
                      }).then((_) {
                        print('Product added to cart successfully');
                      }).catchError((error) {
                        print('Failed to add product to cart: $error');
                      });

                      _openBottomSheet(context, name);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProductPage(),
                      //   ),
                      // );
                    },
                    child: GridTile(
                      child: Container(
                        color: Colors.grey[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.productsWithPrice[index].name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Rs ${widget.productsWithPrice[index].cost}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(height: 5),
                            Image.network(
                              widget.productsWithPrice[index].imageUrl,
                              height: 100,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
