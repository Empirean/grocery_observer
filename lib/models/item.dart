import 'package:grocery_observer/services/database.dart';

class ItemModel{

  final String name;
  final int amount;
  final int threshold;
  final List<String> tags;
  final String uom;

  ItemModel({this.name="", this.amount=0, this.threshold=0, this.tags= const [""], this.uom=""});

  static const String fieldName = "NAME";
  static const String fieldAmount = "AMOUNT";
  static const String fieldThreshold = "THRESHOLD";
  static const String fieldTag = "TAGS";
  static const String fieldUOM = "UOM";
}