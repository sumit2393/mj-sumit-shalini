class Item {
  List data;

  Item({this.data});

  factory Item.fromJson(List<dynamic> json) {
    List<MainCategories> main =
        json.map((i) => MainCategories.fromJson(i)).toList();
    return Item(data: main);
    //return Item;
  }
  List getData() {
    return this.data;
  }
}

class MainCategories {
  int id;
  String name;
  String imageUrl;
  //Null createdAt;
 // Null updatedAt;

  MainCategories(
      {this.id, this.name, this.imageUrl});

  MainCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
   // createdAt = json['created_at'];
   // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
  //  data['created_at'] = this.createdAt;
  //  data['updated_at'] = this.updatedAt;
    return data;
  }
}

//   class for banners //

class BannerItem {
  List<Upcomingtrends> upcomingDesigns;
  List<Testimonial> testimonial;

  BannerItem({this.upcomingDesigns, this.testimonial});

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    var upcomingDesigns = json['upcomingDesigns'] as List;
    List<Upcomingtrends> upcomingtrend = upcomingDesigns != null
        ? upcomingDesigns.map((i) => Upcomingtrends.fromJson(i)).toList()
        : null;
    var testimonial = json['testimonial'] as List;
    List<Testimonial> testimonia = testimonial != null
        ? testimonial.map((i) => Testimonial.fromJson(i)).toList()
        : null;

    return BannerItem(testimonial: testimonia, upcomingDesigns: upcomingtrend);
  }
}

class Upcomingtrends {
  String image_path;

  Upcomingtrends({this.image_path});

  Upcomingtrends.fromJson(Map<String, dynamic> json) {
    image_path = json['image_path'];
  }
}

class Testimonial {
  String image_path;
  String caption;
  String name;


  Testimonial({this.image_path, this.caption,this.name});

  Testimonial.fromJson(Map<String, dynamic> json) {
    image_path = json['image_path'];
    caption = json["caption"];
    name=json["name"];


  }
}
////   @@@@@@   class for featured products @@@@@@@@@  ///
class FeaturedProduct {}
