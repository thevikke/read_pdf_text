package com.example.read_pdf_text;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.tom_roush.pdfbox.pdmodel.PDDocument;
import com.tom_roush.pdfbox.text.PDFTextStripper;
import com.tom_roush.pdfbox.util.PDFBoxResourceLoader;

import java.io.File;
import java.io.IOException;
import android.util.Log;

/** ReadPdfTextPlugin */
public class ReadPdfTextPlugin implements FlutterPlugin, MethodCallHandler {


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "read_pdf_text");
    // Getting the application context for pdfBox
    PDFBoxResourceLoader.init(flutterPluginBinding.getApplicationContext());
    channel.setMethodCallHandler(new ReadPdfTextPlugin());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "read_pdf_text");
    // Getting the application context for pdfBox
    PDFBoxResourceLoader.init(registrar.activity().getApplicationContext());
    channel.setMethodCallHandler(new ReadPdfTextPlugin());
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    
    if (call.method.equals("getPDFtext")) {
        final String path = call.argument("path");
        final String pdfText = getPDFtext(path);
        result.success("Path: " + pdfText);
      } else 
      {
        result.notImplemented();
      }
  }

  private String getPDFtext(String path)
  {
    String parsedText = "";
    PDDocument document = null;
     try {
      File renderFile = new File(path);
      document = PDDocument.load(renderFile);
      } catch (IOException e) {
      Log.e("PdfBox-Android-Sample", "Exception thrown while loading document to strip", e);
      }
      try {
      //!error: package com.tom_roush.pdfbox.parsedText does not exist
      PDFTextStripper pdfStripper = new PDFTextStripper();
      // pdfStripper.setStartPage(0);
      // pdfStripper.setEndPage(10);
      parsedText = pdfStripper.getText(document);

      } catch (IOException e) {

      Log.e("PdfBox-Android-Sample", "Exception thrown while stripping parsedText", e);

      } finally {

        try {

        if (document != null)document.close();
        } 
          catch (IOException e) 
        {
          Log.e("PdfBox-Android-Sample", "Exception thrown while closing document", e);
        }
      }
      return parsedText;
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }
}
