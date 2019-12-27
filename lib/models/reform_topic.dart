class ReformTopic{
  final int id;
  final String name;
  final String slug;
  final String reformLogo;
  ReformTopic({this.id,this.name,this.slug,this.reformLogo});

  factory ReformTopic.fromJson(Map<String, dynamic> json) {

    return ReformTopic(
      id: json['Id'] as int,
      name:json['Name'] as String,
    );
  }
}