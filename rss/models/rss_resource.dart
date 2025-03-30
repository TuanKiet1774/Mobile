class RssResource{
  String id, name;
  String startImageRegrex, endImageRegrex;
  String startDescriptionRegrex, endDescriptionRegrex;
  Map<String, String> headers; //String đầu: tên header, String sau: url

  //Name argument constructor
  RssResource({
    required this.id,
    required this.name,
    required this.startImageRegrex,
    required this.endImageRegrex,
    required this.startDescriptionRegrex,
    required this.endDescriptionRegrex,
    required this.headers,
  });
}

List<RssResource> rssResources = [
  RssResource(
      id: "vnexpress", name: "VN Express",
      startImageRegrex: 'img src="', endImageRegrex: '"',
      startDescriptionRegrex: "</a></br>", endDescriptionRegrex: "",
      headers: {
        "Trang chủ" : "https://vnexpress.net/rss/tin-moi-nhat.rss",
        "Tin mới nhất" : "https://vnexpress.net/rss/tin-moi-nhat.rss",
        "Thế giới" : "https://vnexpress.net/rss/the-gioi.rss",
        "Thời sự" : "https://vnexpress.net/rss/thoi-su.rss",
        "Kinh doanh" : "https://vnexpress.net/rss/kinh-doanh.rss",
        "Tin nổi bật" : "https://vnexpress.net/rss/tin-noi-bat.rss"
      }
  ),

  RssResource(
      id: "tuoi_tre", name: "Tuổi Trẻ",
      startImageRegrex: 'img src="', endImageRegrex: '"',
      startDescriptionRegrex: "</a>", endDescriptionRegrex: "",
      headers: {
        "Trang chủ" : "https://tuoitre.vn/rss/tin-moi-nhat.rss",
        "Thế giới" : "https://tuoitre.vn/rss/the-gioi.rss",
        "Khoa học" : "https://tuoitre.vn/rss/the-gioi.rss",
        "Công nghệ" : "https://tuoitre.vn/rss/nhip-song-so.rss",
        "Giáo dục" : "https://tuoitre.vn/rss/giao-duc.rss"
      }
  )
];