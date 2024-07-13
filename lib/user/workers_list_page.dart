import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labor_managment/constants/colors.dart';

class Workerslistpage extends StatefulWidget {
  const Workerslistpage({super.key});

  @override
  State<Workerslistpage> createState() => _WorkerslistpageState();
}

class _WorkerslistpageState extends State<Workerslistpage> {
  Map? args;

  final CollectionReference workers =
  FirebaseFirestore.instance.collection('workers');
  final CollectionReference bookings =
  FirebaseFirestore.instance.collection('bookings');
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as Map?;
  }

  Future<void> bookWorker(String workerId, String workerName, String jobCategory, String userId, String userName) async {
    try {
      await bookings.add({
        'workerId': workerId,
        'workerName': workerName,
        'jobCategory': jobCategory,
        'bookingDate': Timestamp.now(),
        'userId': userId,
        'userName': userName,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Worker booked successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to book worker: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String? jobCategory = args?['jobCategory'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Staff List of $jobCategory',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: StreamBuilder(
        stream: workers.where('jobType', isEqualTo: jobCategory).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No workers available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var worker = snapshot.data!.docs[index];
              String workerId = worker.id;
              String workerName = worker['userName'] ?? 'N/A';
              String experience = worker['experience'].toString() ?? 'N/A';
              String email = worker['email'] ?? 'N/A';

              return Card(
                color: secondaryColor,
                margin:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workerName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            'Experience: $experience years',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: 70),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (currentUser != null) {
                                    bookWorker(
                                      workerId,
                                      workerName,
                                      jobCategory!,
                                      currentUser!.uid,
                                      currentUser!.displayName ?? 'Anonymous',
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('User not logged in')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor, // Button color
                                ),
                                child: Text(
                                  'Book',
                                  style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Email: $email',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
