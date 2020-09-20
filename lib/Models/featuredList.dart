class FProductList {
  List<PList> productlist;
  FProductList({this.productlist});

  List<PList> getProducts() {
    return this.productlist;
  }

  factory FProductList.fromJson(List<dynamic> json) {
    List<PList> productListt = json.map((i) => PList.fromJson(i)).toList();

    return FProductList(productlist: productListt);
  }
}

class PList {
  int id;
  String name;
  num price;
  int mainCategoryId;
  int categoryId;
  String primarySku;
  String secondarySku;
  num grossWeight; // int
  String designCode;
  num netWeight;
  num tagPrice;
  num pieces;
  String articleNecklace;
  num pearlWeight; //double
  num kundanStones;
  num carat;
  num diamondSet;
  num diamondWeight;
  num diamondPieces;
  num colorStoneWeight; //double
  String colorStonePieces;
  num polkiWeight; //double
  String polkiPieces;

  Image image;
  bool addedToWishList;
  List<Thumbnails> thumbnails;
  MainCategory mainCategory;
  MainCategory category;

  PList(
      {this.id,
      this.name,
      this.price,
      this.mainCategoryId,
      this.categoryId,
      this.primarySku,
      this.secondarySku,
      this.grossWeight,
      this.designCode,
      this.netWeight,
      this.tagPrice,
      this.pieces,
      this.articleNecklace,
      this.pearlWeight,
      this.kundanStones,
      this.carat,
      this.diamondSet,
      this.diamondWeight,
      this.diamondPieces,
      this.colorStoneWeight,
      this.colorStonePieces,
      this.polkiWeight,
      this.polkiPieces,
      this.image,
      this.addedToWishList,
      this.thumbnails,
      this.mainCategory,
      this.category});

  factory PList.fromJson(Map<String, dynamic> json) {
    Image image =
        json['image'] != null ? new Image.fromJson(json['image']) : null;
    var thumbNails = json["thumbnails"] as List;
    List<Thumbnails> thumbnails = thumbNails != null
        ? thumbNails.map((i) => Thumbnails.fromJson(i)).toList()
        : null;
    MainCategory mainCategory = json['main_category'] != null
        ? new MainCategory.fromJson(json['main_category'])
        : null;
    MainCategory category = json['category'] != null
        ? new MainCategory.fromJson(json['category'])
        : null;

    return PList(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        mainCategoryId: json['main_category_id'],
        categoryId: json['category_id'],
        primarySku: json['primary_sku'],
        secondarySku: json['secondary_sku'],
        grossWeight: json['gross_weight'],
        designCode: json['design_code'],
        netWeight: json['net_weight'],
        tagPrice: json['tag_price'],
        pieces: json['pieces'],
        articleNecklace: json['article_necklace'],
        pearlWeight: json['pearl_weight'],
        kundanStones: json['kundan_stones'],
        carat: json['carat'],
        diamondSet: json['diamond_set'],
        diamondWeight: json['diamond_weight'],
        diamondPieces: json['diamond_pieces'],
        colorStoneWeight: json['color_stone_weight'],
        colorStonePieces: json['color_stone_pieces'],
        polkiWeight: json['polki_weight'],
        polkiPieces: json['polki_pieces'],
        image: image,
        addedToWishList: json['addedToWishList'],
        thumbnails: thumbnails,
        mainCategory: mainCategory,
        category: category);
  }
}

class Image {
  String url;

  Image({this.url});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }
}

class Thumbnails {
  String url;

  Thumbnails({this.url});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }
}

class MainCategory {
  int id;
  String name;

  MainCategory({this.id, this.name});

  MainCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
