// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import './radio_button.dart';
import 'dart:convert';

import './show_dialog.dart';

class ProductDetailPage extends StatefulWidget {
  final String name;

  const ProductDetailPage({Key? key, required this.name}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => ProductDetailPage_();
}

class ProductDetailPage_ extends State<ProductDetailPage> {
  int weight = 1;
  Map<String, dynamic> user_report = {};
  Map<String, dynamic> fruit_detail = {};
  Map<String, List<String>> logs = {'safe': [], 'warnings:': [], 'risk': []};
  var _selectedValue = '';
  var tot = 0.0;
  String _total = '1400';
  void incrementWeight() {
    setState(() {
      weight++;
    });
  }

  void decrementWeight() {
    setState(() {
      if (weight > 1) {
        weight--;
      }
    });
  }

  Future<void> compareHealthReport() async {
    try {
      // Read the JSON file
      String file = await rootBundle.loadString('assets/pdfs/alerts_data.json');
      final data = json.decode(file) as Map<String, dynamic>;

      // Parse the JSON string

      List<dynamic> ageGroups = data['age_groups'];
      // print(ageGroups);
      // Find the age group "20-40 years" and access its data
      for (var ageGroup in ageGroups) {
        if (ageGroup['group'] == "20-40 years") {
          var nutrientLevels = ageGroup['nutrient_levels'];

          predictNutrientLevel(nutrientLevels);
          // Once found, exit the loop as we found the desired age group
          break;
        }
      }
    } catch (err) {
      print(err);
    }
  }

