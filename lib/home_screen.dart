import 'package:flutter/material.dart';
import 'counter_screen_v1.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key : key);

  void _pushScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BLoC Example"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text("Counter"),
            trailing: Chip(
              label: Text("Local State"),
              backgroundColor: Colors.blue[800],
            ),
            onTap: () => _pushScreen(context, CounterScreenWithLocalStatek()),
          )
        ],
      ),
    );
  }
}
