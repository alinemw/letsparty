import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lets_party/pages/add_event_page.dart';
import 'package:lets_party/read/get_my_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  List<String> myEventsId = [];

  Future getMyEvents() async {
    myEventsId.clear();
    await FirebaseFirestore.instance.collection('events')
        .where('user', isEqualTo: user?.email)
        .get()
        .then((snapshot) =>
          snapshot.docs.forEach((document) {
            myEventsId.add(document.reference.id);
          })
        );
  }

  Future eventGiveUp(String documentId) async {
     FirebaseFirestore.instance.collection('events').doc(documentId).delete()
        .then((snapshot) => myEventsId.remove(documentId)
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
  
  void goToNewEvent(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddEventPagePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: [IconButton(onPressed: signOut, icon: const Icon(Icons.logout))],
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                  future: getMyEvents(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: myEventsId.length,

                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: Colors.grey[200],
                            title: GetMyEvent(documentId: myEventsId[index]),
                            onLongPress: () async => await eventGiveUp(myEventsId[index])
                          ),
                        );
                      },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: goToNewEvent,
        foregroundColor: Colors.yellow,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBar(
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        color: Colors.black87,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.only(left:  10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:  10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:  10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:  10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_user,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}