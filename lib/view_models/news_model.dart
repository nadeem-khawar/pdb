

import 'package:pdb/models/news.dart';
import 'package:pdb/services/doing_business_api.dart';
import 'package:pdb/view_models/base_model.dart';

class NewsModel extends BaseModel{
  final DoingBusinessApi _api = DoingBusinessApi();

  List<News> _news = [];

  List<News> get news{
    return [..._news];
  }
  Future getNews(String slug) async {
    setBusy(true);
    _news = await _api.fetchNews(slug);
    setBusy(false);
  }
}