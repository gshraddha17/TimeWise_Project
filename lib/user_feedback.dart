import 'package:flutter/material.dart';
import './rating_summary.dart';
import './reviews.dart';

// void main() => runApp(MyApp());

class UserFeedBack extends StatelessWidget {
  const UserFeedBack({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Flutter Hello World',
      // Application theme data, you can set the colors for the application as
      // you want
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      // A widget which will be started on application startup
      home: ReviewPage(reviewTitle: 'Reviews'),
    );
  }
}

class ReviewPage extends StatelessWidget {
  final String reviewTitle;
  // Assuming you have review data
  ReviewPage({Key? key, required this.reviewTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reviews',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xffd5d5d5),
        toolbarHeight: 75,
        centerTitle: true, // Set the review title
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Handle back button press
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '4.0',
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the stars
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber, // Gold color for the first 3 stars
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.star,
                        color:
                            Colors.grey, // Grey color for the remaining stars
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'based on 16 ratings',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: RatingSummary(),
              height: 165,
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 2.0,
              color: Color(0xffc3c2c2),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: ReviewScreen(),
               height: 2000,
            ),
          ],
        ),
      ), // Replace with your content
    );
  }
}
