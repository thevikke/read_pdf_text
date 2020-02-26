import 'dart:async';

import 'package:flutter/services.dart';

// Creating [MethodChannel] to the Android side.
class ReadPdfText {
  static const MethodChannel _channel = const MethodChannel('read_pdf_text');

  // Mapping the path to <key, value>
  static Future<String> getPDFtext(String path) async {
    final String pdfText = await _channel
        .invokeMethod('getPDFtext', <String, dynamic>{'path': path});
    return pdfText;
  }
}
