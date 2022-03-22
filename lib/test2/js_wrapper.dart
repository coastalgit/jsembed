@JS()
library javascript_bundler;

import 'package:js/js.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';

// basic alert call
@JS('confirmInJS')
external void showConfirmJS(String text);

//promise test
@JS('doTimer')
external dynamic doTimerJS(String timeoutMS, String duration);

//js to dart test
@JS('updateLabel')
external void updateLabelJS();
@JS('updateDartLabel')
external set _updateDartLabel(void Function(String) f);

void assignDartCallback(Function(String) dartFunc){
  _updateDartLabel = allowInterop(dartFunc);
}

// direct DOM test
// @JS('updateLabelViaDOM')
// external void updateLabelDOM();

//js to dart test again
@JS('updateElement')
external void updateElementJS();
@JS('updateDartElement')
external set _updateDartElement(void Function(String, String) f);

void assignDartCallbackElementUpdate(Function(String, String) dartFunc){
  _updateDartElement = allowInterop(dartFunc);
}