  Future<void> searchRecipes(String ingredient) async {
    const appId = '7a5e247f';
    const appKey = '5f975a401e8bf265bc2f3b66bae95b36';
    const endpoint = 'https://api.edamam.com/api/nutrition-details';

    print("fetching data");
    try {
      final response = await http.post(
        Uri.parse('$endpoint?app_id=$appId&app_key=$appKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'ingr': [ingredient]
        }),
      );
      print("data fetched");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['totalNutrients'] != null) {
          final totalNutrients = data['totalNutrients'];
          fruit_detail = totalNutrients;
          print("Nutrition details found: $totalNutrients");
        } else {
          print('No nutrition details found');
        }
      } else {
        print('Failed to fetch nutrition details: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred during request: $e');
    }
  }

  Future<void> getCollectionData() async {
    // Access the Firestore collection
    try {
      // Access the Firestore document with the specified ID
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('user_health_report')
          .doc('aahRG2PkQalgXQWucsWb')
          .get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Access all fields and values of the document
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Print all fields and values
        data.forEach((key, value) {
          user_report[key] = value;
        });
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void predictNutrientLevel(Map<String, dynamic> jsonData) {
    try {
      // Access the nutrient levels for protein and carbohydrate

      var proteinLevels = jsonData['protein_g_per_kg'];
      var carbohydrateLevels = jsonData['carbohydrate_%_of_calories'];
      var saturatedFatLevels = jsonData['saturated_fat_%_of_calories'];
      var unsaturatedFatLevels = jsonData['unsaturated_fat_%_of_calories'];
      // var potassiumLevels = jsonData['potassium_%_of_calories'];

      double unsaturatedFatValue_ =
          fruit_detail['FAMS']['quantity'] + fruit_detail['FAPU']['quantity'];
      double proteinValue_ = fruit_detail['PROCNT']['quantity'];
      double carbohydrateValue_ = fruit_detail['CHOCDF']['quantity'];
      double saturatedFatValue_ = fruit_detail['FASAT']['quantity'];
      // Perform prediction for protein
      double proteinValue = 0;
      if (user_report.containsKey('protein') &&
          user_report['protein'] != null) {
        // Parsing the value to an integer
        // print(user_report['protein']);
        // print(proteinValue_);
        proteinValue = double.parse(user_report['protein']) + proteinValue_;
      }
      print('123456');
      double carbohydrateValue = 0;
      if (user_report.containsKey('carbohydrates') &&
          user_report['carbohydrates'] != null) {
        // Parsing the value to an integer
        carbohydrateValue =
            double.parse(user_report['carbohydrates']) + carbohydrateValue_;
      }

      // int potassiumValue = 0;
      // if (user_report.containsKey('potassium') &&
      //     user_report['potassium'] != null) {
      //   // Parsing the value to an integer
      //   potassiumValue = user_report['potassium']!.toDouble();
      // }

      double unsaturatedFatValue = 0;
      if (user_report.containsKey('unsaturated_fat') &&
          user_report['unsaturated_fat'] != null) {
        // Parsing the value to an integer
        unsaturatedFatValue =
            user_report['unsaturated_fat'] + unsaturatedFatValue_;
      }

      double saturatedFatValue = 0;
      if (user_report.containsKey('saturated_fat') &&
          user_report['saturated_fat'] != null) {
        // Parsing the value to an integer
        saturatedFatValue = user_report['saturated_fat'] + saturatedFatValue_;
      }

// Example value for protein (replace with actual value)
      var proteinSafeLevel = NutrientLevels(
          proteinLevels['safe_level']['min'].toDouble(),
          proteinLevels['safe_level']['max'].toDouble());
      print(56789);
      var proteinMediumRiskLevel = NutrientLevels(
          proteinLevels['medium_risk_level']['min'].toDouble(),
          proteinLevels['medium_risk_level']['max'].toDouble());
      var proteinHighRiskLevel = NutrientLevels(
          proteinLevels['high_risk_level']['min'].toDouble(),
          proteinLevels['high_risk_level']['max'].toDouble());

      if (proteinSafeLevel.isSafe(proteinValue.ceilToDouble())) {
        logs['safe']?.add('Protein level is safe');
      } else if (proteinMediumRiskLevel
          .isMediumRisk(proteinValue.ceilToDouble())) {
        logs['warnings']?.add('Protein level is at medium risk');
      } else if (proteinHighRiskLevel.isHighRisk(proteinValue.ceilToDouble())) {
        logs['risk']?.add('Protein level is at high risk');
      } else {
        print('Unknown protein level');
      }

      var carbohydrateSafeLevel = NutrientLevels(
          carbohydrateLevels['safe_level']['min'].toDouble(),
          carbohydrateLevels['safe_level']['max'].toDouble());
      var carbohydrateMediumRiskLevel = NutrientLevels(
          carbohydrateLevels['medium_risk_level']['min'].toDouble(),
          carbohydrateLevels['medium_risk_level']['max'].toDouble());
      var carbohydrateHighRiskLevel = NutrientLevels(
          carbohydrateLevels['high_risk_level']['min'].toDouble(),
          carbohydrateLevels['high_risk_level']['max'].toDouble());

      if (carbohydrateSafeLevel.isSafe(carbohydrateValue.ceilToDouble())) {
        logs['safe']?.add('Carbohydrate level is safe');
      } else if (carbohydrateMediumRiskLevel
          .isMediumRisk(carbohydrateValue.ceilToDouble())) {
        logs['warnings']?.add('Carbohydrate level is at medium risk');
      } else if (carbohydrateHighRiskLevel
          .isHighRisk(carbohydrateValue.ceilToDouble())) {
        logs['risk']?.add('Carbohydrate level is at high risk');
      } else {
        print('Unknown carbohydrate level');
      }

      var unsaturatedFatSafeLevel = NutrientLevels(
          unsaturatedFatLevels['safe_level']['min'].toDouble(),
          unsaturatedFatLevels['safe_level']['max'].toDouble());

      var unsaturatedFatMediumRiskLevel = NutrientLevels(
          unsaturatedFatLevels['medium_risk_level']['min'].toDouble(),
          unsaturatedFatLevels['medium_risk_level']['max'].toDouble());
      var unsaturatedFatHighRiskLevel = NutrientLevels(
          unsaturatedFatLevels['high_risk_level']['min'].toDouble(),
          unsaturatedFatLevels['high_risk_level']['max'].toDouble());

      if (unsaturatedFatSafeLevel.isSafe(unsaturatedFatValue.ceilToDouble())) {
        logs['safe']?.add('Unsaturated fat level is safe');
      } else if (unsaturatedFatMediumRiskLevel
          .isMediumRisk(unsaturatedFatValue.ceilToDouble())) {
        logs['warnings']?.add('Unsaturated fat level is at medium risk');
      } else if (unsaturatedFatHighRiskLevel
          .isHighRisk(unsaturatedFatValue.ceilToDouble())) {
        logs['risk']?.add('Unsaturated fat level is at high risk');
      } else {
        print('Unknown unsaturated fat level');
      }

      var saturatedFatSafeLevel = NutrientLevels(
          saturatedFatLevels['safe_level']['min'].toDouble(),
          saturatedFatLevels['safe_level']['max'].toDouble());
      var saturatedFatMediumRiskLevel = NutrientLevels(
          saturatedFatLevels['medium_risk_level']['min'].toDouble(),
          saturatedFatLevels['medium_risk_level']['max'].toDouble());
      var saturatedFatHighRiskLevel = NutrientLevels(
          saturatedFatLevels['high_risk_level']['min'].toDouble(),
          saturatedFatLevels['high_risk_level']['max'].toDouble());

      if (saturatedFatSafeLevel.isSafe(saturatedFatValue.ceilToDouble())) {
        logs['safe']?.add('Saturated fat level is safe');
      } else if (saturatedFatMediumRiskLevel
          .isMediumRisk(saturatedFatValue.ceilToDouble())) {
        logs['warnings']?.add('Saturated fat level is at medium risk');
      } else if (saturatedFatHighRiskLevel
          .isHighRisk(saturatedFatValue.ceilToDouble())) {
        logs['risk']?.add('Saturated fat level is at high risk');
      } else {
        print('Unknown saturated fat level');
      }
    } catch (e) {
      print('Error predicting nutrient level: $e');
    }
  }

  Future<void> addToFirestore(BuildContext context) async {
    // Get a reference to the Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add data to Firestore
    await firestore.collection('cart_items').add({
      'name': 'Apple',
      'quantity': weight,
      'total':
          calculateTotal(), // assuming you have a method for calculating total
      'image': 'URL to your image', // replace with the actual URL
    });
    String searchItem = '${weight}Apple';
    await searchRecipes(searchItem);
    await getCollectionData();
    // print(user_report);

    await compareHealthReport();
    await showMyCustomDialog(
        context,
        'https://tse4.mm.bing.net/th?id=OIP.4IIP_Yee7VJltRDBwvufGwAAAA&pid=Api&P=0&h=180',
        logs);
    print(logs);
  }

  // processSelectedFile(value){
  //   _selectedValue=value;
  //   if (_selectedValue == 0) {
  //     setState(() {
  //       _total = '1301'; // Update total for Option 1
  //     });
  //   }
  //   else if (_selectedValue == 1) {
  //     setState(() {
  //       _total = 'Rs 1332.5'; // Update total for Option 2
  //     });
  //   }
  //   else if (_selectedValue == 2) {
  //     setState(() {
  //       _total = 'Rs 1373'; // Update total for Option 3
  //     });
  //   }
  // }

  double calculateTotal() {
    // Implement your logic to calculate total based on quantity
    // For example:
    return weight * 10; // Assuming each unit costs $10
  }

  String name = '';
  String imageUrl = '';
  double cost = 0;
  String desc = '';

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Cart')
          .doc('cart_items')
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
        name = data['name'] ?? '';
        imageUrl = data['imageUrl'] ?? '';
        cost = data['cost'] ?? 0;
        print(name);
        print(imageUrl);
        print(cost);
        //fetchUserData2();
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchUserData();
    //fetchUserData2();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 4.0,
                bottom: 8.0,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    // Wrap the Column with Expanded
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('1 kg'),
                        Text(
                          cost.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 8,
                bottom: 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Quantity',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                        ),
                        child: GestureDetector(
                          onTap: decrementWeight,
                          child: Container(
                            color: const Color.fromRGBO(211, 211, 211, 1),
                            child: const Icon(
                              Icons.remove,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        weight.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Text(' kg'),
                      const SizedBox(
                        width: 14,
                      ),
                      IconButton(
                        onPressed: incrementWeight,
                        icon: Container(
                          color: const Color.fromRGBO(0, 74, 173, 1),
                          child: const Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Text(
                        (weight * cost).toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 8,
                bottom: 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Text(
                  //   'Product Description',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(
                    height: 1,
                  ),
                  // Text(
                  //   'desc',
                  //   // Add overflow handling for long descriptions
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 3, // Limit to 3 lines
                  // ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 8,
                bottom: 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Product Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Price ($weight kg)'),
                      Text(
                        (weight * cost).toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Charges'),
                      Text('Rs 50'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      RadioListTile<String>(
                        dense: true,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        title: Text(
                          '< 3 days shelf life : 10%',
                          style: TextStyle(fontSize: 16),
                        ),
                        contentPadding: EdgeInsets.zero,
                        value: 'Option 1',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                            _total = '1301';

                            print('Selected value: $_selectedValue');
                          });
                        },
                      ),
                      RadioListTile<String>(
                        dense: true,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        title: Text(
                          '3 - 5 days shelf life : 5%',
                          style: TextStyle(fontSize: 16),
                        ),
                        contentPadding: EdgeInsets.zero,
                        value: 'Option 2',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                            _total = '1332.5';
                            tot = weight * cost;
                            tot += 50;
                            print('Selected value: $_selectedValue');
                            print(_selectedValue);

                            if (_selectedValue == "Option 3") {
                              var disc = 2 * tot / 100;
                              tot -= disc;
                            }
                            if (_selectedValue == "Option 2") {
                              var disc = 5 * tot / 100;
                              tot -= disc;
                            }
                            if (_selectedValue == "Option 1") {
                              var disc = 10 * tot / 100;
                              tot -= disc;
                            }
                          });
                        },
                      ),
                      RadioListTile<String>(
                        dense: true,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity,
                        ),
                        title: Text(
                          '> 7  days shelf life : 2%',
                          style: TextStyle(fontSize: 16),
                        ),
                        contentPadding: EdgeInsets.zero,
                        value: 'Option 3',
                        groupValue: _selectedValue,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value!;
                            _total = '1373';

                            print('Selected value: $_selectedValue');
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 4,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rs ' + tot.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 4,
                bottom: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 2,
                bottom: 4,
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  side: const BorderSide(
                    width: 2,
                    color: Color.fromRGBO(0, 74, 173, 1),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                onPressed: () async {
                  await addToFirestore(
                      context); // Call the asynchronous function
                  print('Button pressed and function completed!');
                },
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 74, 173, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NutrientLevels {
  final double min;
  final double max;

  NutrientLevels(this.min, this.max);

  // Method to check if a given value falls within the safe level
  bool isSafe(double value) {
    return value >= min && value <= max;
  }

  // Method to check if a given value falls within the medium risk level
  bool isMediumRisk(double value) {
    return value >= min && value <= max;
  }

  // Method to check if a given value falls within the high risk level
  bool isHighRisk(double value) {
    return value >= min;
  }
}
// Define a function to predict the nutrient level based on the provided JSON data