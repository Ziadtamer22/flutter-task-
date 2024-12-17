import 'package:eco/utils/colors_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: ColorsBox.blue),
              title: Text(
                  user?.displayName != null && user!.displayName!.isNotEmpty
                      ? user.displayName!
                      : "Guest"),
              subtitle: Text(
                user?.email != null && user!.email!.isNotEmpty
                    ? user.email!
                    : "No email provided",
              ),
            ),

            const Divider(),

            // User Information List
            ListTile(
              leading: const Icon(Icons.phone, color: ColorsBox.blue),
              title: const Text("Phone Number"),
              subtitle: Text(
                user?.phoneNumber != null && user!.phoneNumber!.isNotEmpty
                    ? user.phoneNumber!
                    : "No phone number provided",
              ),
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.access_time, color: ColorsBox.green),
              title: const Text("Last Sign-In"),
              subtitle: Text(
                user?.metadata.lastSignInTime != null
                    ? formatDate(user!.metadata.lastSignInTime)
                    : "No sign-in information",
              ),
            ),
            const Divider(),

            ListTile(
              leading:
                  const Icon(Icons.calendar_today, color: ColorsBox.orange),
              title: const Text("Account Creation"),
              subtitle: Text(
                user?.metadata.creationTime != null
                    ? formatDate(user!.metadata.creationTime)
                    : "No creation information",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatDate(DateTime? date) {
  if (date == null) return "No date available";
  return DateFormat('yyyy-MM-dd HH:mm a').format(date);
}
