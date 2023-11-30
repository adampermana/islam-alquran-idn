import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RouterRefreshStream extends ChangeNotifier {
  RouterRefreshStream(List<Stream<dynamic>> streams) {
    for (final stream in streams) {
      // Notify first for initialization on each streams
      notifyListeners();

      // Hold the Stream subscription with handler onto an array
      _subscriptions.add(stream.asBroadcastStream().listen(
            (dynamic _) => notifyListeners(),
          ));
    }
  }

  final List<StreamSubscription<dynamic>> _subscriptions = [];
  @override
  void dispose() {
    for (final subs in _subscriptions) {
      // Stop stream subscriptions on each streams on dispose
      subs.cancel();
    }
    super.dispose();
  }
}
