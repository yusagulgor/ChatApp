import 'package:chattingapp/pages/login_screen.dart';
import 'package:chattingapp/service/auth_service.dart';
import 'package:chattingapp/service/friend_service.dart';
import 'package:chattingapp/widgets/custom_popup.dart';
import 'package:chattingapp/widgets/join_group_popup.dart';
import 'package:flutter/material.dart';
import '../widgets/username_searchbar.dart';

class LeftPanel extends StatelessWidget {
  final List<dynamic> pendingRequests;
  final TextEditingController usernameController;
  final Function(String) onAccept;
  final Function(String) onReject;
  final VoidCallback onAddFriend;
  final double screenWidth;
  final double screenHeight;
  final String username;
  final String userId;
  const LeftPanel({
    super.key,
    required this.pendingRequests,
    required this.usernameController,
    required this.onAccept,
    required this.onReject,
    required this.onAddFriend,
    required this.screenWidth,
    required this.screenHeight,
    required this.username,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    print(usernameController.text);
    return Container(
      width: screenWidth * 0.2,
      height: screenHeight,
      color: const Color.fromARGB(255, 29, 29, 29),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                icon: Icon(Icons.logout_rounded),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    username,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(width: 48),
            ],
          ),
          Center(
            child: const Text(
              "Arkadaş ekle",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
          UsernameSearchbar(hintText: "isim", controller: usernameController),
          SizedBox(height: screenHeight * 0.04),
          Center(
            child: customButton(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              onTap: onAddFriend,
            ),
          ),
          const Divider(color: Colors.white),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showCustomPopup(context, userId);
                  },
                  child: Text("Create a group"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showCreateGroupPopup(context);
                  },
                  child: Center(child: Text("Join a group")),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.05),
          const Divider(color: Colors.white),
          const Center(
            child: Text(
              "Bekleyen istekler",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          Expanded(
            child: pendingRequests.isEmpty
                ? const Center(
                    child: Text(
                      "Bekleyen istek yok",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: pendingRequests.length,
                    itemBuilder: (context, index) {
                      final req = pendingRequests[index];
                      return Card(
                        color: const Color.fromARGB(255, 60, 60, 60),
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 8,
                        ),
                        child: ListTile(
                          title: Text(
                            req["name"] ?? "Bilinmeyen",
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                ),
                                onPressed: () => onAccept(req["fromUserId"]),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () => onReject(req["fromUserId"]),
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

class customButton extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onTap;

  const customButton({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(110, 0, 0, 0),
              spreadRadius: 0.05,
              blurRadius: 8,
              offset: Offset(2, 2),
            ),
          ],
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(20),
        ),
        width: screenWidth * 0.10,
        height: screenHeight * 0.06,
        child: const Center(
          child: Text("Arkadaş Ekle", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

void showCustomPopup(BuildContext context, String userId) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return CustomPopup(
        friendService: FriendService(),
        userId: userId,
        title: 'asd',
        message: 'asd',
      );
    },
  );
}

void showCreateGroupPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return JoinGroupPopup();
    },
  );
}
