# read_pdf_text

This package parses text out of PDF document and returns it as a string.

## Android

On Android the plugin uses [PDFbox](https://github.com/TomRoush/PdfBox-Android) open source library modified by Tom Roush.

## iOS

The iOS plugin uses PDFKit to parse the text out of PDF documents. It requires iOS version 11 or higher.

**For error like: "Could not find or use auto-linked library 'swiftObjectiveC'"**

**Solution can be found here: <https://stackoverflow.com/a/54586937/2881394>**

## Getting Started

The package only has three functions getPDFtext(path), getPDFtextPaginated(path) and getPDFlength(path).
Path is the file path to the PDF file you want to parse. I used [file_picker](https://pub.dev/packages/file_picker) package in the example to get the path of the PDF file.

Check the example for more details.

## Example

![read_pdf_text.gif](read_pdf_text.gif)

## getPDFtext(String path)

Returns text from PDF file as a String.

```dart
    Future<String> getPDFtext(String path) async {
    String text = "";
    try {
      text = await ReadPdfText.getPDFtext(path);
    } on PlatformException {
      text = 'Failed to get PDF text.';
    }
    return text;
  }
```

## getPDFtextPaginated(String path)

Returns text from PDF but in a String list, where each item is a page of the PDF file.

```dart
  Future<List<String>> getPDFtextPaginated(String path) async {
    List<String> textList = List<String>();
    try {
      textList = await ReadPdfText.getPDFtextPaginated(path);
    } on PlatformException {
      text = 'Failed to get PDF text.';
    }
    return textList;
  }
```

## getPDFlength(String path)

Returns length of the document as an integer.

```dart
  Future<int> getPDFlength(String path) async {
    int length = 0;
    try {
      length = await ReadPdfText.getPDFlength(path);
    } on PlatformException {
      text = 'Failed to get PDF length';
    }
    return length;
  }
```

## I wrote an article about developing package for Flutter check it out

  [How to write Flutter plugin --1](https://medium.com/@kristian.tuusjarvi/writing-flutter-plugin-package-1-5b5bfafce60f?sk=3e36226a62e7584c83b50663497cac68)
  