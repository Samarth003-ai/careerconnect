import 'package:flutter/material.dart';

import '../../core/services/job_service.dart';
import '../../models/job_model.dart';
import 'package:url_launcher/url_launcher.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final searchController = TextEditingController();

  List<JobModel> jobs = [];

  bool isLoading = false;

  Future<void> searchJobs() async {
    if (searchController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await JobService().searchJobs(
        searchController.text.trim(),
      );

      setState(() {
        jobs = result;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //apply function
  Future<void> openApplyLink(String url) async {
    final uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jobs")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: searchController,

              decoration: const InputDecoration(
                labelText: "Search Jobs",

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: isLoading ? null : searchJobs,

                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Search"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: jobs.length,

                itemBuilder: (context, index) {
                  final job = jobs[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),

                    child: Padding(
                      padding: const EdgeInsets.all(12),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            job.title,

                            style: const TextStyle(
                              fontSize: 16,

                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(job.company),

                          Text(job.location),

                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,

                            child: ElevatedButton(
                              onPressed: () {
                                openApplyLink(job.applyLink);
                              },

                              child: const Text("Apply"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
