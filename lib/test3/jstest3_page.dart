import 'dart:ui' as ui;
import 'package:js/js_util.dart';
import 'package:flutter/material.dart';
import 'package:jsembed/test3/js_wrapper3.dart';
import 'package:universal_html/html.dart';

import 'package:jsembed/widgets/button_widget.dart';

//test access from js func (getElementById)
Widget getElement1() {
  String htmlId = "testid";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = 'none'
      ..appendText("I am html text")
      ..style.textFillColor = '#33cc33';

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}

void _actionOnClick(String msg) {
  debugPrint(msg);
}

// test onclick
Widget getElement2() {
  String htmlId = "testid2";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final elem = ButtonElement()
      ..id = htmlId
      ..appendText("I am html button")
      ..style.textFillColor = '#FFFFFF'
      ..style.backgroundColor = '#3630a3'
      ..onClick.listen((event) {
        //debugPrint('CLICKED HTML BUTTON');
        return _actionOnClick('Click');
      });

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}

//test access from js func (getElementsByClassName)
Widget getElement3() {
  //<div id="dadDiv" style="display: none;"></div>
  String htmlId = "dadDiv";

  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    final elem = DivElement()..id = htmlId
    //..style.display = 'none'
    ;

    return elem;
  });

  return HtmlElementView(viewType: htmlId);
}

class JSTest3Page extends StatefulWidget {
  const JSTest3Page({Key? key}) : super(key: key);

  @override
  State<JSTest3Page> createState() => _JSTest3PageState();
}

class ElementById {
  final String eId;
  final String eValue;

  ElementById(this.eId, this.eValue);
}

class _JSTest3PageState extends State<JSTest3Page> {
  //final divElement = DivElement();
  late ElementById _elementById;
  late int _ctr;

  void _jsCallback(String jsArg1, String jsArg2) {
    debugPrint('CALLBACK FROM JS: a1:[{$jsArg1}] a2:[{$jsArg2}]');
    setState(() {
      _elementById = ElementById(jsArg1, jsArg2);
    });
  }

  @override
  void initState() {
    super.initState();
    _ctr = 0;
    _elementById = ElementById('', '');
    //assignDartCallbackDelayedUpdate(_jsCallback);
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

  _showSnackBar(String snackCaption, bool isError) {
    debugPrint(snackCaption);
    final snackBar = SnackBar(
      content: Text(snackCaption),
      backgroundColor: isError ? Colors.red : Colors.green.shade700,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

/*
  Widget _buildBody() {
    debugPrint('_buildBody');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ButtonWidget(
              icon: Icons.web_asset,
              text: 'JS Promise (TIMEOUT)',
              onClicked: () {
                _makeJSCall1('2000')
                    .then((promiseResult) => _showSnackBar('Promise result:[' + promiseResult + ']', false))
                    .catchError((promiseErr) => _showSnackBar('Promise error:[' + promiseErr + ']', true));
              }),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('ID:' + (_elementById.eId) + ' VAL:' + (_elementById.eValue)),
            ),
          ),
          const SizedBox(height: 10),
          _htmlWidgetTest(),
        ],
      ),
    );
  }
*/

  Widget _buildBody() {
    return Center(
      child: Stack(
        children: [
/*
          Container(
            color: Colors.pink.shade100,
            child: getElement3(),
          ),
*/
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  icon: Icons.web_asset,
                  text: 'Update DOM via JS',
                  onClicked: () {
                    _makeJSCall1();
                  }),
              const SizedBox(height: 10),
              Container(
                color: Colors.blueGrey.shade100,
                child: SizedBox(height: 100, child: getElement1()),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.blueGrey.shade100,
                child: SizedBox(
                    height: 100,
                    width: 170,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getElement2(),
                    )),
              ),
              const SizedBox(height: 10),
              ButtonWidget(
                  icon: Icons.web_asset,
                  text: 'Update DOM dynamically via JS',
                  onClicked: () {
                    _makeJSCall2();
                  }),

/*
              const SizedBox(height: 10),
              Container(
                color: Colors.blueGrey.shade100,
                child: SizedBox(height: 100, child: getElement3()),
              ),
*/

            ],
          ),
        ],
      ),
    );
  }

  _makeJSCall1() {
    _ctr = _ctr + 1;
    updateDOMJS(_ctr.toString());
  }

  _makeJSCall2() {
    _ctr = _ctr + 1;
    updateDOMDynamicJS(_ctr.toString());
  }

  // Future _makeJSCall1(String timerVal) async {
  //   var result = await promiseToFuture(doDelayedUpdateJS(timerVal));
  //   return result;
  // }

}
