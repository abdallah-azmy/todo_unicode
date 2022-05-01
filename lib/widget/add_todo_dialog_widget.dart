import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_unicode/widget/todo_form_widget.dart';

import '../model/todo.dart';
import '../provider/todo_provider.dart';

class AddTodoDialogWidget extends StatelessWidget {
  const AddTodoDialogWidget({Key? key, this.edit, this.id,this.title,this.description}) : super(key: key);
  final bool? edit;
  final String? id;
  final String? title;
  final String? description;



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
                final List<TodoModel> todos =
                    context.watch<TodosProvider>().todos;
                return TodoFormWidget(
                  onChangedTitle: (title) => provider.title = title,
                  onChangedDescription: (description) =>
                      provider.description = description,
                  title: title!,
                  description: description!,
                  onSavedTodo: () async {
                    edit == true
                        ? await provider.todoEdit(id: id)
                        : await provider.addTodo(
                            id: "${todos.isEmpty ? 0 : int.parse(todos.last.id!) + 1}");
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
      );
}
