import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../model/todo.dart';
import '../provider/todo_provider.dart';
import '../widget/add_todo_dialog_widget.dart';
import '../widget/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      RepeatedWidgets.todos(context: context, complete: false),
      RepeatedWidgets.todos(context: context, complete: true)
      // const   CompleteListWidget(),
    ];

    final List<TodoModel> todos = context.watch<TodosProvider>().todos;
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed',
          ),
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTodoDialogWidget(
            edit: false,
            todoModel: TodoModel(
                id: "${todos.isEmpty ? 0 : int.parse(todos.last.id) + 1}",
                title: "",
                description: "",
                isDone: false,
                createdTime: DateTime.now()),
          ),
          barrierDismissible: true,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
