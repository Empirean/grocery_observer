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

  ItemModel.fromJson(Map<String, Object?> json) :
      this(
        name: json[fieldName] as String,
        amount: json[fieldAmount] as int,
        threshold: json[fieldThreshold] as int,
        uom: json[fieldUOM] as String
      );

  Map<String, Object?> toJson() {
    return {
      fieldName : name,
      fieldAmount : amount,
      fieldThreshold : threshold,
      fieldUOM : uom
    };
  }
}