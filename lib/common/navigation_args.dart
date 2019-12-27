class ReformArgs{
  final int reformTopicId;
  ReformArgs(this.reformTopicId);
}

class FeedbackArgs{
  final String subject;
  FeedbackArgs(this.subject);
}

class DocumentArgs{
  final String pdfPath;
  DocumentArgs(this.pdfPath);
}

class NewsArgs{
  final String slug;
  final String title;
  NewsArgs({this.slug,this.title});
}

class ReformTopicArguments {
  final int reformTopicId;
  final String reformTopicName;
  final String slug;
  final String logo;
  ReformTopicArguments({this.reformTopicId,this.reformTopicName,this.slug,this.logo});
}

class ReformSprintStatisticsArguments {
  final int sprintNo;

  ReformSprintStatisticsArguments({this.sprintNo});
}