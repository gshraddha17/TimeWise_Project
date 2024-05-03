import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final Function(double) onRatingUpdate;
  final int starCount;

  const StarRating({
    Key? key,
    required this.rating,
    required this.onRatingUpdate,
    this.starCount = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) => _star(index)),
    );
  }

  Widget _star(int index) {
    final isStarred = index < rating;
    final color = isStarred ? Colors.amber : Colors.grey;
    return IconButton(
      icon: Icon(
        Icons.star,
        size: 24.0,
        color: color,
      ),
      onPressed: () => onRatingUpdate(index + 1.0),
    );
  }
}
