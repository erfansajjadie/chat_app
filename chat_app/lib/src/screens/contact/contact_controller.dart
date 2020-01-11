import 'package:chat_app/src/data/models/chat.dart';
import 'package:chat_app/src/data/models/message.dart';
import 'package:chat_app/src/data/providers/chats_provider.dart';
import 'package:chat_app/src/data/repositories/chat_repository.dart';
import 'package:chat_app/src/utils/state_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ContactController extends StateControl {
  BuildContext context;

  ChatRepository _chatRepository = ChatRepository();

  ChatsProvider _chatsProvider;
  Chat get chat => _chatsProvider.selectedChat;

  TextEditingController textController = TextEditingController();

  bool _error = false;
  bool get error => _error;

  bool _loading = true;
  bool get loading => _loading;

  ContactController({
    @required this.context,
  }) {
    this.init();
  }

  void init() {
  }

  void initProvider() {
    _chatsProvider = Provider.of<ChatsProvider>(context);
  }

  void sendMessage() {
    String text = textController.text;
    _chatRepository.sendMessage(chat.id, text);
    textController.text = "";
    Message message = Message(
      text: text,
      userId: chat.myUser.id,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    print(DateTime.now().millisecondsSinceEpoch);
    addMessage(message);
  }

  void addMessage(Message message) {
    _chatsProvider.addMessageToSelectedChat(message);
  }

  void dispose() {
    super.dispose();
    textController.dispose();
  }
}
