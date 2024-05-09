// Tạo một màn hình mới cho chat
import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Support'),
      ),
      body: Tawk(
        directChatLink:
            'https://tawk.to/chat/634bde43b0d6371309c9c84f/1gfg5oefe',
        visitor: TawkVisitor(
          name: 'John Doe',
          email: 'johndoe@gmail.com',
        ),
        onLoad: () {
          print('Hello Tawk!');
        },
        onLinkTap: (String url) {
          print(url);
        },
        placeholder: const Center(
          child: Text('Loading...'),
        ),
      ),
    );
  }
}
