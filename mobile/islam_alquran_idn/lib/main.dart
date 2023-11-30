import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islam_alquran_idn/infrastructure/core/utils/islamalquranidn_http_overrides.dart';
import 'business_logic/core/bloc_observer.dart';
import 'package:islam_alquran_idn/presentation/app.dart';

Future<void> main() async {
  try {
    // Add this if necessary to ensure flutter binding has been initialized
    HttpOverrides.runWithHttpOverrides(() async {
      WidgetsFlutterBinding.ensureInitialized();

      // Set global bloc observer if debugging  
      if (kDebugMode) Bloc.observer = SimpleBlocObserver();
      return runApp(const App());
    }, IslamAlquranHttpOverrides());
  } catch (e, stackTrace) {
    debugPrint('$e, $stackTrace');
  }
}
