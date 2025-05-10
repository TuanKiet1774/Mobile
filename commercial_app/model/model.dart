//Lớp model
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tuankiet_64131060/commercial_app/helper/supabase_helper.dart';

class Fruit{
  int id;
  int? gia;
  String ten;
  String? moTa, anh;
  //tên phải giống trên cloud
  Fruit({
    required this.id,
    this.gia,
    required this.ten,
    this.moTa,
    this.anh
  });

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      // id: int.parse(json["id"]),
      // gia: int.parse(json["gia"]),
      id: json["id"],
      gia: json["gia"],
      ten: json["ten"],
      moTa: json["moTa"],
      anh: json["anh"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "gia": this.gia,
      "ten": this.ten,
      "moTa": this.moTa,
      "anh": this.anh,
    };
  }
}
//Đối với mỗi lớp model (CDSL) thì phải có lớp truy cập dữ liệu
//Lớp truy cập dư liệu
class FruitSnapshot {
  Fruit fruit;

  FruitSnapshot({required this.fruit});

  Future<dynamic> update(Fruit newFruit) async {
    final supabase = Supabase.instance.client;
    var data = await supabase.from("Fruit").update(newFruit.toJson()).eq(
        "id", fruit.id);
    return data;
  }

  static Future<void> delete(int id) async {
    //final supabase = Supabase.instance.client;
    await supabase.from("Fruit").delete().eq('id',id);
    await removeImage(bucket: "images", path: "fruits/fruit_${id}.jpg");
    return;
  }

  static Future<dynamic> insert(Fruit newFruit) async {
    final supabase = Supabase.instance.client;
    var data = await supabase.from('Fruit').insert(newFruit.toJson());
    return data;
  }

  static Future <List<Fruit>> getFruits() async {
    final supabase = Supabase.instance.client;
    List <Fruit> fruits = [];
    final data = await supabase.from('Fruit').select();
    fruits = data.map((e) => Fruit.fromJson(e),).toList();
    return fruits;
  }

  // static List<Fruit> getAll(){
  //   return data;
  // }

  static Stream <List<Fruit>> getFruitStream() {
    return getDataStream<Fruit>(
      table: "Fruit",
      ids: ["id"],
      fromJson: (json) => Fruit.fromJson(json),
    );
  }

  static listenFruitChange(Map<int, Fruit> maps, {Function()? updateUI}) {
    listenDataChange(maps,
      table: "Fruit",
      schema: "public",
      channel: "public:Fruit",
      fromJson: (json) => Fruit.fromJson(json),
      getID: (t) => t.id,
      updateUI: updateUI,
    );
  }
}
