import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tip Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _bill = 0;
  double _percentage = 0;
  double _tip = 0;
  double _total = 0;

  bool _isCustomVisible = false;

  double parseDouble(String text) {
    return double.parse(text);
  }

  String formatAmount(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '').format(amount);
  }

  void _setCustomVisible() {
    setState(() {
      _isCustomVisible = true;
    });
  }

  void _setBill(String bill) {
    setState(() {
      _bill = parseDouble(bill);
      _calculate();
    });
  }

  void _setPercentage(double percentage, [bool hideCustom = false]) {
    setState(() {
      _percentage = percentage;
      _isCustomVisible = hideCustom;
      _calculate();
    });
  }

  void _calculate() {
    setState(() {
      _tip = _bill * _percentage / 100;
      _total = _bill + _tip;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                              onChanged: (text) {
                                _setBill(text);
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.shopping_cart),
                                  labelText: 'Bill total',
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter your total amount')))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: FlatButton(
                          onPressed: () {
                            _setPercentage(5);
                          },
                          child: const Text('5%'),
                          color: _percentage == 5 ? Colors.red : Colors.blue,
                          textColor: Colors.white,
                        )),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: FlatButton(
                          onPressed: () {
                            _setPercentage(10);
                          },
                          child: const Text('10%'),
                          color: _percentage == 10 ? Colors.red : Colors.blue,
                          textColor: Colors.white,
                        )),
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: FlatButton(
                          onPressed: () {
                            _setPercentage(15);
                          },
                          child: const Text('15%'),
                          color: _percentage == 15 ? Colors.red : Colors.blue,
                          textColor: Colors.white,
                        )),
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: FlatButton(
                          onPressed: () {
                            _setPercentage(20);
                          },
                          child: const Text('20%'),
                          color: _percentage == 20 ? Colors.red : Colors.blue,
                          textColor: Colors.white,
                        )),
                    Container(
                        margin: const EdgeInsets.all(10),
                        child: FlatButton(
                          onPressed: () {
                            _setCustomVisible();
                          },
                          child: const Text('custom'),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )),
                  ],
                ),
                Visibility(
                    visible: _isCustomVisible,
                    child: Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                                    onChanged: (text) {
                                      _setPercentage(parseDouble(text), true);
                                    },
                                    decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.money),
                                        labelText: 'Percentage',
                                        border: OutlineInputBorder(),
                                        hintText:
                                            'Enter your custom percentage')))
                          ],
                        ))),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tip amount',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.attach_money),
                          Text(
                            formatAmount(_tip),
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total amount',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.attach_money),
                          Text(
                            formatAmount(_total),
                            style: Theme.of(context).textTheme.headline5,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
