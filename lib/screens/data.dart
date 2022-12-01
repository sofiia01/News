class SourceObject {
  final String name;
  final String URL;
  final String type;

  SourceObject({
    required this.name,
    required this.URL,
    required this.type,
  });
}

class Article {
  final String imgURL;
  final String title;
  final String content;
  final String source;

  Article({
    required this.imgURL,
    required this.title,
    required this.content,
    required this.source,
  });
}
