class TaskDTO {
  int id;
  String name;
  String description;
  int workTime;
  int breakTime;
  int goal;
  int total;

  String toString() {
    return 'Name: $name, Description: $description, Work Time: $workTime, '
        'Break Time: $breakTime, Goal: $goal, Total: $total';
  }
}