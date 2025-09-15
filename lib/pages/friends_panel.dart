import 'package:flutter/material.dart';
import 'package:chattingapp/widgets/user_card.dart';

class FriendsPanel extends StatelessWidget {
  final List<dynamic> friends;
  final Function(String) onOpenChat;

  const FriendsPanel({
    super.key,
    required this.friends,
    required this.onOpenChat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      color: const Color.fromARGB(255, 29, 29, 29),
      child: Column(
        children: [
          const Text(
            "Arkadaşların",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          const Divider(color: Colors.white),
          Expanded(
            child: friends.isEmpty
                ? const Center(
                    child: Text(
                      "Arkadaş yok",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      return UserCard(
                        name: friend['name'],
                        onTap: () => onOpenChat(friend['id']),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
