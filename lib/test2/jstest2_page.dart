import 'package:flutter/material.dart';
import 'package:js/js.dart';
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

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ButtonWidget(icon: Icons.web_asset, text: 'Call JS', onClicked:  () => _makeJSCall()),
        ],
      ),
    );
  }

  _makeJSCall(){
    showConfirm('Hello via js pkg!');
  }
}
