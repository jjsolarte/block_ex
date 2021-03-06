import 'dart:async';
import 'package:flutter/widgets.dart';
import '../bloc/bloc.dart';

typedef BlocWidgetBuilder<S> = Widget Function(BuildContext context, S state);

typedef BlocBuilderCondition<S> = bool Function(S previus, S current);

class BlocBuilder<E, S> extends StatefulWidget {
  final Bloc<E, S> bloc;

  final BlocBuilderCondition<S> condition;

  final BlocWidgetBuilder<S> builder;

  const BlocBuilder(
      {Key key,
      @required this.bloc,
      @required this.condition,
      this.builder})
      : assert(bloc != null),
        assert(builder != null),
        super(key: key);

  @override
  _BlocBuilder<E, S> createState() => _BlocBuilder<E, S>();
}

class _BlocBuilder<E, S> extends State<BlocBuilder<E, S>> {
  StreamSubscription<S> _subscription;
  S _previusState;
  S _state;

  @override
  void initState() {
    super.initState();
    _previusState = widget.bloc.currentState;
    _state = widget.bloc.currentState;
    _subscribe();
  }

  @override
  void didUpdateWidget(BlocBuilder<E, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.bloc.state != widget.bloc.state){
      if(_subscription != null){
        _unsubscribe();
        _previusState = widget.bloc.currentState;
        _state = widget.bloc.currentState;
      }
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _state);
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe(){
    if(widget.bloc.state != null){
      _subscription = widget.bloc.state.skip(1).listen((S state) {
        if(widget.condition?.call(_previusState, state) ?? true){
          setState(() {
            _state = state;
          });
        }
        _previusState = state;
      });
    }
  }

  void _unsubscribe(){
    if(_subscription != null){
      _subscription.cancel();
      _subscription = null;
    }
  }
}
