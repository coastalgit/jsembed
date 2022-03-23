@JS()
library javascript_bundler3;

import 'package:js/js.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js_util';

@JS('updateDOM')
external void updateDOMJS(String inputVal);

@JS('updateDOMDynamic')
external void updateDOMDynamicJS(String inputVal);
