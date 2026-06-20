import 'package:flutter/material.dart';

import '../../core/services/resume_service.dart';

class CreateResumeScreen extends StatefulWidget {
  const CreateResumeScreen({super.key});

  @override
  State<CreateResumeScreen> createState() => _CreateResumeScreenState();
}

class _CreateResumeScreenState extends State<CreateResumeScreen> {
  final titleController = TextEditingController();

  String selectedTemplate = "modern_blue";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Resume")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: titleController,

              decoration: const InputDecoration(labelText: "Resume Title"),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField(
              //drop down appears
              value: selectedTemplate,

              items: const [
                DropdownMenuItem(
                  //items in drop down
                  value: "modern_blue",
                  child: Text("Modern Blue"),
                ),

                DropdownMenuItem(
                  value: "ats_friendly",
                  child: Text("ATS Friendly"),
                ),
              ],

              onChanged: (value) {
                //what happens any ohter choice is selected,
                selectedTemplate = value!;
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                await ResumeService().createResume(
                  title: titleController.text,

                  template: selectedTemplate,
                );

                if (!context.mounted) return;

                Navigator.pop(context);
              },

              child: const Text("Create Resume"),
            ),
          ],
        ),
      ),
    );
  }
}
