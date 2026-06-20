import 'package:flutter/material.dart';
import 'package:resume_builder/core/services/pdf_service.dart';
import 'package:resume_builder/screens/resume/create_resume_screen.dart';

import '../../core/services/resume_service.dart';
import '../../models/resume_model.dart';

class ResumesScreen extends StatelessWidget {
  const ResumesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          FutureBuilder<
            //we use future builder bcoz we have to wait for the future to complete to get the resumes
            List<ResumeModel>
          >(
            future: ResumeService().getResumes(),

            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              final resumes = snapshot.data ?? [];

              if (resumes.isEmpty) {
                return const Center(child: Text("No resumes found"));
              }

              return ListView.builder(
                //list builder is used to display the list of resumes that are only seen at that time means not all resumes are created at once
                itemCount: resumes.length,

                itemBuilder: (context, index) {
                  final resume = resumes[index];

                  return Card(
                    margin: const EdgeInsets.all(12),

                    child: ListTile(
                      title: Text(resume.title),

                      subtitle: Text(resume.template),

                      trailing: IconButton(
                        icon: const Icon(Icons.picture_as_pdf),

                        onPressed: () async {
                          await PdfService().downloadPdf(resume.id);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,

            MaterialPageRoute(builder: (_) => const CreateResumeScreen()),
          );
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
