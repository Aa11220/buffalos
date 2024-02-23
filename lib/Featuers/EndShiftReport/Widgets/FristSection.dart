import 'package:buffalos/apis/userapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/Emails/SendEmail.dart';
import '../../../apis/EmpData/EmpDataName.dart';
import '../../../providers/EmpDataProviderEndShiftReport.dart';
import '../../../providers/EmpNameProvider.dart';
import '../../../utility/pdf/Pdf_api.dart';
import '../../EndShift/Controller/EmailDataController.dart';
import '../../EndShift/Controller/EmpDataApi.dart';

class FristSection extends ConsumerStatefulWidget {
  const FristSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FristSectionState();
}

class _FristSectionState extends ConsumerState<FristSection> {
  void _onsave(bool send) async {
    var data = ref.read(EmpEndShiftProvider);
    var name = ref.read(EmpStringNotifierProvider);
    print(ref.read(EmpEndShiftProvider));
    if (_formKey.currentState!.validate() ||
        ref.read(EmpEndShiftProvider) != null) {
      me = await PDFUtils.generatepdfEndShift(
          id: ref.read(authprovider).logedin.shiftID.toString(),
          Total_host: "5",
          Starttime: "Starttime",
          name: name!,
          data: data!);
      if (send == true) {
        try {
          final list =
              await ref.read(EmailToControllerProvider).getall(context);
          await ref.read(SendEmailApiProvider).addfile(me, "welcom", list);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Done")));
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error Happen")));
        }
      } else {
        PDFUtils.openFile(me);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter data First"),
      ));
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController IdController = TextEditingController();
  var res;
  var me;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Shift ID : "),
            SizedBox(
              width: 150,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Value";
                  }
                  return null;
                },
                controller: IdController,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        res = await ref
                            .read(EmpDataControllerProvider)
                            .getdata(IdController.text);

                        final mine = await ref
                            .read(EmpDataNameProvider)
                            .GetName(IdController.text);

                        ref
                            .read(EmpStringNotifierProvider.notifier)
                            .Setvalue(mine);
                        ref.read(EmpEndShiftProvider.notifier).update(res);
                      }
                    },
                    child: const Text("View")),
                ElevatedButton(
                    onPressed: () {
                      _onsave(false);
                    },
                    child: const Text("PDF")),
                ElevatedButton(
                    onPressed: () {
                      _onsave(true);
                    },
                    child: const Text("Send Pdf"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
