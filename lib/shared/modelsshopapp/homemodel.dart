class HomeShopModel{
  bool ?status;
  HomeDataModel ?homeDataModel;
  HomeShopModel.fromJson(Map<String,dynamic> map){
    status=map['status'];
    homeDataModel=HomeDataModel.fromJson(map['data']);


  }

}
class HomeDataModel{

  late List<BaneerModel> banners=[];
  late List<ProductsModel> products=[];

  HomeDataModel.fromJson(Map<String,dynamic> map){
    map['banners'].forEach((element){
      banners.add(BaneerModel.fromJson(element));
    });
    map['products'].forEach((element){
      products.add(ProductsModel.fromJson(element));

    });

  }

}
class BaneerModel{
  int ?id;
  String ?image;

  BaneerModel.fromJson(Map<String,dynamic> map){
    id=map['id'];
    image=map['image'];

  }

}
class ProductsModel{

  int ?id;
  dynamic ?price;
  dynamic ?old_price;
  dynamic discount;
  String ?image;
  String ?name;
  bool ?in_favorite;
  bool ?in_cart;



  ProductsModel.fromJson(Map<String,dynamic> map){
    id=map['id'];
    price=map['price'];
    old_price=map['old_price'];
    discount=map['discount'];
    image=map['image'];
    name=map['name'];
    in_favorite=map['in_favorites'];
    in_cart=map['in_cart'];


  }


}