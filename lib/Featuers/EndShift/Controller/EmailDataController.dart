import '../../../apis/Emails/Emailsto.dart';
import '../../../models/Email/Email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final EmailToControllerProvider = Provider<EmailToController>((ref) {
  final api = ref.read(EmailToApiProvider);
  return EmailToController(api: api);
});

class EmailToController {
  final EmailToApi api;

  EmailToController({required this.api});

  Future<List<Email>> getall(BuildContext context) async {
    try {
      final list = await api.getEmails();
      return list;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Error happen"),
          ),
        );
      }
      return [];
    }
  }
}
