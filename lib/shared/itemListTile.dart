import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grocery_observer/services/database.dart';

import '../constants/paths.dart';
import '../models/item.dart';

class ItemListTile extends StatefulWidget {
  const ItemListTile({Key? key, required this.itemModel, required this.id}) : super(key: key);

  final String id;
  final ItemModel itemModel;

  @override
  _ItemListTileState createState() => _ItemListTileState();
}

class _ItemListTileState extends State<ItemListTile> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      child: Slidable(
        key: GlobalKey(),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
                label: "Update",
                icon: Icons.create_rounded,
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).canvasColor,
                onPressed: (val) {

                },
            ),
            SlidableAction(
                label: "Delete",
                icon: Icons.delete,
                backgroundColor: Theme.of(context).canvasColor,
                foregroundColor: Theme.of(context).primaryColor,
                onPressed: (val) async {
                  await DatabaseService(path: Paths.items).deleteEntry(widget.id);
                }
            )
          ],
        ),
        child: ListTile(
          tileColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(widget.itemModel.name,
            style: TextStyle(
              color: Theme.of(context).canvasColor
            ),
          ),
        ),
      ),
    );
  }
}

