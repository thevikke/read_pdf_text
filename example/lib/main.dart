import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:read_pdf_text/read_pdf_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _pdfText = '';

  Future<String> getPDFtext(String path) async {
    String text = "";
    ReadPdfText readPdfText = ReadPdfText();
    try {
      text = await readPdfText.getPDFtext(path);
    } on PlatformException {
      text = 'Failed to get pdf text.';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.folder_open),
          onPressed: () {
            FilePicker.getFile().then((File file) {
              //! this takes a long time possible to do it seperately [HandlerThreat]
              getPDFtext(file.path).then((String pdfText) {
                final text = pdfText.replaceAll("\n", " ");
                setState(() {
                  _pdfText = text;
                });
              });
            });
          },
        ),
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Text(_pdfText),
        ),
      ),
    );
  }
}
