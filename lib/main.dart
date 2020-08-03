import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

enum CounterEvent { increment, decrement }

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc(int initialState) : super(initialState);

  int _increaseState(int state) => state + 1;
  int _decreaseState(int state) {
    state -= 1;
    if (state < 0)
      addError(Exception('Negative State Reached'), StackTrace.current);
    return state;
  }

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    // TODO: implement mapEventToState
    switch (event) {
      case CounterEvent.increment:
        yield _increaseState(state);
        break;
      case CounterEvent.decrement:
        yield _decreaseState(state);
        break;
    }
  }

//  @override
//  void onTransition(Transition<CounterEvent, int> transition) {
//    // TODO: implement onTransition
//    print('$transition');
//    super.onTransition(transition);
//  }

//  @override
//  void onError(Object error, StackTrace stackTrace) {
//    // TODO: implement onError
//    print('$error, $stackTrace');
//    super.onError(error, stackTrace);
//  }
}

//class FirstCounterCubit extends Cubit<int> {
//  FirstCounterCubit(int initialState) : super(initialState);
//  int _increaseState(int state) => state + 1;
//  void increment() => emit(_increaseState(state));
//  @override
//  void onChange(Change<int> change) {
//    print(change);
//    // TODO: implement onChange
//    super.onChange(change);
//  }
//}

//class SecondCounterCubit extends Cubit<int> {
//  SecondCounterCubit(int initialState) : super(initialState);
//  int _decreaseState(int state) => state - 1;
//  void decrement() {
//    if (state < 0)
//      addError(Exception('state gone negative error'), StackTrace.current);
//    emit(_decreaseState(state));
//  }
//
//  @override
//  void onChange(Change<int> change) {
//    print(change);
//    // TODO: implement onChange
//    super.onChange(change);
//  }
//
//  @override
//  void onError(Object error, StackTrace stackTrace) {
//    print('$error, $stackTrace');
//    // TODO: implement onError
//    super.onError(error, stackTrace);
//  }
//}

class MyApp extends StatelessWidget {
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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
//  int _counter = 0;
  final bloc = CounterBloc(0);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    bloc.close();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
//      _counter++;
      bloc.add(CounterEvent.increment);
    });
  }

  void _decrementCounter() {
    setState(() {
      bloc.add(CounterEvent.decrement);
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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
//              '$_counter',
              '${bloc.state}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              heroTag: null,
              key: Key('fab1'),
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              heroTag: null,
              key: Key('fab2'),
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              child: Icon(Icons.remove),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  // In response to all changes on all cubits, do the following
//  @override
//  void onChange(Cubit cubit, Change change) {
//    print('${cubit.runtimeType} $change');
//    // TODO: implement onChange
//    super.onChange(cubit, change);
//  }

  @override
  void onEvent(Bloc bloc, Object event) {
    // TODO: implement onEvent
    print('${bloc.runtimeType}, $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    print('${bloc.runtimeType}, $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('${cubit.runtimeType}, $error, $stackTrace');
    // TODO: implement onError
    super.onError(cubit, error, stackTrace);
  }
}
