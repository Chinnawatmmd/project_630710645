import 'dart:convert';
import 'dart:io';

class Set{
  String? name;
  String? description;
  List<Item> card=[];
  Set({this.name});
  Set.withDesc({this.name, this.description});
  Set.fromJson(Map<String, dynamic> json){
    name = json["name"];
    if(json["description"]!=null) description = json["description"];
    if(json["card"]!=null) card = json["card"];
  }
  void addDesc(String desc){
    description = desc;
  }
  void addItem(Item item){
    card.add(item);
  }
  void removeItem(int index){
    card.removeAt(index);
  }
  // Future<dynamic> fetchSet(File file) async {
  //   String content = await file.readAsString();
  //   var jsonResponse = jsonDecode(content);
  //   print(jsonResponse);
  // }
}
class Item{
  String? term;
  String? definition;
  Item({this.term, this.definition});
  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      term: json["term"],
      definition: json["definition"],
    );
  }
  Item copyWith({required String term, required String definition}){
    return Item(
      term: term,
      definition: definition,
    );
  }
}
class Data{
  String? data;
  Set? set;
  Data({this.data});
  Data.withSet({this.data, this.set});
}