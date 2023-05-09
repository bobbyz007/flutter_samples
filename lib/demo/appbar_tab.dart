import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: AppBarPage(),
    );
  }
}

class AppBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppBarPageState();
  }
}

class Item {
  final String title;
  final IconData icon;
  const Item({required this.title, required this.icon});
}

// 创建TabController需要 SingleTickerProviderStateMixin对象
class _AppBarPageState extends State<AppBarPage> with SingleTickerProviderStateMixin<AppBarPage>{
  List<Item> items = const <Item> [
    const Item(title: 'Item1', icon: Icons.directions_car),
    const Item(title: 'Item2', icon: Icons.directions_bike),
    const Item(title: 'Item3', icon: Icons.directions_boat),
    const Item(title: 'Item4', icon: Icons.directions_walk)
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: items.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.home)),
        title: Text('AppBar Title'),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.build)),
          IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: items.map((item) {
            return Tab(
              text: item.title,
              icon: Icon(item.icon),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: items.map((item) {
          return Center(
            child: Text(item.title, style: TextStyle(fontSize: 20.0),),
          );
        }).toList()
      )
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}