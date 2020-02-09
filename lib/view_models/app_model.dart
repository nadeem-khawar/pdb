

import 'package:pdb/view_models/base_model.dart';

class AppModel extends BaseModel{
  Map<String, dynamic> appConfig;
  bool isLoading = true;
  String message;
  bool darkTheme = false;
  bool isInit = false;

}