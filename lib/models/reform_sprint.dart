
class ReformSprint{
  final String sprintNo;
  final int totalItems;
  final int completed;
  final int inProgress;
  final int delayed;
  ReformSprint(this.sprintNo,this.totalItems,this.completed,this.inProgress,this.delayed);

  factory ReformSprint.empty(){
    return ReformSprint(
      'Loading...',
      0,0,0,0,
    );
  }
}