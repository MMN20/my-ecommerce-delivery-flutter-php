class Specification {
  int? specID;
  String? specName;
  String? specValue;
  int? itemID;

  Specification({this.itemID, this.specID, this.specName, this.specValue});

  Specification.fromJson(Map json) {
    specID = json['specifications_id'];
    specName = json['specifications_name'];
    specValue = json['specifications_value'];
    itemID = json['item_id'];
  }
}
