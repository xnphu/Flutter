class ImageList {
  final int albumId;
  final int id;
  final String title;
  final String url;

  ImageList({this.albumId, this.id, this.title, this.url});

  ImageList.fromJson(Map<String, dynamic> json)
      : albumId= json['albumId'],
        id = json['id'],
        title = json['title'],
        url = json['url'];

  Map<String, dynamic> toJson() =>
      {
        'albumId': albumId,
        'id': id,
        'title': title,
        'url': url,
      };
}