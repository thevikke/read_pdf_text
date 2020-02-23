import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:read_pdf_text_example/backdrop.dart';

void main() {
  runApp(
    MaterialApp(
      home: BackdropPage(),
      theme: ThemeData(primarySwatch: Colors.teal),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _pdfText = '';
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.folder_open),
        onPressed: () {
          FilePicker.getFile().then((File file) async {
            //? this takes a long time possible to do it seperately [HandlerThread]
            //? or rather use compute the dart Isolates
            //? the compute has a bug in it and doens't work with [methodChannels]
            //? back to using [HandlerThread]
            //! it might be possible with [flutter_isolate] afterall!
            //? Caused by the [flutter_isolate]
            //! Unhandled Exception: MissingPluginException(No implementation found for method getPDFtext on channel read_pdf_text)
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
