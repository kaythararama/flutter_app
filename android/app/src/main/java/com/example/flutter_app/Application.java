package com.example.flutter_app;

import com.example.flutter_app.FirebaseCloudMessagingPluginRegistrant;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;

public class Application extends FlutterApplication implements PluginRegistry.PluginRegistrantCallback {
    @Override
    public void onCreate() {
        super.onCreate();
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    @Override
    public void registerWith(PluginRegistry registry) {
        //GeneratedPluginRegistrant.registerWith(registry);
        //FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
    }
}
/*
@Override
  public void registerWith(PluginRegistry registry) {
    FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
  }




 */