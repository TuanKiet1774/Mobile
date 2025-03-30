import 'package:tuankiet_64131060/rss/models/rss_resource.dart';

class RssItem{
  late String title, link, pubDate;
  String? imageUrl, description;

  // Named Constructor
  RssItem.empty();

  RssItem fromJson(Map<String, dynamic> map, RssResource resource){
    this.title = map["title"];
    this.link = map["link"];
    this.pubDate = map["pubDate"];
    this.imageUrl = getImageUrl(map["description"], resource);
    this.description = getDescription(map["description"], resource);
    return this;
  }
}

String? getImageUrl(String rawDescription, RssResource resource){
  String startRegrex = resource.startImageRegrex;
  String endRegrex = resource.endImageRegrex;
  int start = rawDescription.indexOf(startRegrex) + startRegrex.length; // trả về vị trí bắt đầu chữ i (img src =") + độ dài của img src =
  if (start >= startRegrex.length){
    if (endRegrex.length > 0){
      int end = rawDescription.indexOf(endRegrex, start);
      return rawDescription.substring(start, end);
    }
    return rawDescription.substring(start);
  }
  return null;
}

String? getDescription(String rawDescription, RssResource resource){
  String startRegrex = resource.startDescriptionRegrex;
  String endRegrex = resource.endDescriptionRegrex;
  int start = rawDescription.indexOf(startRegrex) + startRegrex.length; // trả về vị trí bắt đầu chữ i (img src =") + độ dài của img src =
  if (start >= startRegrex.length){
    if (endRegrex.length > 0){
      int end = rawDescription.indexOf(endRegrex, start);
      return rawDescription.substring(start, end);
    }
    return rawDescription.substring(start);
  }
  return null;
}