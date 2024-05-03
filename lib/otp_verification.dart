import 'package:flutter/material.dart';

import 'edit_profile.dart';


class OtpVerificationPage extends StatelessWidget {
  final TextEditingController txt1 = TextEditingController();
  final TextEditingController txt2 = TextEditingController();
  final TextEditingController txt3 = TextEditingController();
  final TextEditingController txt4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Verify Code',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Image.asset(
              'images/background_image.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Please enter the code sent on your number',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      myInputBox(context, txt1),
                      myInputBox(context, txt2),
                      myInputBox(context, txt3),
                      myInputBox(context, txt4),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Didn't receive OTP?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Resend OTP?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: () {
                        String otp =
                            "${txt1.text}${txt2.text}${txt3.text}${txt4.text}";
                        print("Entered OTP: $otp");

                        // Check if OTP is valid (you can customize this logic)
                        if (otp == "1234") {
                          // If OTP is valid, navigate to EditProfilePage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfilePage()),
                          );
                        } else {
                          // Handle incorrect OTP (you can display an error message)
                          print("Incorrect OTP");
                          // You can display a message or handle incorrect OTP in another way
                        }
                      },



                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF004AAD),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Verify'),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 200.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color(0xFF004AAD),
                        side: BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Back'),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Image.asset(
                    'images/time_wise.png',
                    height: 200.0,
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      'Bringing Freshness to Groceries',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myInputBox(BuildContext context, TextEditingController controller) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.black12),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: TextField(
        controller: controller,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          counterText: '',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
