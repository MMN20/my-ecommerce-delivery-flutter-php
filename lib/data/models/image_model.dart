class ImageModel {
  int? id;
  String? imageURL;
  int? itemID;

  ImageModel({
    this.id,
    this.imageURL,
    this.itemID,
  });

  ImageModel.fromJson(Map json) {
    id = json['id'];
    imageURL = json['imageUrl'];
    itemID = json['item_id'];
  }
}
