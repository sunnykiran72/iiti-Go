import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:iiti_go/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

enum NetworkStatus { online, offline }

class CheckInternetConnectivity extends ChangeNotifier {
  StreamController<NetworkStatus> controller = StreamController();

  networkFunc() {
    Connectivity().onConnectivityChanged.listen((event) {
      (event == ConnectivityResult.mobile || event == ConnectivityResult.wifi)
          ? controller.sink.add(NetworkStatus.online)
          : controller.sink.add(NetworkStatus.offline);
      notifyListeners();
    });
  }
}
