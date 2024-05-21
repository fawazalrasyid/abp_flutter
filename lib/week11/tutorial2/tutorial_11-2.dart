import 'package:flutter/material.dart';

class TutorialWeek112 extends StatelessWidget {
  const TutorialWeek112({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = [
      {
        "title": "Native App",
        "platform": "Android, IOS",
        "language": "Java, Kotlin, Swift, C#",
        "color": Colors.red,
      },
      {
        "title": "Hybrid App",
        "platform": "Android, IOS, Web",
        "language": "Javascript, Dart",
        "color": Colors.grey,
      }
    ];

    var titleInput = TextEditingController();
    var platInput = TextEditingController();
    var langInput = TextEditingController();
    List<String> colors = ['blue', 'green', 'yellow'];
    List<DropdownMenuItem<String>> ddItems = [];
    Object? colSelected;

    // Logic to initialize DropdownMenuItems
    for (String col in colors) {
      ddItems.add(DropdownMenuItem(
        value: col,
        child: Text(col),
      ));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: InkWell(
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: data[index]['color'],
                      ),
                      const SizedBox(width: 15),
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: 40, left: 10, top: 10),
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]['title'],
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Detail'),
                        content: SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 40, left: 10, top: 10),
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]['title'],
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 28,
                                  ),
                                ),
                                Text(
                                  data[index]['platform'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  data[index]['language'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: const Text('Add new tech'),
                children: [
                  Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Tech Name',
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Tech Name',
                        ),
                        controller: titleInput,
                      ),
                      TextFormField(
                        controller: platInput,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Platform',
                        ),
                      ),
                      TextFormField(
                        controller: langInput,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Language',
                        ),
                      ),
                      DropdownButtonFormField(
                        items: ddItems,
                        onChanged: (val) {
                          colSelected = val;
                        },
                        value: colSelected,
                      ),
                      ElevatedButton(
                        child: const Text('Save'),
                        onPressed: () {
                          if (colSelected == 'blue') {
                            colSelected = Colors.blue;
                          } else if (colSelected == 'green') {
                            colSelected = Colors.green;
                          } else if (colSelected == 'yellow') {
                            colSelected = Colors.yellow;
                          }
                          data.add({
                            "title": titleInput.text,
                            "platform": platInput.text,
                            "language": langInput.text,
                            "color": colSelected,
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
