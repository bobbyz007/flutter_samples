import 'package:flutter/material.dart';

void main() => runApp(CustomScrollViewWidget());

class CustomScrollViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "scroll component",
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('CustomScrollView'),
                background: Image.asset('assets/banner/banner1.png'),
              ),
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Card(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          child: Text('grid $index'),
                        ),
                      );
                    },
                  childCount: 11
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0, // 纵轴扩展
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 3.0
                )
            ),
            SliverFixedExtentList(
                itemExtent: 60.0,
                delegate: SliverChildListDelegate(
                  List.generate(20, (index)  {
                    return GestureDetector(
                      onTap: () {
                        print("click $index");
                      },
                      child: Card(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(15),
                          child: Text('list $index'),
                        ),
                      ),
                    );
                  })
                ), 
            )
          ],
        ),
      ),
    );
  }
}