import 'dart:async';

import 'package:flutter/services.dart';

/// Creating [MethodChannel] to the Android side.
class ReadPdfText {
  static const MethodChannel _channel = const MethodChannel('read_pdf_text');

  /// Returns string, whole text of the document
  static Future<String> getPDFtext(String path) async {
    /// Mapping the path to <key, value>
    final String pdfText = await _channel
        .invokeMethod('getPDFtext', <String, dynamic>{'path': path});
    return pdfText;
  }

  /// Returns PDF document as List<String> where each element is a page of the PDF document
  static Future<List<String>> getPDFtextPaginated(String path) async {
    /// Mapping the path to <key, value>
    List<dynamic> pdfTextPaginated = await _channel
        .invokeMethod('getPDFtextPaginated', <String, dynamic>{'path': path});
    List<String> list = pdfTextPaginated.cast<String>().toList();
    return list;
  }

  /// Returns int, number of the pages in the PDF document
  static Future<int> getPDFlength(String path) async {
    /// Mapping the path to <key, value>
    final int pdfLength = await _channel
        .invokeMethod('getPDFlength', <String, dynamic>{'path': path});
    return pdfLength;
  }
}
