import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:read_pdf_text/read_pdf_text.dart';

void main() {
  // Useless
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _pdfText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.folder_open),
          onPressed: () {
            FilePicker.getFile().then((File file) async {
              //? this takes a long time possible to do it seperately [HandlerThread]
              //? or rather use compute the dart Isolates
              //? the compute has a bug in it and doens't work with [methodChannels]
              //? back to using HandlerThread
              //! it might be possible with [flutter_isolate] afterall!
              final pdfText = await compute(getPDFtext, file.path);

              final text = pdfText.replaceAll("\n", " ");
              setState(() {
                _pdfText = text;
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
