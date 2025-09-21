import 'package:flutter/material.dart';

class ChatPanel extends StatelessWidget {
  final List<dynamic> messages;
  final String? activeChatUserId;
  final List<dynamic> friends;
  final ScrollController scrollController;
  final TextEditingController msgController;
  final VoidCallback onSendMessage;
  final String currentUserId;

  const ChatPanel({
    super.key,
    required this.messages,
    required this.activeChatUserId,
    required this.friends,
    required this.scrollController,
    required this.msgController,
    required this.onSendMessage,
    required this.currentUserId,
  });

  String chatUserName() {
    if (activeChatUserId == null) return "Bir Sohbet Seçin";
    final user = friends.firstWhere(
      (f) => f['id'] == activeChatUserId,
      orElse: () => {'name': 'Bilinmeyen'},
    );
    return user['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height,
      color: const Color.fromARGB(255, 53, 53, 53),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: const Border(
                bottom: BorderSide(color: Colors.white24, width: 1),
              ),
            ),
            child: Text(
              chatUserName(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: activeChatUserId == null
                ? const Center(
                    child: Text(
                      "Arkadaş listenden birine tıkla ve sohbet başlat",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index] as Map<String, dynamic>;
                      final isMe = msg["from"] == currentUserId;
                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue : Colors.grey[700],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            msg["text"] ?? "",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: msgController,
                    onSubmitted: (value) {
                      onSendMessage();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: onSendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
