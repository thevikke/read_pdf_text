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

## 0.2.2

Fix bug where android version would crash at build phase. Caused by the removal of JCenter. [Link](https://github.com/thevikke/read_pdf_text/issues/9).

## 0.2.3

- Added support for gradle declarative plugin blocks.
- Upgraded the Android Gradle Plugin (AGP) version to 8.1.0 ([Related issue](https://github.com/thevikke/read_pdf_text/issues/10)).
- Upgraded pdfbox-android to 2.0.27.0.

## 0.3.0

### Breaking Changes

- **Removed deprecated `PluginRegistry.Registrar` API**.
  - The plugin now fully supports Flutter's v2 embedding (`FlutterPlugin`).
  - The static `registerWith(Registrar registrar)` method has been removed.
  - This means older projects using Flutter's v1 embedding may need to upgrade.
  
### Migration Steps

- No additional steps are needed for Flutter 2+ projects.
- If you are using an older Flutter version (before Flutter 1.12), use an earlier version of this plugin.

### Improvements

- Improved plugin lifecycle management by implementing `onAttachedToEngine` and `onDetachedFromEngine`.
- Ensured compatibility with Flutter 3.29.0 and newer.

### Other Changes

- Removed unnecessary `Registrar` imports.
- Cleaned up AndroidManifest.xml to align with the latest Gradle requirements.

### Related Issues

<https://github.com/thevikke/read_pdf_text/issues/11>

## 0.3.1

- Fix iOS crash when PDF has an empty page. <https://github.com/thevikke/read_pdf_text/pull/13>
