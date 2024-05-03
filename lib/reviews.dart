import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  final List<Review> reviews = [
    Review(name: 'John Doe', rating: 4.5, comment: 'Great product!'),
    Review(
        name: 'Jane Smith', rating: 3.0, comment: 'Good, but could be better.'),
  ]; // Existing reviews list

  ReviewScreen({Key? key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double rating_ = 0.0;
  String comment_ = '';

  void submitReview() async {
  try {
    // Fetch the user data from Firestore
    DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
        .collection('buyers')
        .doc('users')
        .get();

    // Check if the user data exists
    if (userDataSnapshot.exists) {
      // Get the name from the user data
      String? userName = userDataSnapshot['first'];

      // Add the review using the fetched name
      setState(() {
        widget.reviews.add(Review(name: userName ?? 'Your Name', rating: rating_, comment: comment_));
        rating_ = 0.0; // Reset rating after submission
        comment_ = ''; // Reset comment after submission
      });
    }
  } catch (e) {
    // Handle any errors that occur during fetching the user data
    print('Error fetching user data: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Write a review section
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Write a Review',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      for (int i = 1; i <= 5; i++)
                        IconButton(
                          icon: Icon(
                            Icons.star,
                            color: rating_ >= i ? Colors.amber : Colors.grey,
                          ),
                          iconSize: 20.0,
                          onPressed: () =>
                              setState(() => rating_ = i.toDouble()),
                        ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your comment',
                    ),
                    onChanged: (value) => setState(() => comment_ = value),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: comment_.isEmpty
                        ? null
                        : submitReview, // Disable if comment is empty
                    child: Text('Submit Review'),
                  ),
                ],
              ),
            ),
            // Existing review list (replace with your implementation)
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.reviews.length,
              itemBuilder: (context, index) {
                return _buildReviewCard(widget.reviews[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    final now = DateTime.now();
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center the stars
                  children: List.generate(
                    review.rating
                        .floor(), // Get the whole number part of the rating
                    (index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ),
                Text(' '),
                Text(
                  review.rating.toString(),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(review.comment),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String name;
  final double rating;
  final String comment;

  Review({required this.name, required this.rating, required this.comment});
}
