import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';
import 'package:labor_managment/model/worker_model.dart';

class StaffManagementPage extends StatelessWidget {
  const StaffManagementPage({super.key});

  Future<void> _deleteWorker(String workerId) async {
    try {
      await FirebaseFirestore.instance
          .collection('workers')
          .doc(workerId)
          .delete();
    } catch (e) {
      print('Error deleting worker: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Staff Management',
          style: TextStyle(
              fontSize: 25, color: secondaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('workers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading workers'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No workers found'));
          }

          var workers = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: workers.length,
            itemBuilder: (context, index) {
              var worker = workers[index].data() as Map<String, dynamic>;
              return Card(
                color: primaryColor,
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: secondaryColor,
                    child: Text(
                      worker['userName'][0].toUpperCase(),
                      style: const TextStyle(color: primaryColor),
                    ),
                  ),
                  title: Text(
                    worker['userName'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        worker['email'],
                        style: TextStyle(color: ash, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Job Type: ${worker['jobType']}',
                        style: TextStyle(color: ash, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Experience: ${worker['experience']} years',
                        style: TextStyle(color: ash, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Location: ${worker['location']}',
                        style: TextStyle(color: ash, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      _deleteWorker(workers[index].id);
                    },
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
