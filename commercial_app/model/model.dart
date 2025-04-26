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
    await removeImage(bucket: "images", path: "images/fruit_${id}.jpg");
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

  // static Future<Map<int, Fruit>> getMapFruit() async{
  //   final supabase = Supabase.instance.client;
  //   final data = await supabase.from("Fruit").select();
  //   var iterable = data.map((e) => Fruit.fromJson(e),);
  //   Map<int, Fruit> _maps = Map.fromIterable(iterable, key: (fruit) =>
  //   fruit.id, value: (fruit) => fruit,);
  //   return _maps;
  // }
  // static listenFruitChange(Map<int, Fruit> maps, {Function()? updateUI} ){
  //   final supabase = Supabase.instance.client;
  //   supabase
  //       .channel('public:Fruit') //cái này là ID channel, ghi gì cũng đc
  //       .onPostgresChanges(
  //       event: PostgresChangeEvent.all, //lắng nghe tất cả
  //       schema: 'public',
  //       table: 'Fruit',
  //       callback: (payload) {
  //         print('Change received: ${payload.toString()}');
  //         switch(payload.eventType){
  //           case PostgresChangeEvent.update :{
  //             Fruit f = Fruit.fromJson(payload.newRecord);
  //             maps[f.id] = f;
  //             updateUI?.call();
  //             break;
  //           }
  //         // case "UPDATE":{
  //         //   Fruit f = Fruit.fromJson(payload.newRecord);
  //         //   maps[f.id] = f;
  //         //   updateUI?.call();
  //         // }
  //           case PostgresChangeEvent.insert :{
  //             Fruit f = Fruit.fromJson(payload.newRecord);
  //             maps[f.id] = f;
  //             updateUI?.call();
  //             break;
  //           }
  //           case PostgresChangeEvent.delete :{
  //             maps.remove(payload.oldRecord["id"]);
  //             updateUI?.call();
  //             break;
  //           }
  //           default: {}
  //         }
  //       })
  //       .subscribe();
  // }
}



final data = <Fruit>[
  Fruit(id: 1, ten: "Chuối", gia: 40000, moTa: "Dr Code Fruit", anh: "https://citifruit.com/uploads/images/Products/60/Chuoi-Su-800%C3%97800.jpg"),
  Fruit(id: 2, ten: "Cam", gia: 40000, moTa: "Dr Code Fruit", anh: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSyF4NUSpFXdv2ilvToadmLEFxsA4cEDNpow&s"),
  Fruit(id: 3, ten: "Táo", gia: 40000, moTa: "Dr Code Fruit", anh: "https://www.buildrestfoods.com/wp-content/uploads/2020/08/green-apply.jpg"),
  Fruit(id: 4, ten: "Xoài", gia: 40000, moTa: "Dr Code Fruit", anh: "https://product.hstatic.net/1000141988/product/xoai_tu_quy_loai_1_d9531d519b6d4fee8ca1e3886d909441.jpg"),
  Fruit(id: 5, ten: "Dưa hấu", gia: 40000, moTa: "Dr Code Fruit", anh: "https://chobonmua.com/wp-content/uploads/2025/01/kiotviet_db7f0c8c780e0825169c401fa5152a05.jpg"),
  Fruit(id: 6, ten: "Thanh long", gia: 40000, moTa: "Dr Code Fruit", anh: "https://t4.ftcdn.net/jpg/09/24/63/21/360_F_924632130_1f7J0QmCPkB3QpueYjdFE3rTHyFm89xl.jpg"),
  Fruit(id: 7, ten: "Bưởi", gia: 40000, moTa: "Dr Code Fruit", anh: "https://product.hstatic.net/1000141988/product/xoai_tu_quy_loai_1_d9531d519b6d4fee8ca1e3886d909441.jpg"),
  Fruit(id: 8, ten: "Kiwi", gia: 40000, moTa: "Dr Code Fruit", anh: "https://binhdienonline.com/thumbs_size/product/2021_04/kiwi-xanh/[550x550-cr]kiwi-xanh--54.jpg"),
  Fruit(id: 9, ten: "Khế", gia: 40000, moTa: "Dr Code Fruit", anh: "https://binhdienonline.com/thumbs_size/product/2021_04/khe-chin/[550x550-cr]khe-chin-1.jpg"),
  Fruit(id: 10, ten: "Chanh dây", gia: 40000, moTa: "Dr Code Fruit", anh: "https://cdn.tgdd.vn/2022/07/CookDishThumb/chanh-day-la-gi-cac-loai-chanh-day-gia-bao-nhieu-1kg-va-lam-thumb-620x620-1.jpg"),
];