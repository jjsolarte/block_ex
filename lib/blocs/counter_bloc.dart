import '../bloc/bloc.dart';

enum CounterEvent{ increment, decrement, reset }

class CounterBloc extends Bloc<CounterEvent, int>{
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async*{
    if(event == CounterEvent.increment){
      yield currentState +1;
    }else if(event == CounterEvent.decrement){
      yield currentState -1;
    }else if(event == CounterEvent.reset){
      yield 0;
    }
  }

}