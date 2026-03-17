import 'web_open_stub.dart'
  if (dart.library.html) 'web_open_web.dart';

Future<void> openInNewTab(String url) => platformOpenInNewTab(url);