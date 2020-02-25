import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:read_pdf_text/read_pdf_text.dart';

// make this the example app and move the rest of the code to another file
class PDFreaderExample extends StatefulWidget {
  @override
  _PDFreaderExampleState createState() => _PDFreaderExampleState();
}

class _PDFreaderExampleState extends State<PDFreaderExample> {
  String _pdfText = '';
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.folder_open),
        onPressed: () {
          FilePicker.getFile().then((File file) async {
            if (file.path.isNotEmpty) {
              setState(() {
                _loading = true;
              });
              getPDFtext(file.path).then((pdfText) {
                final text = pdfText.replaceAll("\n", " ");
                setState(() {
                  _pdfText = text;
                  _loading = false;
                });
              });
            }
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: SingleChildScrollView(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text(_pdfText),
      ),
    );
  }

  Future<String> getPDFtext(String path) async {
    String text = "";

    try {
      text = await ReadPdfText.getPDFtext(path);
    } on PlatformException {
      text = 'Failed to get pdf text.';
    }
    return text;
  }
}
