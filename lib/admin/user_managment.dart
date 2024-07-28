import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labor_managment/constants/colors.dart';

class UserManagementPage extends StatelessWidget {
  const UserManagementPage({super.key});

  Future<void> _deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
    } catch (e) {
      // Handle the error (e.g., show a snackbar or dialog)
      print('Error deleting user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Management',
          style: TextStyle(
            fontSize: 25,
            color: secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching users'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No registered users found'));
          }

          var users = snapshot.data!.docs;
          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: users.length,
            itemBuilder: (context, index) {
              var user = users[index].data() as Map<String, dynamic>;
              return Card(
                color: primaryColor,
                margin: const EdgeInsets.symmetric(vertical: 15),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: secondaryColor,
                    child: Text(
                      user['userName'][0].toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    user['userName'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['email'],
                        style: TextStyle(color: Colors.grey[700]),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        user['phoneNumber'] ?? 'Phone number not available',
                        style: TextStyle(color: Colors.grey[700]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      _deleteUser(users[index].id);
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
