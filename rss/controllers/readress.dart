import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tuankiet_64131060/rss/models/rss_item.dart';
import 'package:tuankiet_64131060/rss/models/rss_resource.dart';

import 'package:xml2json/xml2json.dart';

void main() async{
  var url = "https://vnexpress.net/rss/tin-moi-nhat.rss";
  var response = await http.get(Uri.parse(url));
  if(response.statusCode == 200){
    Xml2Json xml2json = Xml2Json();
    xml2json.parse(utf8.decode(response.bodyBytes));
    String jsonStr = xml2json.toParker();
    //print(jsonStr);
    var data = json.decode(jsonStr)["rss"]["channel"]["item"][0]; //decode: chuyen thanh json
    //print(data);
    var item = RssItem.empty().fromJson(data, rssResources[0]);
    print(item.title);
    print(item.link);
    print(item.pubDate);
    print(item.imageUrl);
    print(item.description);
  }
}