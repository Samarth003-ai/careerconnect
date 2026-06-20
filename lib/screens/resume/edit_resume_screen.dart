import 'package:flutter/material.dart';

import '../../core/services/resume_service.dart';
import '../../models/resume_model.dart';

class EditResumeScreen extends StatefulWidget {
  final String resumeId;

  const EditResumeScreen({super.key, required this.resumeId});

  @override
  State<EditResumeScreen> createState() => _EditResumeScreenState();
}

class _EditResumeScreenState extends State<EditResumeScreen> {
  final titleController = TextEditingController();

  final summaryController = TextEditingController();
  final skillController = TextEditingController();
  List<dynamic> skills = [];
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final linkedinController = TextEditingController();

  final githubController = TextEditingController();

  bool isLoading = false;

  late Future<ResumeModel> resumeFuture;

  @override
  void initState() {
    super
        .initState(); //we used get in init state kyumki agar ui rebuild hui then again get call krna pdega instead init seedhe get krlega and bar bar api hit nhi hogi

    resumeFuture = ResumeService().getResumeById(widget.resumeId);
  }

  @override
  void dispose() {
    //to free up the memory, as user changes screen memory is released
    titleController.dispose();

    summaryController.dispose();
    skillController.dispose();

    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    linkedinController.dispose();
    githubController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Resume")),

      body: FutureBuilder<ResumeModel>(
        future: resumeFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final resume = snapshot.data!;

          if (skills.isEmpty) {
            skills = List.from(resume.skills);
          }
          nameController.text = nameController.text.isEmpty
              ? resume.personalInfo["name"] ?? ""
              : nameController.text;

          emailController.text = emailController.text.isEmpty
              ? resume.personalInfo["email"] ?? ""
              : emailController.text;

          phoneController.text = phoneController.text.isEmpty
              ? resume.personalInfo["phone"] ?? ""
              : phoneController.text;

          linkedinController.text = linkedinController.text.isEmpty
              ? resume.personalInfo["linkedin"] ?? ""
              : linkedinController.text;

          githubController.text = githubController.text.isEmpty
              ? resume.personalInfo["github"] ?? ""
              : githubController.text;

          titleController.text = //to get the value of title of the resume
              titleController //automatically shows the title of the resume in the textfield
                  .text
                  .isEmpty
              ? resume.title
              : titleController.text;

          summaryController.text = summaryController.text.isEmpty
              ? resume.summary
              : summaryController.text;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              children: [
                TextField(
                  controller: titleController,

                  decoration: const InputDecoration(
                    labelText: "Title",

                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: nameController,

                  decoration: const InputDecoration(
                    labelText: "Name",

                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,

                  decoration: const InputDecoration(
                    labelText: "Email",

                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneController,

                  decoration: const InputDecoration(
                    labelText: "Phone",

                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: linkedinController,

                  decoration: const InputDecoration(
                    labelText: "LinkedIn",

                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: githubController,

                  decoration: const InputDecoration(
                    labelText: "GitHub",

                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: summaryController,

                  maxLines: 5,

                  decoration: const InputDecoration(
                    labelText: "Summary",

                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Skills",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Column(
                  children: skills.map((skill) {
                    return Card(
                      child: ListTile(
                        title: Text(skill),

                        trailing: IconButton(
                          icon: const Icon(Icons.delete),

                          onPressed: () {
                            setState(() {
                              skills.remove(skill);
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: skillController,

                  decoration: const InputDecoration(
                    labelText: "New Skill",

                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    if (skillController.text.trim().isEmpty) {
                      return;
                    }

                    setState(() {
                      skills.add(skillController.text.trim());
                    });

                    skillController.clear();
                  },

                  child: const Text("Add Skill"),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (titleController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Title is required"),
                                ),
                              );

                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });

                            try {
                              await ResumeService().updateResume(
                                id: widget.resumeId,

                                title: titleController.text,

                                summary: summaryController.text,

                                name: nameController.text,

                                email: emailController.text,

                                phone: phoneController.text,

                                linkedin: linkedinController.text,

                                github: githubController.text,

                                skills: skills,
                              );

                              if (!context.mounted) {
                                return;
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Resume Updated")),
                              );

                              Navigator.pop(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            } finally {
                              if (mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },

                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Save Changes"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
