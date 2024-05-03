import 'package:flutter/material.dart';
import './PromoCode.dart';
import './address_checkout.dart';
import './paymet_frontend.dart';


class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}); // Corrected super.key to Key? key

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(// Adjust the cross axis alignment as needed
          children: [
            Container(
              height: 200,
              child: PromoCodeScreen(),
            ),
            Container(
              height: 400,
              child: PaymentMethodsPage(),
            ),
            Container(
              height: 345,
             child: AddressPage(),
            ),

          ],
        ),
      ),
    );
  }
}
