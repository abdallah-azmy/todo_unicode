class TodoField {
  static const createdTime = 'createdTime';
}

class TodoModel {
  late DateTime createdTime;
  late String title;
  late String id;
  late String description;
  late bool isDone;

  TodoModel(
      {required this.createdTime,
      required this.title,
      required this.id,
      required this.description,
      required this.isDone});

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
        createdTime: map['createdTime']!.toDate(),
        title: map['title'],
        id: map['id'],
        description: map['description'],
        isDone: map['isDone'],
      );

  Map<String, dynamic> toMap() => {
        'createdTime': createdTime,
        'title': title,
        'id': id,
        'description': description,
        'isDone': isDone,
      };
}
