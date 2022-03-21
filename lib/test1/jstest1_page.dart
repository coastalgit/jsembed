import 'package:flutter/material.dart';
import 'dart:js' as js;

import 'package:jsembed/widgets/button_widget.dart';

class JSTest1Page extends StatefulWidget {
  const JSTest1Page({Key? key}) : super(key: key);

  @override
  State<JSTest1Page> createState() => _JSTest1PageState();
}

class _JSTest1PageState extends State<JSTest1Page> {
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
    js.context.callMethod('alertMessage', ['Flutter is calling upon JavaScript!']);
  }
}
