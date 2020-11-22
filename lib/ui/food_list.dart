import 'package:demo7/model/Food.dart';
import 'package:flutter/material.dart';

class FoodList extends StatelessWidget {
  final List<Food> foods;

  FoodList({this.foods});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 300,
      child: buildColumnListTile(),
    );
  }

  ListView buildColumnListTile() {
    return ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: (index - 1) % 2 == 0 ? Colors.green : Colors.teal,
            child: ListTile(
              leading: Icon(Icons.fastfood_outlined),
              title: Text(
                '${foods[index].name}',
                style: _textTitleListTile,
              ),
              subtitle: Text(
                '${foods[index].price}',
                style: _textSubTitleListTile,
              ),
              onTap: () {},
            ),
          );
        });
  }

  var _textTitleListTile =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

  var _textSubTitleListTile = TextStyle(fontSize: 16, color: Colors.white);
}
