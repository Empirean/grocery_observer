import 'package:flutter/material.dart';
import 'package:grocery_observer/models/item.dart';

class ItemsListTile extends StatelessWidget {
  const ItemsListTile({Key? key, required this.itemModel}) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Text(itemModel.name);
  }
}
