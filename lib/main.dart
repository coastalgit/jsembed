import 'package:flutter/material.dart';
import 'package:jsembed/test1/jstest1_page.dart';
import 'package:jsembed/widgets/button_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Embed JS Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonWidget(icon: Icons.web_asset, text: 'Dart.js', onClicked:  () => _navigateToTest1()),
          ],
        ),
      ),
    );
  }

  _navigateToTest1() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => JSTest1Page(
      ),
    ));
  }

}
