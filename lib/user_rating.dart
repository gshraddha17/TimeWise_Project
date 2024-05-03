import 'package:flutter/material.dart';

class UserReviewForm extends StatefulWidget {
  final Function(Map<String, String>) onSubmit;

  const UserReviewForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<UserReviewForm> createState() => _UserReviewFormState();
}

class _UserReviewFormState extends State<UserReviewForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _submitReview() {
    if (_formKey.currentState!.validate()) {
      final review = {
        'userName': _userNameController.text,
        'rating': _ratingController.text,
        'reviewText': _reviewTextController.text,
      };
      widget.onSubmit(review); // Call the provided onSubmit function
      _formKey.currentState!.reset(); // Clear form fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Review submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _ratingController = TextEditingController();
  final _reviewTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ratingController,
              decoration: const InputDecoration(
                labelText: 'Rating (e.g., 4.5)',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your rating';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _reviewTextController,
              decoration: const InputDecoration(
                labelText: 'Your Review',
              ),
              minLines: 3,
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your review';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final review = {
                    'userName': _userNameController.text,
                    'rating': _ratingController.text,
                    'reviewText': _reviewTextController.text,
                  };
                  widget
                      .onSubmit(review); // Call the provided onSubmit function
                  _formKey.currentState!.reset(); // Clear form fields
                }
              },
              child: const Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
