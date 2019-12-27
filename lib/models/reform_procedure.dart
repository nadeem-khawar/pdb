class ReformProcedureArea{
  final String area;
  final List<ReformProcedure> procedures;
  ReformProcedureArea({this.area,this.procedures});
}

class ReformProcedure{

  final String stepDescription;
  final String agency;
  final String processingTime;
  final String cost;

  ReformProcedure(this.stepDescription,this.agency,this.processingTime,this.cost);

  factory ReformProcedure.fromJson(Map<String, dynamic> json) {
    return ReformProcedure(
      json[''] as String,
      json[''] as String,
      json[''] as String,
      json[''] as String,
    );
  }
}