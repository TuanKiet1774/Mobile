//Controller dùng để quản lý CSDL
import 'package:get/get.dart';
import 'package:tuankiet_64131060/commercial_app/model/model.dart';

class ControllerFruit extends GetxController{
    var fruit = <Fruit>[];
    //Giỏ hàng có danh sách các Item, mỗi Item là một mặt hàng và số lượng
    var gh = <GH_Item>[];
    //static truy cập thông tin qua lớp
    static ControllerFruit get() => Get.find();
    //Số lượng mặt hàng
    int get sLMHGH => gh.length;
    //Phương thức vòng đời
    //onInit: Quá trình khởi tạo
    //onReady: Sẵn sàng sử dụng, đọc dữ liệu
    @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    //Đọc dữ liệu
    // fruit = FruitSnapshot.getAll();
    // //Cập nhật lên màn hình
    // update(["Fruits"]);
    _docDL();
  }

  _docDL() async{
      fruit = await FruitSnapshot.getFruits();
      update(["Fruits"]);
  }

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

    void auth(){
      update(["drawer_header"]);
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