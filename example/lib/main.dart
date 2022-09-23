import 'dart:math';

import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  int itemCount = 200;

  @override
  Widget build(BuildContext context) {
    List<ListViewData> data = prepareListViewData(itemCount);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: AzListView(
          data: data,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            final item = data[index];

            String susTag = item.getSuspensionTag();
            return Column(
              children: [
                Offstage(
                  offstage: item.isShowSuspension != true,
                  child: _buildSusWidget(susTag),
                ),
                ListTile(title: Text(item.title)),
              ],
            );
          },
          indexBarData: SuspensionUtil.getTagIndexList(data),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildSusWidget(String susTag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(color: Colors.grey),
      height: 20,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Text(susTag),
        ],
      ),
    );
  }

  List<ListViewData> prepareListViewData(int itemCount) {
    List<String> titles = [
      "cgFIk",
      "8hxQs",
      "M0LZG",
      "hDkIo",
      "pBxG4",
      "pDV4h",
      "jHjCH",
      "9jcPy",
      "rT0cL",
      "q6Nsx",
      "odWgn",
      "L7wAg",
      "3HwBT",
      "0fY2m",
      "kW6Ze",
      "LJ3at",
      "cgX2z",
      "IAVKB",
      "bW2Jt",
      "jd5TW",
      "pMRHK",
      "BhQto",
      "PaWho",
      "mamPO"
    ];
    List<ListViewData> list = [];

    for (int i = 0; i < itemCount; i++) {
      // list.add(ListViewData(titles[i]));
      list.add(ListViewData(getRandomString(5)));
    }

    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(list);

    return list;
  }

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

class ListViewData extends ISuspensionBean {
  String title;

  ListViewData(this.title);

  @override
  String getSuspensionTag() {
    String initial = title.substring(0, 1).toUpperCase();

    if (!RegExp("[A-Z]").hasMatch(initial)) {
      initial = "#";
    }
    return initial;
  }
}
