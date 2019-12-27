

import 'package:pdb/models/news.dart';
import 'package:pdb/models/reform_topic.dart';
import 'package:pdb/services/doing_business_api.dart';

import 'base_model.dart';

class HomeModel extends BaseModel{
  final DoingBusinessApi _api = DoingBusinessApi();

  List<ReformTopic> _reformTopic = [
    ReformTopic(id: 1,name: 'STARTING A BUSINESS',slug: 'pres-sab',reformLogo: 'startingbusiness.png'),
    ReformTopic(id: 2,name: 'DEALING WITH CONSTRUCTION PERMITS',slug: 'pres-cp',reformLogo: 'constructionpermits.png'),
    ReformTopic(id: 3,name: 'GETTING ELECTRICITY',slug: 'pres-ge',reformLogo: 'gettingelectricity.png'),
    ReformTopic(id: 4,name: 'REGISTERING A PROPERTY',slug: 'pres-rp',reformLogo: 'registeringproperty.png'),
    ReformTopic(id: 5,name: 'GETTING CREDIT',slug: 'getting_credit',reformLogo: 'gettingcredit.png'),
    ReformTopic(id: 6,name: 'PROTECTING MINORITY INVESTMENT',slug: 'pres-pmi',reformLogo: 'protectingminorityinvestment.png'),
    ReformTopic(id: 7,name: 'PAYING TAXES',slug: 'pres-pt',reformLogo: 'payingtaxes.png'),
    ReformTopic(id: 8,name: 'TRADING ACROSS BORDERS',slug: 'pres-tab',reformLogo: 'tradingacrossborders.png'),
    ReformTopic(id: 9,name: 'ENFORCING CONTRACTS',slug: 'pres-ec',reformLogo: 'enforcingcontracts.png'),
    ReformTopic(id: 10,name: 'RESOLVING INSOLVENCY',slug: 'pres-ri',reformLogo: 'resolvinginsolvency.png'),
  ];
  List<ReformTopic> get reformTopics{
    return [..._reformTopic];
  }

  List<News> _news = [];

  List<News> get news{
    return [..._news];
  }

  void getNews() async {
    try{
      setBusy(true);
      _news = await _api.fetchLatestNews();
      setBusy(false);
    }catch(err){
      setMessage(err.toString());
      setBusy(false);
    }
  }
}