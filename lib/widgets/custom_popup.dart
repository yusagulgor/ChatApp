import 'package:chattingapp/service/friend_service.dart';
import 'package:flutter/material.dart';

class CustomPopup extends StatefulWidget {
  final String title;
  final String message;
  final FriendService friendService;
  final String userId;

  CustomPopup({
    super.key,
    required this.title,
    required this.message,
    required this.friendService,
    required this.userId,
  });

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  List<Map<String, dynamic>> allFriends = [];
  List<Map<String, dynamic>> addedFriends = [];
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      insetPadding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: screenHeight * 0.8,
        width: screenWidth * 0.4,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 14, 13, 13),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Create a Group",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter a group name",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your Friends",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: widget.friendService.getFriends(widget.userId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Hata oluştu",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    // Veriyi al, sadece bir kez initialize et
                    if (!isLoaded) {
                      allFriends = List<Map<String, dynamic>>.from(
                        snapshot.data!,
                      );
                      isLoaded = true;
                    }

                    return Flexible(
                      flex: 2,
                      child: ListView.builder(
                        itemCount: allFriends.length,
                        itemBuilder: (context, index) {
                          final friend = allFriends[index];
                          final name = friend["name"] ?? "Bilinmeyen";
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(name[0].toUpperCase()),
                            ),
                            title: Text(
                              name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "ID: ${friend["id"]}",
                              style: const TextStyle(color: Colors.white70),
                            ),
                            onTap: () {
                              setState(() {
                                // Added friends listesine ekle
                                addedFriends.add(friend);
                                // All friends listesinden çıkar
                                allFriends.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Added friends",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Container(
              height: 280, // Sabit yüksekliğe sahip scrollable liste
              child: ListView.builder(
                itemCount: addedFriends.length,
                itemBuilder: (context, index) {
                  final friend = addedFriends[index];
                  final name = friend["name"] ?? "Bilinmeyen";
                  return ListTile(
                    leading: CircleAvatar(child: Text(name[0].toUpperCase())),
                    title: Text(
                      name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "ID: ${friend["id"]}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    onTap: () {
                      setState(() {
                        // Tıkladığında listeden çıkar ve allFriends'a geri ekle
                        allFriends.add(friend);
                        addedFriends.removeAt(index);
                      });
                    },
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Create a group"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
