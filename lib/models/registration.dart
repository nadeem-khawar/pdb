
class Registration{
  final String heading;
  final List<LinkItem> linkItems;

  Registration(this.heading,this.linkItems);

  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      json[''] as String,
      json[''] as List<LinkItem>,
    );
  }
}

class LinkItem  {
  final String text;
  final String link;

  LinkItem(this.text, this.link);

  factory LinkItem.fromJson(Map<String, dynamic> json) {
    return LinkItem(
      json[''] as String,
      json[''] as String,
    );
  }
}