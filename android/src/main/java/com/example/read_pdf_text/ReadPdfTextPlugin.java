package com.example.read_pdf_text;

import androidx.annotation.NonNull;
import android.os.AsyncTask;
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

    channel.setMethodCallHandler(new ReadPdfTextPlugin());
        // Getting the application context for pdfBox
    PDFBoxResourceLoader.init(flutterPluginBinding.getApplicationContext());
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
    channel.setMethodCallHandler(new ReadPdfTextPlugin());
      // Getting the application context for pdfBox
    PDFBoxResourceLoader.init(registrar.activity().getApplicationContext());
  }

static String pdfText;
static Result res;

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    
    if (call.method.equals("getPDFtext")) {
        res = result;
        final String path = call.argument("path");
        parsePDFtext(path);
      } else 
      {
        result.notImplemented();
      }
  }
  static void doneParsing(String parsedText) {
        res.success(parsedText);
    }

  private void parsePDFtext(String path)
  {
    PdfAsyncTask task = new PdfAsyncTask();
    task.execute(path);
  }


    private static class PdfAsyncTask extends AsyncTask<String, String, String> {

        @Override
        protected void onPreExecute() {
            super.onPreExecute();

        }
        @Override
        protected String doInBackground(String... strings) {

            String parsedText = null;
            PDDocument document = null;
            try {
                File renderFile = new File(strings[0]);
                document = PDDocument.load(renderFile);
            } catch(IOException e) {
                Log.e("PdfBox-Android-Sample", "Exception thrown while loading document to strip", e);
            }

            try {
                PDFTextStripper pdfStripper = new PDFTextStripper();
                // pdfStripper.setStartPage(0);
                // pdfStripper.setEndPage(10);

                parsedText = pdfStripper.getText(document);
            }
            catch (IOException e)
            {
                Log.e("PdfBox-Android-Sample", "Exception thrown while stripping text", e);
            } finally {
                try {
                    if (document != null) document.close();
                }
                catch (IOException e)
                {
                    Log.e("PdfBox-Android-Sample", "Exception thrown while closing document", e);
                }
            }

            return parsedText;

        }

        @Override
        protected void onPostExecute(String parsedText) {
            super.onPostExecute(parsedText);

           doneParsing(parsedText);
        }
    }
  

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }

  
}
