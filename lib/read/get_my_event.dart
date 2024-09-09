import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetMyEvent extends StatelessWidget {

  final String documentId;


  const GetMyEvent({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    CollectionReference events = FirebaseFirestore.instance.collection('events');

    formatEventDate(Timestamp givenTimeStamp) {
      final DateTime dateTime = givenTimeStamp.toDate();
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    }

    return FutureBuilder<DocumentSnapshot>(
        future: events.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Container (
                padding: const EdgeInsets.all(10.0),
                width: mediaQuery.size.width * 0.05,
                child: Text('${data['eventName']} ${formatEventDate(data['eventDate'])}'),
            );
          }
          return const Text('loading...');
        },
    );
  }
}
