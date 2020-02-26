# read_pdf_text

This is package parses text out of pdf documents and returns it as string.

## Getting Started

The package at this point is only one function getPDFtext(path)
Path being the path to the pdf file you want to parse.

/// Future<String> getPDFtext(String path) async {
///   String text = "";
///  try { 
///   text = await ReadPdfText.getPDFtext(path);
///   } on PlatformException {
///    text = 'Failed to get pdf text.';
///  }
///   return text;
///  }

