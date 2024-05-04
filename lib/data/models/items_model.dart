class ItemModel {
  int? itemsId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDesc;
  String? itemsDescAr;
  double? itemsPrice;
  int? itemsQty;
  int? isActive;
  int? discount;
  int? itemsSubcatId;
  int? brandId;
  int? subcatId;
  String? subcatName;
  String? subcatNameAr;
  String? subcatDesc;
  String? subcatDescAr;
  String? subcatImageUrl;
  int? catId;
  int? id;
  String? imageUrl;
  int? itemId;
  double? rating;
  int? brandsId;
  String? brandsName;
  double? priceAfterDiscount;
  bool? isFavorite;
  int? raters;
  int? cartAmount;

  ItemModel({
    this.itemsId,
    this.itemsName,
    this.itemsNameAr,
    this.itemsDesc,
    this.itemsDescAr,
    this.itemsPrice,
    this.itemsQty,
    this.isActive,
    this.discount,
    this.itemsSubcatId,
    this.brandId,
    this.subcatId,
    this.subcatName,
    this.subcatNameAr,
    this.subcatDesc,
    this.subcatDescAr,
    this.subcatImageUrl,
    this.catId,
    this.id,
    this.imageUrl,
    this.itemId,
    this.rating,
    this.brandsId,
    this.brandsName,
    this.priceAfterDiscount,
    this.isFavorite,
    this.raters,
    this.cartAmount,
  });

  ItemModel.fromJson(Map<String, dynamic> json) {
    itemsId = json['items_id'];
    itemsName = json['items_name'];
    itemsNameAr = json['items_name_ar'];
    itemsDesc = json['items_desc'];
    itemsDescAr = json['items_desc_ar'];
    // itemsPrice = json['items_price'].toDouble();
    itemsQty = json['items_qty'];
    isActive = json['isActive'];
    discount = json['discount'];
    itemsSubcatId = json['items_subcat_id'];
    brandId = json['brand_id'];
    subcatId = json['subcat_id'];
    subcatName = json['subcat_name'];
    subcatNameAr = json['subcat_name_ar'];
    subcatDesc = json['subcat_desc'];
    subcatDescAr = json['subcat_desc_ar'];
    subcatImageUrl = json['subcat_imageUrl'];
    catId = json['cat_id'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    itemId = json['item_id'];
    rating = double.tryParse(json['rating'].toString()) ?? 0;
    brandsId = json['brands_id'];
    brandsName = json['brands_name'];
    priceAfterDiscount = double.parse(json["priceAfterDiscount"].toString());
    isFavorite = json['favorite'] == 1;
    raters = json['raters'] ?? 0;
    cartAmount = json['cart_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items_id'] = this.itemsId;
    data['items_name'] = this.itemsName;
    data['items_name_ar'] = this.itemsNameAr;
    data['items_desc'] = this.itemsDesc;
    data['items_desc_ar'] = this.itemsDescAr;
    data['items_price'] = this.itemsPrice;
    data['items_qty'] = this.itemsQty;
    data['isActive'] = this.isActive;
    data['discount'] = this.discount;
    data['items_subcat_id'] = this.itemsSubcatId;
    data['brand_id'] = this.brandId;
    data['subcat_id'] = this.subcatId;
    data['subcat_name'] = this.subcatName;
    data['subcat_name_ar'] = this.subcatNameAr;
    data['subcat_desc'] = this.subcatDesc;
    data['subcat_desc_ar'] = this.subcatDescAr;
    data['subcat_imageUrl'] = this.subcatImageUrl;
    data['cat_id'] = this.catId;
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['item_id'] = this.itemId;
    data['rating'] = this.rating;
    data['brands_id'] = this.brandsId;
    data['brands_name'] = this.brandsName;
    data['priceAfterDiscount'] = this.priceAfterDiscount;
    data['favorite'] = isFavorite;
    data['rators'] = raters;
    data['cart_amount'] = cartAmount;

    return data;
  }
}
