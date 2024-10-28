import 'package:bloc_hive_tutorial/features/todo/data/models/todo_model.dart';
import 'package:bloc_hive_tutorial/features/todo/data/repos/hive_todo_repo.dart';
import 'package:bloc_hive_tutorial/features/todo/domain/repos/todo_repo.dart';
import 'package:bloc_hive_tutorial/features/todo/presentation/cubits/todo_cubit.dart';
import 'package:bloc_hive_tutorial/features/todo/presentation/pages/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize the hive and set the path
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  // register the adapter
  Hive.registerAdapter(TodoModelAdapter());

  // open the box
  Box<TodoModel> todoBox = await Hive.openBox<TodoModel>('todos');
  runApp(
    MyApp(
      box: todoBox,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Box<TodoModel> box;
  const MyApp({super.key, required this.box});

  @override
  Widget build(BuildContext context) {
    final TodoRepo todoRepo = HiveTodoRepo(box);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoCubit(todoRepo),
        ),
      ],
      child: MaterialApp(
        title: 'To Do App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const TodoPage(),
      ),
    );
  }
}
