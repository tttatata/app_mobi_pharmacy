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
            'http://tawk.to/chat/663b931907f59932ab3d5416/1htcbd7me',
        visitor: TawkVisitor(
          name: 'Ayoub AMINE',
          email: 'ayoubamine2a@gmail.com',
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
