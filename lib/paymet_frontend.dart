import 'package:flutter/material.dart';


class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Payment Methods'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // List of payment gateways
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  PaymentMethodTile(
                    icon: Icons.credit_card,
                    title: 'Credit Card',
                    color: Colors.grey,
                    onTap: () {
                      // Handle payment method selection
                      print('Selected Payment Method: Credit Card');
                    },
                  ),
                  PaymentMethodTile(
                    icon: Icons.paypal_rounded,
                    color: Colors.blueAccent,
                    title: 'PayPal',
                    onTap: () {
                      // Handle payment method selection
                      print('Selected Payment Method: PayPal');
                    },
                  ),
                  // PaymentMethodTile(
                  //   icon: Icons.google,
                  //   title: 'Google Pay',
                  //   onTap: () {
                  //     // Handle payment method selection
                  //     print('Selected Payment Method: Google Pay');
                  //   },
                  // ),
                  PaymentMethodTile(
                    icon: Icons.apple_sharp,
                    title: 'Apple Pay',
                    color: Colors.black,
                    onTap: () {
                      // Handle payment method selection
                      print('Selected Payment Method: Apple Pay');
                    },
                  ),
                  PaymentMethodTile(
                    icon: Icons.currency_bitcoin_sharp,
                    color: Colors.amber,
                    title: 'Bitcoin',
                    onTap: () {
                      // Handle payment method selection
                      print('Selected Payment Method: Bitcoin');
                    },
                  ),
                  PaymentMethodTile(
                    icon: Icons.currency_rupee_rounded,
                    title: 'Cash',
                    color: Colors.green,
                    onTap: () {
                      // Handle payment method selection
                      print('Selected Payment Method: Cash');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  final Color color;

  PaymentMethodTile({required this.icon, required this.title, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
        color: color,
      ),

      title: Text(title),
      onTap: () {
        onTap();
      },
    );
  }
}
