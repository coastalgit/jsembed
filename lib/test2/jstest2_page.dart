import 'package:flutter/material.dart';
import 'package:js/js_util.dart';

import 'package:jsembed/test2/js_wrapper.dart';
import 'package:jsembed/widgets/button_widget.dart';

class JSTest2Page extends StatefulWidget {
  const JSTest2Page({Key? key}) : super(key: key);

  @override
  State<JSTest2Page> createState() => _JSTest2PageState();
}

class _JSTest2PageState extends State<JSTest2Page> {


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
}
