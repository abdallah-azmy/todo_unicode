class TodoField {
  static const createdTime = 'createdTime';
}

class TodoModel {
  DateTime? createdTime;
  String? title;
  String? id;
  String? description;
  bool? isDone;

  TodoModel(
      {this.createdTime, this.title, this.id, this.description, this.isDone});

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
        createdTime: map['createdTime']!.toDate(),
        title: map['title'],
        id: map['id'],
        description: map['description'],
        isDone: map['isDone'],
      );

  Map<String, dynamic> toMap(TodoModel user) => {
        'createdTime': user.createdTime,
        'title': user.title,
        'id': user.id,
        'description': user.description,
        'isDone': user.isDone,
      };
}
