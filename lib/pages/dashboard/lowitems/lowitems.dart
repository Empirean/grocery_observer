import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_observer/services/extensions.dart';

import '../../../constants/paths.dart';
import '../../../models/item.dart';
import '../../../services/database.dart';
import '../../../shared/listTileShopping.dart';
import '../../../shared/sharedDecoration.dart';

class LowItems extends StatefulWidget {
  const LowItems({Key? key}) : super(key: key);

  @override
  _LowItemsState createState() => _LowItemsState();
}

class _LowItemsState extends State<LowItems> {

  String _itemName = "";

  final _nameController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Form(
            key: _globalKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _nameController,
                decoration: fieldStyle.copyWith(
                    hintText: "search",
                    labelText: "search",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _itemName = "";
                            _nameController.clear();
                          });
                        },
                        icon: _itemName.isNotEmpty ? const Icon(Icons.cancel_outlined) : Container()
                    )
                ),
                onChanged: (val) {
                  setState(() {
                    _itemName = val;
                  });
                },
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot<ItemModel>>(
              stream: DatabaseService(path: Paths.items).getItemModelReference().
              queryBy(ItemQueryModes.low, queryText: _itemName).snapshots(),
              builder: (context, itemList) {
                if (itemList.hasData) {

                  final data = itemList.requireData;

                  if (data.size > 0) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.size,
                        itemBuilder: (context, index) {
                          return ShoppingListTile(
                            itemModel: ItemModel(
                                name: data.docs[index][ItemModel.fieldName],
                                amount: data.docs[index][ItemModel.fieldAmount],
                                threshold: data.docs[index][ItemModel.fieldThreshold],
                                uom: data.docs[index][ItemModel.fieldUOM]
                            ),
                            id: data.docs[index].id,
                          );
                        }
                    );
                  }
                  else{
                    return const Center(
                      child: Text("No Items Found"),
                    );
                  }
                }
                else{
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
