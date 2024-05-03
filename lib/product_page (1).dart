// // ignore: file_names
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:timewise/product_detail_page.dart';

// class ProductPage extends StatelessWidget {
//   const ProductPage({super.key});

//   // final User user;

//   void _openBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(30),
//         ),
//       ),
//       builder: (ctx) => DraggableScrollableSheet(
//         expand: false,
//         initialChildSize: 0.88,
//         maxChildSize: 1,
//         builder: (context, scrollController) => SingleChildScrollView(
//           controller: scrollController,
//           child: const ProductDetailPage(
//         ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           onPressed: () => _openBottomSheet(context),
//           child: const Text('Click'),
//         ),
//       ),
//     );
//   }
// }
