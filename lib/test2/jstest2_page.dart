import 'package:js/js_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:jsembed/test2/js_wrapper2.dart';
import 'package:jsembed/widgets/button_widget.dart';

class JSTest2Page extends StatefulWidget {
  const JSTest2Page({Key? key}) : super(key: key);

  @override
  State<JSTest2Page> createState() => _JSTest2PageState();
}

class ElementById{
  final String eId;
  final String eValue;

  ElementById(this.eId, this.eValue);
}

class _JSTest2PageState extends State<JSTest2Page> {

  late String _labelTxt;
  late String _labelTxt2;
  late ElementById _elementById;
  void _callbackFromJS(String jsSent){
    debugPrint('CALLBACK FROM JS: '+jsSent);
    setState(() {
      _labelTxt = jsSent;
    });
  }

  void _callback2FromJS(String jsArg1, String jsArg2){
    debugPrint('CALLBACK 2 FROM JS: a1:[{$jsArg1}] a2:[{$jsArg2}]');
    setState(() {
      _labelTxt2 = "a1:[{$jsArg1}] a2:[{$jsArg2}";
      _elementById = ElementById(jsArg1, jsArg2);
    });
  }

  @override
  void initState() {
    super.initState();
    _labelTxt = 'N/A';
    _labelTxt2 = 'Empty';
    _elementById = ElementById('', '');
    assignDartCallback(_callbackFromJS);
    assignDartCallbackElementUpdate(_callback2FromJS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Built in Dart.js'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _buildBody(),
        ));
  }

  _showSnackBar(String snackCaption, bool isError){
    debugPrint(snackCaption);
    final snackBar = SnackBar(content: Text(snackCaption), backgroundColor: isError?Colors.red:Colors.green.shade700,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildBody() {
    debugPrint('_buildBody');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ButtonWidget(icon: Icons.web_asset, text: 'JS Alert', onClicked:  () => _makeJSCall1()),
          const SizedBox(height: 20),
          ButtonWidget(icon: Icons.web_asset, text: 'JS Promise (TIMER)', onClicked:  () {
            _makeJSCall2('4000','2000').then((promiseResult) => _showSnackBar('Promise result:['+promiseResult+']', false)).catchError((promiseErr) => _showSnackBar('Promise error:['+promiseErr+']', true));
          }),
          const SizedBox(height: 20),
          ButtonWidget(icon: Icons.web_asset, text: 'JS Promise (TIMEOUT)', onClicked:  () {
            _makeJSCall2('2000','4000').then((promiseResult) => _showSnackBar('Promise result:['+promiseResult+']', false)).catchError((promiseErr) => _showSnackBar('Promise error:['+promiseErr+']', true));
          }),
          const SizedBox(height: 20),
          ButtonWidget(icon: Icons.web_asset, text: 'JS callback to Dart', onClicked:  () {
            _makeJSCall3();
          }),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(_labelTxt),
            ),
          ),

/*
          const SizedBox(height: 20),
          ButtonWidget(icon: Icons.web_asset, text: 'JS getElementById update', onClicked:  () {
            _makeJSCall4();
          }),
          const SizedBox(height: 10),
          _htmlTest(),
*/
          const SizedBox(height: 20),
          ButtonWidget(icon: Icons.web_asset, text: 'JS callback to Dart 2 args', onClicked:  () {
            _makeJSCall5();
          }),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(_labelTxt2),
            ),
          ),
          const SizedBox(height: 10),
          _htmlWidgetTest(),
        ],

      ),
    );
  }

  _makeJSCall1(){
    showConfirmJS('Hello via js pkg!');
  }

  Future _makeJSCall2(String timeoutMs, String timerVal) async {
    var result = await promiseToFuture(doTimerJS(timeoutMs, timerVal));
    //var result = await promiseToFuture(doTimerJS('1000', '3000'));
    return result;
  }

  _makeJSCall3(){
    updateLabelJS();
  }

  _makeJSCall5(){
    updateElementJS();
  }

  Widget _htmlTest() {
    //return Html(data: "<h1>Hello</h1>");
    //return Html(data: "<h1>Hello</h1>", style: {"#iconwrap": Style(color: Colors.blue)},);
    //return Text('TESTING', style: TextStyle(color: Colors.white));
    //return HtmlElementView(viewType: '<h1>Hello</h1>');
    //Html wrapped = Html(data: "<span #iconwrap id=\"2\" style=\"color:#e0dcdc;\">");

    // string manipulated approach
    //String prefix = "<span #iconwrap id=\"2\" style=\"color:#e0dcdc;\">";
    String content = "<h1 id=\"testid\">I am HTML!</h1>";
    //return Html(data: wrapped);
    //return Html(data: wrapped, style: {"#iconwrap": Style(color: Colors.blue)},);
    Widget hw = Html(
      data: content,
    );
    return hw;
  }

  Widget _htmlWidgetTest() {
    debugPrint('_htmlWidgetTest');
    String tmp = currentTimeInSeconds().toString(); // just to force an update by customStylesBuilder
    String line1 = "<h1>I am HTML element 1</h1>";
    String line2 = _elementById.eId.isEmpty?"<h1 id=\"testid\">I am HTML element 2</h1>":"<h1 id=\"testid\" class=\"{$tmp}\">I am HTML element 2 updated</h1>";
    return HtmlWidget(
      line1+line2,
      customStylesBuilder: (element) {
        //if (element.localName!.contains(_elementById.eId)) {
        debugPrint('_htmlWidgetTest.customStylesBuilder id:['+_elementById.eId+']');
        debugPrint('_htmlWidgetTest.customStylesBuilder attribs isEmpty:['+element.attributes.isEmpty.toString()+']');
        //String keyVal =
        if (element.attributes.containsValue(_elementById.eId)) {
          debugPrint('_htmlWidgetTest.customStylesBuilder match on ID');
          return {'color': 'red'};
        }
        return null;
      },
    );
  }

  static int currentTimeInSeconds() {
    var ms = (DateTime.now()).millisecondsSinceEpoch;
    return (ms / 1000).round();
  }

  _makeJSCall4(){
    //updateLabelDOM();
  }

}
