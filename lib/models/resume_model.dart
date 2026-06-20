class ResumeModel {
  final String id;
  final String title;
  final String template;
  final String summary;
  final Map<String, dynamic> personalInfo;
  final List<dynamic> education;
  final List<dynamic> experience;
  final List<dynamic> skills;
  final List<dynamic> projects;

  ResumeModel({
    required this.id,
    required this.title,
    required this.template,
    required this.summary,
    required this.personalInfo,
    required this.education,
    required this.experience,
    required this.skills,
    required this.projects,
  });

  factory ResumeModel.fromJson(
    //converts json into dart object/model
    Map<String, dynamic> json,
  ) {
    return ResumeModel(
      id: json["_id"],
      title: json["title"] ?? "",
      template: json["template"] ?? "",
      summary: json["summary"] ?? "",
      personalInfo: json["personalInfo"] ?? {},
      education: json["education"] ?? [],
      experience: json["experience"] ?? [],
      skills: json["skills"] ?? [],
      projects: json["projects"] ?? [],
    );
  }
}
