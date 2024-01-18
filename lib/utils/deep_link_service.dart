import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class DeepLinkService {
  StreamSubscription<Map>? streamSubscription;
  init() {
    streamSubscription = FlutterBranchSdk.initSession().listen((data) async {
      print("FlutterBranchSdk: ${data.toString()}");
      if (data.containsKey("+clicked_branch_link") &&
          data["+clicked_branch_link"] == true) {
        //Link clicked. Add logic to get link data
        print('Custom string: ${data.toString()}');
      }
      //TO DO
    }, onError: (error) {
      PlatformException platformException = error as PlatformException;
      print(
          'InitSession error: ${platformException.code} - ${platformException.message}');
    });
  }

  dispose() {
    streamSubscription?.cancel();
  }
}
