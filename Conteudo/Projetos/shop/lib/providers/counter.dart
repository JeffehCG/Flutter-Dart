import 'package:flutter/cupertino.dart';

class CounterState{
  int _value = 1;

  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;

  bool diff(CounterState old){
    return old == null || old._value != _value;
  }
}

class CounterProvider extends InheritedWidget{

  final CounterState state = CounterState();

  CounterProvider({Widget child}): super(child: child);

  static CounterProvider of(BuildContext context){
    // Retorna uma instancia da classe CounterProvider
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    throw UnimplementedError();
  }

}