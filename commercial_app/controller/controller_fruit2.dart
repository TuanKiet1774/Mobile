//Controller dùng để quản lý CSDL
import 'package:get/get.dart';
import 'package:tuankiet_64131060/commercial_app/model/model.dart';

class ControllerFruit extends GetxController{
  //var fruit = <Fruit>[];
  Map<int, Fruit> _maps = {};
  var gh = <GH_Item>[];
  //static truy cập thông tin qua lớp
  static ControllerFruit get() => Get.find();

  Iterable<Fruit> get fruits => _maps.values;

  //Số lượng mặt hàng
  int get sLMHGH => gh.length;
  //Phương thức vòng đời
  //onInit: Quá trình khởi tạo
  //onReady: Sẵn sàng sử dụng, đọc dữ liệu
  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    //Đọc dữ liệu từ model
    // fruit = FruitSnapshot.getAll();
    // //Cập nhật lên màn hình
    // update(["Fruits"]);
    //Đọc dữ liệu từ supabase
    // _docDL();
    //Đọc ữ liệu từ supabase cập nhật realtime
    //_maps = await FruitSnapshot.getMapFruit();
    update(["Fruits"]);
    //FruitSnapshot.listenFruitChange(_maps, updateUI: () => this.update(["Fruits"]),);
  }

  // _docDL() async{
  //   fruit = await FruitSnapshot.getFruits();
  //   update(["Fruits"]); //update(["Đặt trùng với id trong body"]);
  // }

  //Thêm mặt hàng
  themMHGH(Fruit f){
    for(var item in gh){
      if(item.fruit.id == f.id) {
        item.sl++;
        return;
      }
    }
    gh.add(GH_Item(fruit: f, sl: 1));
    update(["gh"]);
  }
}


//Mỗi lớp phỉa có Binding
class BindingAppFruitStore extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => ControllerFruit(),);
  }
}

class GH_Item{
  Fruit fruit;
  int sl;

  GH_Item({required this.fruit,required this.sl});
}
