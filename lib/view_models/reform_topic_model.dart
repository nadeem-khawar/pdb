

import 'package:pdb/models/news.dart';
import 'package:pdb/models/reform_data.dart';

import 'package:pdb/services/doing_business_api.dart';
import 'package:pdb/view_models/base_model.dart';

class ReformTopicModel extends BaseModel{
  DoingBusinessApi _api = DoingBusinessApi();

  ReformStatistic _reformStatistic = ReformStatistic(ReformData(0,0,0,0),null,null);

  ReformStatistic get reformStatistics{
    return _reformStatistic;
  }

  Map<String,List<News>> _files;
  Map<String,List<News>> get files{
    return _files;
  }


  List<News> _presentations = [];
  List<News> get presentations{
    return [..._presentations];
  }

  List<News> _lawsRegulations = [];
  List<News> get lawsRegulations{
    return [..._lawsRegulations];
  }

  Future getReformStatisticsByIndicator(int id,String slug,String reformName) async{
    setBusy(true);
    _reformStatistic = await _api.fetchReformTopicStatistics(id);
    _presentations = await _api.fetchNews(slug);
    _lawsRegulations = await _api.fetchLawsRegulations(reformName);
    _files = Map<String,List<News>>();
    _files.putIfAbsent('PRESENTATIONS',()=>_presentations );
    _files.putIfAbsent('LAWS, NOTIFICATIONS & REGULATIONS',()=>_lawsRegulations );
    setBusy(false);
  }
}