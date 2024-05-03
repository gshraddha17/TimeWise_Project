// import 'package:flutter/material.dart';
// import 'package:time_wise/product_detail_page.dart';
//
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String _selectedValue = '';
//   ProductDetailPage_ pdp =  ProductDetailPage_();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Column(
//         children: <Widget>[
//           RadioListTile<String>(
//             dense: true,
//             visualDensity: const VisualDensity(
//               horizontal: VisualDensity.minimumDensity,
//               vertical: VisualDensity.minimumDensity,
//             ),
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             title: Text('< 3 days shelf life : 10%',style: TextStyle(fontSize: 16),),
//             contentPadding: EdgeInsets.zero,
//             value: 'Option 1',
//             groupValue: _selectedValue,
//             onChanged: (value) {
//               setState(() {
//                 _selectedValue = value!;
//                 pdp.processSelectedFile(0);
//                 print('Selected value: $_selectedValue');
//               });
//             },
//           ),
//           RadioListTile<String>(
//             dense: true,
//             visualDensity: const VisualDensity(
//               horizontal: VisualDensity.minimumDensity,
//               vertical: VisualDensity.minimumDensity,
//             ),
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             title: Text('3 - 5 days shelf life : 5%',style: TextStyle(fontSize: 16),),
//             contentPadding: EdgeInsets.zero,
//             value: 'Option 2',
//             groupValue: _selectedValue,
//             onChanged: (value) {
//               setState(() {
//                 _selectedValue = value!;
//                 pdp.processSelectedFile(1);
//                 print('Selected value: $_selectedValue');
//               });
//             },
//           ),
//           RadioListTile<String>(
//             dense: true,
//             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             visualDensity: const VisualDensity(
//               horizontal: VisualDensity.minimumDensity,
//               vertical: VisualDensity.minimumDensity,
//             ),
//             title: Text('> 7  days shelf life : 2%',style: TextStyle(fontSize: 16),),
//             contentPadding: EdgeInsets.zero,
//             value: 'Option 3',
//             groupValue: _selectedValue,
//             onChanged: (value) {
//               setState(() {
//                 _selectedValue = value!;
//                 pdp.processSelectedFile(2);
//                 print('Selected value: $_selectedValue');
//               });
//             },
//           ),
//         ],
//       ),
//
//     );
//   }
// }
