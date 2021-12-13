import 'package:flutter/material.dart';
import 'package:todo_app/create_task.dart';
import 'package:todo_app/utils.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String selectedItem = 'todo';

  List<Map<String, dynamic>> _uncompletedTask = [];

  List<Map<String, dynamic>> _completedTask = [];

  final List<Map<String, dynamic>> data = [
    {
      'title': 'Go to the gym',
      'description':
          'Bench press for 10 min & 30 squats',
      'date_time': 'Yesterday',
      'status': true,
    },
    {
      'title': 'Youth meeting',
      'description':
          'Update the youth WhatsApp page on the funds raised',
      'date_time': 'Today',
      'status': true,
    },
    {
      'title': 'JavaScript project',
      'description':
          'Learn how to use jQuery for finish up the GPA Calculator app',
      'date_time': 'Tomorrow',
      'status': false,
    },
    {
      'title': 'Learn flutter',
      'description':
          'Study chapters 2 & 3 of Flutter apprentice book',
      'date_time': 'Today',
      'status': false,
    },
    {
      'title': 'GTL live training',
      'description':
          'Get some questions ready for Sir Bright.',
      'date_time': 'Today',
      'status': false,
    },
    {
      'title': 'Go to the bank',
      'description':
          'Deposit \$1000.00 into my dollar account',
      'date_time': 'Yesterday',
      'status': true,
    },
    {
      'title': 'Dinner w/ bae',
      'description':
          'Take bae out for dinner @ SandBox resort❤',
      'date_time': 'Dec 20',
      'status': false,
    },
    {
      'title': 'Submit assignment',
      'description':
          'Push Contact and Todo apps to Github',
      'date_time': 'Tomorrow',
      'status': false,
    },
  ];

  @override
  void initState() {
    for (Map<String, dynamic> element in data) {
      if (!element['status']) {
        _uncompletedTask.add(element);
      } else {
        _completedTask.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'My Tasks',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: const Center(
            child: FlutterLogo(
          size: 30,
        )),
        actions: [
          PopupMenuButton<String>(
              icon: const Icon(Icons.menu),
              onSelected: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text('Todo'),
                    value: 'todo',
                  ),
                  const PopupMenuItem(
                    child: Text('Completed'),
                    value: 'completed',
                  ),
                ];
              }),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return CreateTask();
          }));
        },
        child: const Icon(Icons.add),
        backgroundColor: const Color.fromRGBO(37, 43, 103, 1),
        hoverColor: const Color.fromRGBO(37, 50, 103, 1),
        hoverElevation: 5.0,
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            return TaskCardWidget(
                dateTime: selectedItem == 'todo'
                    ? _uncompletedTask[index]['date_time']
                    : _completedTask[index]['date_time'],
                description: selectedItem == 'todo'
                    ? _uncompletedTask[index]['description']
                    : _completedTask[index]['description'],
                title: selectedItem == 'todo'
                    ? _uncompletedTask[index]['title']
                    : _completedTask[index]['title']);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: selectedItem == 'todo'
              ? _uncompletedTask.length
              : _completedTask.length),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: InkWell(
            onTap: () {
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView.separated(
                        padding: const EdgeInsets.all(12.0),
                        itemBuilder: (context, index) {
                          return TaskCardWidget(
                              dateTime: _completedTask[index]['date_time'],
                              description: _completedTask[index]['description'],
                              title: _completedTask[index]['title']);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                        itemCount: _completedTask.length);
                  });
            },
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(37, 43, 103, 1),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline_outlined,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Completed',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white),
                    ),
                    const Spacer(),
                    Text(
                      '${_completedTask.length}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.dateTime})
      : super(key: key);

  final String title;
  final String description;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_outline_outlined,
              size: 30,
              color: customColor(date: dateTime),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.blueGrey),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Row(children: [
              Icon(
                Icons.notifications_outlined,
                color: customColor(date: dateTime),
              ),
              Text(dateTime,
                  style: TextStyle(
                    color: customColor(date: dateTime),
                  ))
            ])
          ],
        ),
      ),
    );
  }
}
