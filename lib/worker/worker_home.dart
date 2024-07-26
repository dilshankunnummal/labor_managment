import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:labor_managment/components/user_drawer.dart';

class WorkerHome extends StatefulWidget {
  const WorkerHome({super.key});

  @override
  State<WorkerHome> createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome> {
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');

  

  User? currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
      ),
      body: currentUser == null
          ? const Center(
              child: Text('Not Logined'),
            )
          : StreamBuilder(
              stream: bookings
                  .where('workerId', isEqualTo: currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('An error occurred'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No trips available'));
                }

                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot bookSnap =
                        snapshot.data!.docs[index];

                    // return Card(
                    //   child: Column(
                    //     children: [
                    //       Text(bookSnap[])
                    //     ],
                    //   ),
                    // )
                  },
                );
              },
            ),
    );
  }
}
