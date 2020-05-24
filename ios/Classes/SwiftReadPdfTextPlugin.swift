import Flutter
import UIKit
import PDFKit

@available(iOS 11, *)
public class SwiftReadPdfTextPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "read_pdf_text", binaryMessenger: registrar.messenger())
    let instance = SwiftReadPdfTextPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  @available(iOS 11, *)
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
          let args = call.arguments as! NSDictionary
          let path = args["path"] as! String

      DispatchQueue.global(qos: .default).async {
        if call.method == "getPDFtext" {
            self.getPDFtext(result: result, path: path)
        }
        else if call.method == "getPDFtextPaginated"
        {
           self.getPDFtextPaginated(result: result, path: path)
        }  
        else if call.method  == "getPDFlength"
        {
          self.getPDFlength(result: result, path: path)
        }   
        else {
                DispatchQueue.main.sync {
                  result(FlutterMethodNotImplemented)
                }
        }
      }
  }
  // Gets all the text from the PDF document to a string [pdfText].
  private func getPDFtext (result: FlutterResult, path: String)
  {
          var pdfText = ""

            if let pdf = PDFDocument(url: URL(fileURLWithPath: path)) {
            let pageCount = pdf.pageCount
          
              for i in 0 ..< pageCount {
                  let pageContent = pdf.page(at: i)!.string!
                  pdfText += pageContent
              }
                DispatchQueue.main.sync {
                  result(pdfText);
                }
            }
            else
            {
                DispatchQueue.main.sync {
                  result(FlutterError(code: "NO_PATH",
                  message: "Path cannot be found",
                  details: nil))
                }
            }
  }
// Gets text from each page of the PDF document to elements in [pdfArray].
private func getPDFtextPaginated (result: FlutterResult, path: String)
  {
      var pdfArray = [String]()

            if let pdf = PDFDocument(url: URL(fileURLWithPath: path)) {
            let pageCount = pdf.pageCount
          
              for i in 0 ..< pageCount {
                  let pageContent = pdf.page(at: i)!.string!
                  pdfArray.append(pageContent)
              }
                DispatchQueue.main.sync {
                  result(pdfArray);
                }
            }
            else
            {
                DispatchQueue.main.sync {
                  result(FlutterError(code: "NO_PATH",
                  message: "Path cannot be found",
                  details: nil))
                }
            }
  }
  // Gets the length of the document into [pageCount].
  private func getPDFlength (result: FlutterResult, path: String)
  {
      if let pdf = PDFDocument(url: URL(fileURLWithPath: path)) {
            let pageCount = pdf.pageCount

                DispatchQueue.main.sync {
                  result(pageCount);
                }
            }
            else
            {
                DispatchQueue.main.sync {
                  result(FlutterError(code: "NO_PATH",
                  message: "Path cannot be found",
                  details: nil))
                }
            }
  }
}
