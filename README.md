# read_pdf_text

This is package parses text out of pdf documents and returns it as string. 
The plugin uses [PDFbox](https://github.com/apache/pdfbox) open source library.

## Getting Started

The package has at this point is only one function getPDFtext(path).
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
				FilePicker.getFile().then((File file) async {
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