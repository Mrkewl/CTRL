package com.example.ctrl_app
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.google.firebase.FirebaseApp
import com.google.firebase.appcheck.FirebaseAppCheck
import com.google.firebase.appcheck.debug.DebugAppCheckProviderFactory
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
 //  private val CHANNEL = "com.example.ctrl_app.dev"

 //  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
 //      super.configureFlutterEngine(flutterEngine)
 //      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
 //          call, result ->
 //          FirebaseApp.initializeApp(/*context=*/this)
 //          val firebaseAppCheck = FirebaseAppCheck.getInstance()
 //          firebaseAppCheck.installAppCheckProviderFactory(
                //   DebugAppCheckProviderFactory.getInstance()
 //          )
 //      }
 //  }
}
//remove on prod