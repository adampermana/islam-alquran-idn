import 'dart:io';

import 'dio_helper.dart';

class IslamAlquranHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, host, port) {
        final url = Uri.parse(baseUrl);
        return (host == url.host) && ((url.hasPort ? port == url.port : true));
      };
  }
}
