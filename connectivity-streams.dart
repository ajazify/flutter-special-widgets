import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: InitialApp());
  }
}

//! Initial App
class InitialApp extends StatefulWidget {
  const InitialApp({super.key});

  @override
  State<InitialApp> createState() => _InitialAppState();
}

class _InitialAppState extends State<InitialApp> {
  @override
  void initState() {
    initNoInternetListener(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Hello World!')));
  }
}

///! Connection Status Listener Class
///! Connection Status Listener Class

class ConnectionStatusListener {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final _singleton = ConnectionStatusListener._internal();

  ConnectionStatusListener._internal();

  bool hasShownNoInternet = false;

  //connectivity_plus
  final Connectivity _connectivity = Connectivity();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatusListener getInstance() => _singleton;

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController = StreamController.broadcast();

  Stream get connectionChange => connectionChangeController.stream;

  //flutter_connectivity's listener
  void _connectionChange(List<ConnectivityResult> results) {
    if (results.isNotEmpty) {
      checkConnection();
    }
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup(
        'google.com',
      ); // Use your domain to check the connection instead of "google.com".
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }

  //Hook into connectivity_plus's Stream to listen for changes
  //And check the connection status out of the gate
  Future<void> initialize() async {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    await checkConnection();
  }

  //A clean up method to close our StreamController
  //Because this is meant to exist through the entire application life cycle this isn't really an issue
  void dispose() {
    connectionChangeController.close();
  }
}

///! Method keep it separate
///! Method keep it separate

initNoInternetListener({required BuildContext context}) async {
  var connectionStatus = ConnectionStatusListener.getInstance();
  await connectionStatus.initialize();

  //We are checking initial status here. This will handle our app state when
  //it is started in no internet state.
  if (!connectionStatus.hasConnection) {
    updateConnectivity(false, connectionStatus, context: context);
  }

  //This callback will give us any changes in network
  connectionStatus.connectionChange.listen((event) {
    if (kDebugMode) {
      print("initNoInternetListener $event");
    }
    updateConnectivity(event, connectionStatus, context: context);
  });
}

updateConnectivity(
  dynamic hasConnection,
  ConnectionStatusListener connectionStatus, {
  required BuildContext context,
}) {
  if (!hasConnection) {
    connectionStatus.hasShownNoInternet = true;
    //Handle no internet here
    if (kDebugMode) {
      print('Network is gone!!!!!');
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NoInternetScreen()));
  } else {
    if (connectionStatus.hasShownNoInternet) {
      connectionStatus.hasShownNoInternet = false;
      //Handle internet is resumed here
      if (kDebugMode) {
        print('Network came back!!!!!');
      }

      Navigator.pop(context);
    }
  }
}

///! No Internet Screen
///! No Internet Screen

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("No Internet Connection!")));
  }
}




//! iOS info.plist
//you typically don't need special permissions for basic network connectivity checking, but there are a few considerations:
/*

<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>

This allows HTTP requests (since the code uses InternetAddress.lookup('google.com') which might use HTTP).
Alternative (more secure) - If you want to be more restrictive, you can specify exceptions:

<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>google.com</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>

*/


//! AndroidManifest.xml
/*
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
*/



