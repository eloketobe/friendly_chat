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

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  List<ChatMessage> _messages = [];
  bool _isComposing = false;
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  void _handleSubmitted(String text) {
    _textController.clear();

    setState(() {
      _isComposing = false;
    });

    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
          duration: const Duration(milliseconds: 700), vsync: this),
    );
    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    message.animationController.forward();
  }

  Widget _buildTextComposer() => Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          onChanged: (value) {
            setState(() {
              _isComposing = value.isNotEmpty;
            });
          },
          focusNode: _focusNode,
          controller: _textController,
          onSubmitted: _isComposing ? _handleSubmitted : null,
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
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
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

  @override
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.animationController});
  final String text;
  final AnimationController animationController;
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
          parent: animationController, curve: Curves.easeOutCubic),
      child: Container(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              child: Text(_name[0].toUpperCase()),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Container(margin: EdgeInsets.only(top: 5), child: Text(text))
              ],
            ),
          )
        ],
      )),
    );
  }
}
