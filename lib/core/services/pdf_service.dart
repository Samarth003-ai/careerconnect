import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';

import 'package:open_filex/open_filex.dart';

import 'token_service.dart';

class PdfService {
  static const String baseUrl = "http://10.0.2.2:5000/api";

  Future<void> downloadPdf(String resumeId) async {
    final token = await TokenService().getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/pdf/$resumeId"),

      headers: {"Authorization": "Bearer $token"},
    );

    final dir =
        await getApplicationDocumentsDirectory(); //opens app documents folder

    final file = File("${dir.path}/resume.pdf");

    await file.writeAsBytes(response.bodyBytes);

    await OpenFilex.open(file.path);
  }
}

// User clicks PDF button
//          ↓
// Flutter sends GET request
//          ↓
// Backend generates PDF
//          ↓
// Backend sends PDF bytes
//          ↓
// Flutter receives bytes
//          ↓
// Flutter saves resume.pdf
//          ↓
// Flutter opens resume.pdf
