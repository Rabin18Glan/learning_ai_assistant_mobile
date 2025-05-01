import 'package:flutter/material.dart';

class UploadDocumentPage extends StatelessWidget {
  const UploadDocumentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Document'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Implement upload functionality here
          },
          child: const Text('Upload Document'),
        ),
      ),
    );
  }
}
