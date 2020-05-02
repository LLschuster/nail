import 'package:flutter/material.dart';
import 'package:nail/repositories/base.dart';
import 'package:nail/ui/statistics.dart';
import 'package:nail/ui/workoutFeed.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<Base>(
      create: (_) => Base(),
      child: MaterialApp(
        title: 'Nail workuot',
        theme: ThemeData(
            primarySwatch: Colors.grey, accentColor: Colors.blue),
        home: Consumer<Base>(builder: (_, store, __) => HomePage(title: 'Fitness track', store: store,),),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title, this.store}) : super(key: key);

  final String title;
  final Base store;

  @override
  _HomePageState createState() => _HomePageState(store: store);
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final Base store;

  _HomePageState({Key key,this.store});
  
  void _changePageIndex(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  void initState(){
    //store.getWorkouts('101');
    super.initState();
  }

  List<Widget> pages = [WorkoutFeed(), Statistics()];

  @override
  Widget build(BuildContext context) {
    print(store);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            title: const Text('Workouts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            title: const Text('Statistics'),
          ),
        ],
        currentIndex: _pageIndex,
        onTap: _changePageIndex,
        selectedItemColor: Colors.grey[300],
      ),
    );
  }
}
