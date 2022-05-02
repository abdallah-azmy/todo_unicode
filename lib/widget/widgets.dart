import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../model/todo.dart';
import '../provider/todo_provider.dart';
import 'add_todo_dialog_widget.dart';

class RepeatedWidgets {
  RepeatedWidgets._();

  static Widget todoWidget(
      {required BuildContext context, required TodoModel todoModel}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: Key(todoModel.id),

        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            ControlTodo().todoDelete(id: todoModel.id);
          }),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                ControlTodo().todoDelete(id: todoModel.id);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) {
                showDialog(
                    context: context,
                    builder: (context) => AddTodoDialogWidget(
                          edit: true,
                          todoModel: todoModel,
                        ),
                    barrierDismissible: true);
              },
              backgroundColor: const Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),

        child: buildTodo(context: context, todo: todoModel),
      ),
    );
  }

  static Widget buildTodo(
          {required BuildContext context, required TodoModel todo}) =>
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Consumer<ControlTodo>(
              builder: (_, provider, __) {
                return Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Colors.white,
                  value: todo.isDone,
                  onChanged: (v) {
                    provider.todoComplete(id: todo.id, value: v!);
                  },
                );
              },
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      todo.description,
                      style: const TextStyle(fontSize: 20, height: 1.5),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  static Widget todos({required BuildContext context, required bool complete}) {
    final List<TodoModel> todos = complete == true
        ? context.watch<TodosProvider>().complete
        : context.watch<TodosProvider>().todos;
    return todos.isEmpty
        ? const Center(
            child: Text(
              'No todos.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return RepeatedWidgets.todoWidget(
                  context: context, todoModel: todo);
            },
          );
  }
}
