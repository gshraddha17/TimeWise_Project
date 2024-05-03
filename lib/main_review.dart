import 'package:flutter/material.dart';
import './star_rating.dart';
import './user_rating.dart';

class ReviewItem extends StatelessWidget {
  final String userName;
  final String rating;
  final String reviewText;
  final String reviewDate;

  const ReviewItem({
    Key? key,
    required this.userName,
    required this.rating,
    required this.reviewText,
    required this.reviewDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  rating,
                  style: const TextStyle(fontSize: 16.0),
                ),
                const Icon(Icons.star, color: Colors.amber),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(reviewText),
            const SizedBox(height: 8.0),
            Text(reviewDate, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  final List<ReviewItem> reviews;

  const ReviewList({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return ReviewItem(
          userName: reviews[index].userName,
          rating: reviews[index].rating,
          reviewText: reviews[index].reviewText,
          reviewDate: reviews[index].reviewDate,
        );
      },
    );
  }
}


class MainReviewPage extends StatefulWidget {
  MainReviewPage({Key? key}) : super(key: key);
  @override
  State<MainReviewPage> createState() => _MainReviewPageState();
}

class _MainReviewPageState extends State<MainReviewPage> {
  // Sample review data (replace with your data source)
  final _reviews = [
    ReviewItem(
      userName: "John Doe",
      rating: "4.5",
      reviewText: "Great app! Easy to use and very helpful.",
      reviewDate: "2024-04-27",
    ),

    // Add more reviews here
  ];
  void _addReview(Map<String, String> review) {
    setState(() {
      _reviews.add(ReviewItem(
        userName: review['userName']!,
        rating: review['rating']!,
        reviewText: review['reviewText']!,
        reviewDate: DateTime.now().toString(), // Set current date/time
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Reviews',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Reviews'),
        ),
        body: SingleChildScrollView(
          child: Container(
            
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                UserReviewForm(
                  onSubmit: _addReview,
                ),
                SizedBox(
                  height: 20,
                ),
                StarRating(
                    rating: 3.5,
                    onRatingUpdate: (newRating) {
                      print('!!');
                    }),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 180,
                  child: ReviewList(reviews: _reviews),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}