import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tuankiet_64131060/rss/models/rss_item.dart';
import 'package:tuankiet_64131060/rss/models/rss_resource.dart';
import 'package:xml2json/xml2json.dart';

class RssController extends GetxController{
  late RssResource currentResource;
  late String currentUrl;
  late List<String> headers;
  late String currentHeader;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    currentResource = rssResources[0];
    currentUrl = currentResource.headers.values.toList()[0];
    headers = currentResource.headers.keys.toList();
    currentHeader = headers[0];
  }

  refresh(){
    update(["rss"]);
  }
  changeHeader(String? value){
    if (value != null)
      if (value != currentHeader){
        currentHeader = value;
        update(["header"]);
        currentUrl = currentResource.headers[currentHeader]!;
        update(["rss"]);
      }
  }

  Future<List<RssItem>> readRss() async{
    var response = await http.get(Uri.parse(currentUrl));
    if(response.statusCode == 200) {
      Xml2Json xml2json = Xml2Json();
      xml2json.parse(utf8.decode(response.bodyBytes));
      String jsonStr = xml2json.toParker();
      //print(jsonStr);
      var data = json.decode(jsonStr)["rss"]["channel"]["item"] as List;
      return data.map(
        (e) => RssItem.empty().fromJson(e, currentResource),
      ).toList();
    }
    return Future.error("Lỗi đọc rss");
  }
}