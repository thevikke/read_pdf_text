import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:read_pdf_text/read_pdf_text.dart';

class PDFreaderExample extends StatefulWidget {
  @override
  _PDFreaderExampleState createState() => _PDFreaderExampleState();
}

// Example class for pdf text reader plugin
class _PDFreaderExampleState extends State<PDFreaderExample> {
  String _pdfText = '';
  List<String> _pdfList = [];
  int _pdfLength;

  bool _loading = false;
  bool _paginated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Center(
              child: _pdfLength == null
                  ? Text(
                      "No pages yet",
                      style: TextStyle(color: Colors.red),
                    )
                  : Text(
                      "Pages : $_pdfLength",
                    ),
            ),
          ),
        ],
        title: const Text('PDF Plugin example app'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    // This example uses file picker to get the path
                    FilePicker.getFile(
                            fileExtension: 'pdf', type: FileType.CUSTOM)
                        .then((File file) async {
                      if (file.path.isNotEmpty) {
                        setState(() {
                          _loading = true;
                        });
                        // Call the function to parse text from pdf
                        getPDFtext(file.path).then((pdfText) {
                          final text = pdfText.replaceAll("\n", " ");
                          setState(() {
                            _pdfText = text;
                            _paginated = false;
                            _loading = false;
                          });
                        });
                      }
                    });
                  },
                  child: Text("Get pdf text"),
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.blue,
                  onPressed: () {
                    // This example uses file picker to get the path
                    FilePicker.getFile(
                            fileExtension: 'pdf', type: FileType.CUSTOM)
                        .then((File file) async {
                      if (file.path.isNotEmpty) {
                        setState(() {
                          _loading = true;
                        });
                        // Call the function to parse text from pdf
                        getPDFtextPaginated(file.path).then((pdfList) {
                          List<String> list = List<String>();
                          // Remove new lines
                          pdfList.forEach((element) {
                            list.add(element.replaceAll("\n", " "));
                          });

                          setState(() {
                            _pdfList = list;
                            _paginated = true;
                            _loading = false;
                          });
                        });
                      }
                    });
                  },
                  child: Text("Get pdf text paginated"),
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.green,
                  onPressed: () {
                    // This example uses file picker to get the path
                    FilePicker.getFile(
                            fileExtension: 'pdf', type: FileType.CUSTOM)
                        .then((File file) async {
                      if (file.path.isNotEmpty) {
                        setState(() {
                          _loading = true;
                        });
                        // Call the function to parse text from pdf
                        getPDFlength(file.path).then((length) {
                          setState(() {
                            _pdfLength = length;

                            // Reset variables
                            _pdfList = [];
                            _pdfText = " ";
                            _loading = false;
                          });
                        });
                      }
                    });
                  },
                  child: Text("Get document length (pages)"),
                ),
              ),
            ],
          ),
          _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  // Check if returning text page by page or the whole document as one string
                  child: _paginated
                      ? ListView.builder(
                          itemCount: _pdfList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    _pdfList[index],
                                  ),
                                ),
                              ),
                            );
                          })
                      : SingleChildScrollView(
                          child: Text(_pdfText),
                        ),
                ),
        ],
      ),
    );
  }

  Future<String> getPDFtext(String path) async {
    String text = "";
    try {
      text = await ReadPdfText.getPDFtext(path);
    } on PlatformException {
      text = 'Failed to get PDF text.';
    }
    return text;
  }

  Future<List<String>> getPDFtextPaginated(String path) async {
    List<String> textList = List<String>();
    try {
      textList = await ReadPdfText.getPDFtextPaginated(path);
    } on PlatformException {}
    return textList;
  }

  Future<int> getPDFlength(String path) async {
    int length = 0;
    try {
      length = await ReadPdfText.getPDFlength(path);
    } on PlatformException {}
    return length;
  }
}
