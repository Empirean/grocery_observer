import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_observer/models/item.dart';
import 'package:grocery_observer/services/database.dart';
import 'package:grocery_observer/shared/itemlisttile.dart';
import '../../../constants/paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoveItem extends StatefulWidget {
  const RemoveItem({Key? key}) : super(key: key);

  @override
  _RemoveItemState createState() => _RemoveItemState();
}

class _RemoveItemState extends State<RemoveItem> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot<ItemModel>>(
      stream: DatabaseService(path: Paths.items).getItemModelReference().snapshots(),
      builder: (context, itemList) {
        if (itemList.hasData) {

          final data = itemList.requireData;

          return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                return ItemsListTile(itemModel: ItemModel(
                      name: data.docs[index][ItemModel.fieldName]
                ));
              }
          );
        }
        else{
          return Container();
        }
    });
  }
}
