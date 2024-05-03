import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnalyzeSearchRecipe extends StatefulWidget {
  const AnalyzeSearchRecipe({Key? key}) : super(key: key);

  @override
  _AnalyzeSearchRecipeState createState() => _AnalyzeSearchRecipeState();
}

class _AnalyzeSearchRecipeState extends State<AnalyzeSearchRecipe> {
  final TextEditingController _ingredientController = TextEditingController();
  Map<String, dynamic>? nutritionFacts;
  List<Map<String, dynamic>>? recipeDetails;
  bool isLoading = false;

  Future<void> _searchNutritionFacts(String ingredient) async {
    // API request for nutrition facts
    const appId = '7a5e247f';
    const appKey = '5f975a401e8bf265bc2f3b66bae95b36';
    const endpoint = 'https://api.edamam.com/api/nutrition-details';

    print("fetching nutrition data");
    try {
      setState(() {
        isLoading = true;
        nutritionFacts = null; // Clear previous nutrition facts data
      });
      final response = await http.post(
        Uri.parse('$endpoint?app_id=$appId&app_key=$appKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'ingr': [ingredient]}),
      );
      print("nutrition data fetched");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['totalNutrients'] != null) {
          final totalNutrients = data['totalNutrients'];
          setState(() {
            nutritionFacts = totalNutrients;
          });
        } else {
          print('No nutrition details found');
        }
      } else {
        print('Failed to fetch nutrition details: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred during request: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    // ...
  }

  Future<List<Map<String, dynamic>>> _searchRecipeDetails(String ingredient) async {
    // API request for recipe details
    const appId = 'cae7ef71';
    const appKey = '6edb4799111bd6b8fecd95656da61d91';
    const endpoint = 'https://api.edamam.com/search';

    print("fetching recipe data");
    try {
      setState(() {
        isLoading = true;
        recipeDetails = null; // Clear previous recipe details data
        nutritionFacts = null; // Clear previous nutrition facts data
      });
      final response = await http.get(
        Uri.parse('$endpoint?q=$ingredient&app_id=$appId&app_key=$appKey'),
      );
      print("recipe data fetched");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['hits'] != null && data['hits'].isNotEmpty) {
          final hits = data['hits'];
          final List<Map<String, dynamic>> recipes = [];
          for (var hit in hits) {
            final recipe = hit['recipe'];
            recipes.add({
              'label': recipe['label'],
              'image': recipe['image'],
              'url': recipe['url'],
              'ingredients': recipe['ingredientLines'],
            });
          }
          setState(() {
            recipeDetails = recipes;
          });
          return recipes;
        } else {
          print('No recipe details found');
        }
      } else {
        print('Failed to fetch recipes');
      }
    } catch (e) {
      print('error occurred: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    return [];
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
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
              backgroundColor: Colors.transparent, // Make AppBar transparent
              elevation: 0, // Remove AppBar shadow
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the previous screen
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Background Image covering the rest of the screen
          Image.asset(
              'assets/images/background_image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          // Content
          Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextField(
                    controller: _ingredientController,
                    decoration: InputDecoration(
                      labelText: 'Enter your ingredient',
                      filled: true, // Fill the text field with background color
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _searchNutritionFacts(_ingredientController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFF004AAD),
                          backgroundColor: Colors.white, // Highlighted color
                          side: BorderSide(color: Color(0xFF004AAD)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                        child: Column(
                          children: [
                            const Text("Analyze nutrition", style: TextStyle(fontWeight: FontWeight.bold)), // Bold text
                            const Text("facts", style: TextStyle(fontWeight: FontWeight.bold)), // Bold text
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Adjust the spacing between buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _searchRecipeDetails(_ingredientController.text);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFF004AAD),
                          backgroundColor: Colors.white, // Highlighted color
                          side: BorderSide(color: Color(0xFF004AAD)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                        child: Column(
                          children: [
                            const Text("Search for recipe", style: TextStyle(fontWeight: FontWeight.bold)), // Bold text
                            const Text("details", style: TextStyle(fontWeight: FontWeight.bold)), // Bold text
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                if (isLoading)
                  CircularProgressIndicator()
                else if (nutritionFacts != null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Nutrition Facts'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: nutritionFacts!.entries.map((entry) {
                                return Text('${entry.key}: ${entry.value['label']} - ${entry.value['quantity']} ${entry.value['unit']}');
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (recipeDetails != null)
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var recipe in recipeDetails!)
                            Card(
                              margin: EdgeInsets.all(10.0),
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text('Recipe Details', style: TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Label:', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                                        Text(recipe['label'], style: TextStyle(color: Colors.black, fontSize: 16.0)),
                                        SizedBox(height: 10.0),
                                        Text('Ingredients:', style: TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold)),
                                        SizedBox(height: 5.0),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: recipe['ingredients'].map<Widget>((ingredient) => Text('- $ingredient', style: TextStyle(color: Colors.black, fontSize: 14.0))).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Display image here
                                  // Assuming the image URL is available in recipe details
                                  recipe['image'] != null
                                      ? Image.network(recipe['image'])
                                      : SizedBox(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
