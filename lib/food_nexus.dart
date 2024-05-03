import 'package:flutter/material.dart';
import 'package:timewise/Upload_Report.dart';
import 'package:timewise/main_review.dart';
import 'package:timewise/purchase_page.dart';
import 'package:timewise/user_feedback.dart';
import './review.dart';
import 'analyze_search_recipe.dart';
import 'search_news.dart';
// import 'rating_summary.dart';

// void main() => runApp(MyApp());

class FoodNexusTab extends StatelessWidget {
  const FoodNexusTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              'assets/images/background_image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Content with buttons
            Center(
              child: MyHomePage(),
            ),
            // Message icon at bottom left corner
            Positioned(
              bottom: 20,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.message),
                color: Color(0xFF004AAD),
                iconSize: 40,
                onPressed: () {
                  // Navigate to ReviewPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserFeedBack()),
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // Navigate to Recipe Analyzer page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AnalyzeSearchRecipe()),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xFF004AAD),
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFF004AAD)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text('Recipe Analyzer'),
        ),
        const SizedBox(height: 20), // Adjust the gap as needed
        ElevatedButton(
          onPressed: () {
            // Navigate to Food News page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xFF004AAD),
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFF004AAD)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text('Food News'),
        ),
        const SizedBox(height: 20), // Adjust the gap as needed
        ElevatedButton(
          onPressed: () {
            // Navigate to Purchase Suggestions page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PurchasePage()),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color(0xFF004AAD),
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFF004AAD)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: const Text('Purchase Suggestions'),
        ),
        Container(
          
          height:200,
          child:UploadPdfPage(),
        )
        
      ],
    );
  }
}
