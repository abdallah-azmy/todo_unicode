import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_unicode/widget/todo_form_widget.dart';

import '../model/todo.dart';
import '../provider/todo_provider.dart';

class AddTodoDialogWidget extends StatelessWidget {
  AddTodoDialogWidget({Key? key, required this.edit, required this.todoModel})
      : super(key: key);
  late final bool edit;
  late final TodoModel todoModel;

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Todo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            Consumer<ControlTodo>(
              builder: (context, provider, __) {
                return TodoFormWidget(
                  onChangedTitle: (title) => todoModel.title = title,
                  onChangedDescription: (description) =>
                      todoModel.description = description,
                  title: todoModel.title,
                  description: todoModel.description,
                  onSavedTodo: () async {
                    edit == true
                        ? await provider.todoEdit(todoModel)
                        : await provider.addTodo(
                            todoModel,
                          );
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
      );
}
