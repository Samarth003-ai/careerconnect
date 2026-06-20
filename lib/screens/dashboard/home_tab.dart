import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Hello 👋",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          const Text("Ready for your next opportunity?"),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(child: dashboardCard("Resumes", "3", Icons.description)),

              const SizedBox(width: 15),

              Expanded(child: dashboardCard("Jobs", "24", Icons.work)),
            ],
          ),

          const SizedBox(height: 20),

          dashboardCard("Profile Completion", "80%", Icons.person),

          const SizedBox(height: 30),

          const Text(
            "Recent Activity",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          const ListTile(
            leading: Icon(Icons.check),
            title: Text("Resume Updated"),
          ),

          const ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text("PDF Generated"),
          ),

          const ListTile(
            leading: Icon(Icons.bookmark),
            title: Text("Job Saved"),
          ),
        ],
      ),
    );
  }

  Widget dashboardCard(String title, String value, IconData icon) {
    return Card(
      elevation: 3,

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Icon(icon, size: 35),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Text(title),
          ],
        ),
      ),
    );
  }
}
