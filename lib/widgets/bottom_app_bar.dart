import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class myBottomAppBar extends StatelessWidget {
  // const myBottomAppBar({
  //   this.fabLocation = FloatingActionButtonLocation.endDocked,
  //   this.shape = const CircularNotchedRectangle(),
  // });

  // final FloatingActionButtonLocation fabLocation;
  // final NotchedShape? shape;

  // static final List<FloatingActionButtonLocation> centerLocations =
  //     <FloatingActionButtonLocation>[
  //   FloatingActionButtonLocation.centerDocked,
  //   FloatingActionButtonLocation.centerFloat,
  // ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //shape: shape,
      color: const Color(0xFFF53935),
      child: IconTheme(
        data: const IconThemeData(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            IconButton(
              tooltip: 'Open navigation menu',
              icon: const Icon(Icons.run_circle),
              onPressed: () {},
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(Icons.local_drink),
              onPressed: () {},
            ),
            // IconButton(
            //   tooltip: 'Favorite',
            //   icon: const Icon(Icons.favorite),
            //   onPressed: () {},
            // ),
            //if (centerLocations.contains(fabLocation)) const Spacer(),
          ],
        ),
      ),
    );
  }
}
