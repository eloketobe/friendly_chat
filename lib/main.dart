import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

String _name = 'Tobe';

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
  List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.insert(0, ChatMessage(text));
    });
    _focusNode.requestFocus();
  }

  Widget _buildTextComposer() => Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          focusNode: _focusNode,
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
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
            padding: EdgeInsets.all(8),
            reverse: true,
            itemBuilder: (_, index) => _messages[index],
            itemCount: _messages.length,
          )),
          Divider(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: [
                Expanded(child: _buildTextComposer()),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                  color: Theme.of(context).accentColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 16),
          child: CircleAvatar(
            child: Text(_name[0].toUpperCase()),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _name,
              style: Theme.of(context).textTheme.headline5,
            ),
            Container(margin: EdgeInsets.only(top: 5), child: Text(text))
          ],
        )
      ],
    ));
  }
}
