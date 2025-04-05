import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ForumPage(),
    );
  }
}

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  List<Map<String, String>> posts = [];

  Future<void> addPost() async {
    if (titleController.text.isEmpty || contentController.text.isEmpty || authorController.text.isEmpty) {
      return;
    }
    
    final post = {
      "title": titleController.text,
      "content": contentController.text,
      "author": authorController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/forum/posts'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(post),
      );
      
      if (response.statusCode == 201) {
        setState(() {
          posts.insert(0, post);
        });
        titleController.clear();
        contentController.clear();
        authorController.clear();
      }
    } catch (e) {
      print('Error adding post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🔥 CHAOS FORUM 🔥"),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: authorController,
                  decoration: InputDecoration(
                    labelText: "Missing Person Name",
                    filled: true,
                    fillColor: Colors.purpleAccent.withOpacity(0.2),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: "Founded Place",
                    filled: true,
                    fillColor: Colors.greenAccent.withOpacity(0.2),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: contentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: "Content",
                    filled: true,
                    fillColor: Colors.orangeAccent.withOpacity(0.2),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addPost,
                  child: Text("POST NOW!"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.primaries[index % Colors.primaries.length].withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          posts[index]["author"]!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          posts[index]["title"]!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          posts[index]["content"]!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}