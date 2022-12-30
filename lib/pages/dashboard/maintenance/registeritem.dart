import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:grocery_observer/models/item.dart';
import 'package:grocery_observer/services/database.dart';

import '../../../constants/paths.dart';
import '../../../shared/fields.dart';

class RegisterItem extends StatefulWidget {
  const RegisterItem({Key? key}) : super(key: key);

  @override
  _RegisterItemState createState() => _RegisterItemState();
}

class _RegisterItemState extends State<RegisterItem> {

  String _itemName = "";
  int _itemAmount = 0;
  int _itemThreshold = 0;

  final List<String> _unitsOfMeasure = ["LB", "KG", "PC", "ML", "L"];
  String _unitOfMeasure = "LB";

  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                maxLength: 30,
                validator: (val) {
                  return val != null && val.isNotEmpty  ? null : "Item name cannot be empty!";
                },
                controller: _nameController,
                decoration: fieldStyle.copyWith(
                    hintText: "item name",
                    labelText: "item name"
                ),
                onChanged: (val) {
                  _itemName = val;
                },
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SpinBox(
                      min: 0,
                      step: 1,
                      key: GlobalKey(),
                      value: _itemAmount.toDouble(),
                      decoration: fieldStyle.copyWith(
                          hintText: "item amount",
                          labelText: "item amount"
                      ),
                      onChanged: (val) {
                        _itemAmount = val.toInt();
                      },
                    ),
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(right:  10.0),
                    child: SizedBox(
                      height: kToolbarHeight * 1.06,
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black)
                        ),
                        child: Center(
                          child: DropdownButton(
                            isExpanded: true,
                            value: _unitOfMeasure,
                            items: _unitsOfMeasure.map((uom) {
                              return DropdownMenuItem(
                                value: uom,
                                child: Center(
                                  child: Text(uom,
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _unitOfMeasure = val.toString();
                              });

                            }
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SpinBox(
                min: 0,
                step: 1,
                key: GlobalKey(),
                value: _itemThreshold.toDouble(),
                decoration: fieldStyle.copyWith(
                    hintText: "low threshold",
                    labelText: "low threshold"
                ),
                onChanged: (val) {
                  _itemThreshold = val.toInt();
                },

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> data = {
                          ItemModel.fieldName : _itemName,
                          ItemModel.fieldAmount : _itemAmount,
                          ItemModel.fieldThreshold : _itemThreshold,
                          ItemModel.fieldUOM : _unitOfMeasure
                        };

                        await DatabaseService(path: Paths.items).addEntry(data);

                        final snackBar = SnackBar(
                          content: Text("$_itemName added"),
                          action: SnackBarAction(
                            label: "Ok",
                            onPressed: () {

                            },
                          ),
                        );

                        setState(() {



                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          _nameController.clear();
                          _itemName = "";
                          _itemAmount = 0;
                          _itemThreshold = 0;
                          _unitOfMeasure = _unitsOfMeasure[0];
                        });
                      }
                    },
                    child: const Text("Confirm")
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
