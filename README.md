# read_pdf_text

This package parses text out of pdf documents and returns it as a string. 
On Android the plugin uses [PDFbox](https://github.com/apache/pdfbox) open source library.
The iOS version is not implemented yet.

<img src="https://github.com/thevikke/read_pdf_text/blob/master/read_pdf_text.png" width="300">

## Getting Started

The package only has one function getPDFtext(path).
Path being the file path to the pdf file you want to parse. I used file_picker package in the example to get the path of a pdf file.
Check the example.

```dart
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
				FilePicker.getFile(  
					fileExtension: 'pdf',
            		type: FileType.CUSTOM).then((File file) async {
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
				title: const Text('Pdf plugin example app'),
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
```