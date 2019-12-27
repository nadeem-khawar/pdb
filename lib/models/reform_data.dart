class ReformData{
  final int totalReforms;
  final int completed;
  final int inProgress;
  final int delayed;

  ReformData(this.totalReforms,this.completed,this.inProgress,this.delayed);
}

class ReformDataCategory extends ReformData{
  final String name;

  ReformDataCategory(this.name,totalReforms,completed,inProgress,delayed):super(totalReforms,completed,inProgress,delayed);
}

class ReformStatistic{
  ReformData reformData = ReformData(0,0,0,0);
  final List<ReformDataCategory> areaReformData;
  final List<ReformDataCategory> agencyReformData;

  ReformStatistic(this.reformData,this.areaReformData,this.agencyReformData);
}