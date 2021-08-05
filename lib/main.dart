import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  void _handleSubmitted(String text) {
    _textController.clear();
  }

  Widget _buildTextComposer() => Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: _textController,
          onSubmitted: _handleSubmitted,
          decoration: InputDecoration.collapsed(hintText: 'Send  Message'),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friendly Chat'),
      ),
      body: Row(
        children: [
          Expanded(child: _buildTextComposer()),
          IconButton(onPressed: () {}, icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
