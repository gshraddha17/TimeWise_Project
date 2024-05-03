import 'package:flutter/material.dart';
import 'package:timewise/checkout_page.dart';

// Function to show the custom dialog
Future<void> showMyCustomDialog(BuildContext context, String imagePath, Map<String,List<String>> bulletPoints) async {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap the button to close the dialog
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Image.network(
                  imagePath,
                  height: 125.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10.0),
              ...bulletPoints.entries.expand((entry) => entry.value.map((item) => _buildBulletPoint(context,"${entry.key}" , "$item"))).toList(),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close'),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckoutPage()),
    );
                  },
                 icon: Icon(Icons.arrow_forward)),
                ),
              // ),

         
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildBulletPoint(BuildContext context,String level, String point) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _buildIconBasedOnLevel(level,context),
      SizedBox(width: 5.0),
      Expanded(child: Text(point, style: TextStyle(fontSize: 14.0))),
    ],
  );
}

Widget _buildIconBasedOnLevel(String level, BuildContext context) {
  IconData iconData;
  Color color;

  switch (level) {
    case 'risk':
      iconData = Icons.close; // Red cross
      color = Colors.red;
      break;
    case 'warnings':
      iconData = Icons.warning; // Yellow warning
      color = Colors.yellow[700]!;
      break;
    case 'safe':
      iconData = Icons.check; // Green tick
      color = Colors.green;
      break;
    default:
      iconData = Icons.help; // Default icon if none of the cases match
      color = Colors.grey;
  }

  return Icon(iconData, size: 12.0, color: color);
}
