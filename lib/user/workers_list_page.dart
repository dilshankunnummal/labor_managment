import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Workerslistpage extends StatefulWidget {
  const Workerslistpage({super.key});

  @override
  State<Workerslistpage> createState() => _WorkerslistpageState();
}

class _WorkerslistpageState extends State<Workerslistpage> {
  Map? args;

  final CollectionReference workers =
      FirebaseFirestore.instance.collection('workers');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as Map?;
  }

  // final args = ModalRoute.of(context)!.settings.arguments as Map?;

  @override
  Widget build(BuildContext context) {
    String? jobCategory = args?['jobCategory'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Workers List of $jobCategory'),
      ),
      body: StreamBuilder(
        stream: workers.where(jobCategory!).snapshots(),
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
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var labour = snapshot.data!.docs[index];
              String name = labour['userName'] ?? 'N/A';
              String experience = labour['experience'].toString() ?? 'N/A';

              return Container(
                child: Column(
                  children: [Text(name), Text(experience)],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
