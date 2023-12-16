import 'dart:developer';

import '../../../apis/UserAproval/UserAproval(EndShiift).dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final UserApprovalControllerProvider = Provider<UserApprovalController>((ref) {
  final api = ref.watch(UserApprovalProvider);
  return UserApprovalController(userApprovalApi: api);
});

class UserApprovalController {
  final UserApprovalApi userApprovalApi;

  UserApprovalController({required this.userApprovalApi});
  Future<Map<String, dynamic>> getUserApprovals(
      String User, String Password, BuildContext context) async {
    try {
      final approval = await userApprovalApi.CheckApproval(User, Password);
      log(approval.Response);
      if (approval.EmpID == 0) {
        if (context.mounted) {
          showAdaptiveDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Not Approved"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "OK",
                    ),
                  )
                ],
              );
            },
          );
        }
        return {"Condition": false, "Value": approval.EmpID};
      }
      return {"Condition": true, "Value": approval.EmpID};
    } catch (e) {
      if (context.mounted) {
        showAdaptiveDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Not Approved"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "OK",
                  ),
                )
              ],
            );
          },
        );
      }
      return {"Condition": false};
    }
  }
}
