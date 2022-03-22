@JS()
library javascript_bundler;

import 'package:js/js.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';

@JS('confirmInJS')
external void showConfirmJS(String text);

//promise test
@JS('doTimer')
external dynamic doTimerJS(String timeoutMS, String duration);
