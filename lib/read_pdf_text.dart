import 'dart:async';

import 'package:flutter/services.dart';

class ReadPdfText {
  static const MethodChannel _channel = const MethodChannel('read_pdf_text');

  static Future<String> getPDFtext(String path) async {
    final String pdfText = await _channel
        .invokeMethod('getPDFtext', <String, dynamic>{'path': path});
    return pdfText;
  }
}
