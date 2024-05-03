import 'package:flutter/material.dart';

class RatingSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.,
            children: [
              Text(
                'Excellent (8)',
                style: TextStyle(color: Color(0xff636262)),
              ),
              SizedBox(width: 10.0),
              Container(
                width: 120.0,
                height: 10.0,
                color: Colors.green,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Good (4)',
                style: TextStyle(color: Color(0xff636262)),
              ),
              SizedBox(width: 10.0),
              Container(
                width: 100.0,
                height: 10.0,
                color: Colors.lightGreen,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Average (2)',
                style: TextStyle(color: Color(0xff636262)),
              ),
              SizedBox(width: 10.0),
              Container(
                width: 70.0,
                height: 10.0,
                color: Colors.amber,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Below Average (2)',
                style: TextStyle(color: Color(0xff636262)),
              ),
              SizedBox(width: 10.0),
              Container(
                width: 40.0,
                height: 10.0,
                color: Colors.orange,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Poor (1)',
                style: TextStyle(color: Color(0xff636262)),
              ),
              SizedBox(width: 10.0),
              Container(
                width: 10.0,
                height: 10.0,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
