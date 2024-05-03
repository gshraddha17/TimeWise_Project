import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadPdfPage extends StatefulWidget {
  @override
  _UploadPdfPageState createState() => _UploadPdfPageState();
}

class _UploadPdfPageState extends State<UploadPdfPage> {
  File? file;

  Future<void> selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null) return;
      final path = result.files.single.path!;

      setState(() {
        file = File(path);
      });
    } catch (e) {
      print('Error selecting file: $e');
    }
  }

  Future<void> uploadFile() async {
    if (file == null) return;

    final fileName = file!.path.split('/').last;
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination);
      await ref.putFile(file!);

      Fluttertoast.showToast(msg: 'File uploaded successfully!');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to upload file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Upload PDF')),
      // body:  Column(
      //     // mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       ElevatedButton(
      //         onPressed: selectFile,
      //         child: Text('Select File'),
      //       ),
      //       SizedBox(height: 8),
      //       ElevatedButton(
      //         onPressed: uploadFile,
      //         child: Text('Upload File'),
      //       ),
      //     ],
      //   ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20), 
            Text('Upload Health Report',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            // Adjust the gap as needed
            ElevatedButton(
              onPressed: selectFile,
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF004AAD),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF004AAD)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Select Pdf'),
            ),
            SizedBox(height: 20), // Adjust the gap as needed
            ElevatedButton(
              onPressed: uploadFile,
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFF004AAD),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF004AAD)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Upload Pdf'),
            )
          ],
        ),
      ),
    );
  }
}
