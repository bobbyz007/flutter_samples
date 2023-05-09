import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(CustomScrollViewHeaderWidget());

class CustomScrollViewHeaderWidget extends StatelessWidget {
  SliverPersistentHeader makeHeader(String header) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 200.0,
        child: Container(
          color: Colors.lightBlue,
          child: Center(
            child: Text(header),
          ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SliverPersistentHeader Component",
      home: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            makeHeader('Header Section 1'),
            SliverGrid.count(
              crossAxisCount: 3,
              children: [
                Container(color: Colors.red, height: 150.0,)
              ],
            ),

            makeHeader('Header Section 3'),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.teal[100 * (index % 9)],
                        child: Text('grid item $index'),
                      );
                    },
                  childCount: 20
                ),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0, // 纵轴扩展
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0
                )
            ),
            
            makeHeader('Header Section 4'),
            SliverList(
                delegate: SliverChildListDelegate([
                  Container(color: Colors.pink, height: 150.0,),
                  Container(color: Colors.cyan, height: 150.0,),
                  Container(color: Colors.indigo, height: 150.0,),
                  Container(color: Colors.blue, height: 150.0,),
                ]),
            )
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({required this.minHeight, required this.maxHeight, required this.child});

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child,);
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}