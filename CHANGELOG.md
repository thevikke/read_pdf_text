## 0.0.1

First version

## 0.0.2

Second version fixed platforms

## 0.0.3

Wrote README file
Added license

## 0.0.4

Updated README

## 0.0.5

Updated README
Commented code

## 0.0.6

Updated example (only opens pdf files now)
Updated README

## 0.0.7

Updated README

## 0.0.8

Removed unused variables and comments.
Added functionality for paginating the text from pdf document.
Added functionality to fetch the length of the pdf document in pages.
Updated example to represent these changes.
Updated README and description

## 0.1.0

Add iOS functionality:

- getPDFtext()
- getPDFtextPaginated()
- getPDFlength()
Documentation for those methods.
Updated README.md of this package and README.md of the example.
Updated file_picker plugin in the example. Some code changes to reflect new version of file_picker.

## 0.1.1

Updated dart documentation.

## 0.2.0

Breaking change! Updated package to support null-safety. Updated example to null-safety. Updated documentation.

## 0.2.1

Fix bug where the underlying [PDFbox](https://github.com/TomRoush/PdfBox-Android) plugin would break if downloading multiple PDF-files with the same name and then attempting to open one of them. Now throws a PlatformException. Additionally added PlatformExceptions if something else breaks within the Android code. This should allow users to catch the exception and inform the user that something went wrong.
