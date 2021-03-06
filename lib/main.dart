import 'package:flutter/material.dart';
import 'package:jsembed/test1/jstest1_page.dart';
import 'package:jsembed/test2/jstest2_page.dart';
import 'package:jsembed/test3/jstest3_page.dart';
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
            const SizedBox(height: 20),
            ButtonWidget(icon: Icons.web_asset, text: 'Package js', onClicked:  () => _navigateToTest2()),
            const SizedBox(height: 20),
            ButtonWidget(icon: Icons.web_asset, text: 'HTMLElementView', onClicked:  () => _navigateToTest3()),
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

  _navigateToTest2() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => JSTest2Page(
      ),
    ));
  }

  _navigateToTest3() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const JSTest3Page(
      ),
    ));
  }

}
