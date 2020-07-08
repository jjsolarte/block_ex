import 'package:flutter/material.dart';
import 'action_button.dart';
import 'blocs/counter_bloc.dart';
import 'flutter_bloc/bloc_builder.dart';

class CounterScreenWithLocalStatek extends StatefulWidget {
  @override
  _CounterScreenWithLocalStatekState createState() =>
      _CounterScreenWithLocalStatekState();
}

class _CounterScreenWithLocalStatekState
    extends State<CounterScreenWithLocalStatek> {
  CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc();
  }

  @override
  void dispose() {
    _counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter - Local State"),
      ),
      body: Center(
          child: BlocBuilder(
        bloc: _counterBloc,
        builder: (BuildContext context, int state) {
          return Text('$state',
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold));
        },
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ActionButton(iconData: Icons.add, onPressed: (){
              _counterBloc.dispatch(CounterEvent.increment);
            }),
            ActionButton(iconData: Icons.remove, onPressed: (){
              _counterBloc.dispatch(CounterEvent.decrement);
            }),
            ActionButton(iconData: Icons.replay, onPressed: (){
              _counterBloc.dispatch(CounterEvent.reset);
            }),
          ],
        ),
      ),
    );
  }
}
