@JS()
library javascript_bundler3;

import 'package:js/js.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';

@JS('updateDOM')
external void updateDOMJS(String inputVal);

/*
@JS('doDelayedUpdate')
external dynamic doDelayedUpdateJS(String delay);

@JS('doDartUpdate')
external set _doDartUpdate(void Function(String, String) f);

void assignDartCallbackDelayedUpdate(Function(String, String) dartFunc){
  _doDartUpdate = allowInterop(dartFunc);
}
*/
