class CategoriesModel{
  bool ?status;
  CategoriesData ?data;
  CategoriesModel.fromJsom(Map<String,dynamic> map){
    status=map['status'];
    data=CategoriesData.fromJson(map['data']);
  }

}
class CategoriesData{
  int ?current_page;
  List<dataModel> data=[];
  CategoriesData.fromJson(Map<String,dynamic> map){
    current_page=map['current_page'];
    map['data'].forEach((element){
      data.add(dataModel.fromJsom(element));
    });

  }
}
class dataModel{
  int ?id;
  String ?name;
  String ?image;
  dataModel.fromJsom(Map<String,dynamic> map){
    id=map['id'];
    name=map['name'];
    image=map['image'];
  }


}
