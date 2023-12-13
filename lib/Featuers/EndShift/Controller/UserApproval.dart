import 'package:buffalos/apis/UserAproval/UserAproval(EndShiift).dart';
import 'package:flutter/material.dart';

class UserApprovalController {
  final UserApprovalApi userApprovalApi;

  UserApprovalController({required this.userApprovalApi});
  Future<bool> getUserApprovals(
      String User, String Password, BuildContext context) async {
    try {
      final approval = await userApprovalApi.CheckApproval(User, Password);
      if (approval.EmpID == 0) {
        return false;
      }
      return true;
    } catch (e) {
      showAdaptiveDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Not Approved"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "OK",
                ),
              )
            ],
          );
        },
      );
      return false;
    }
  }
}
