import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

import '../../../apis/EmpData/EmpDataName.dart';
import '../../../apis/EmpForEndShift/EmpShiftInterval.dart';
import '../../../providers/EmpDataProviderEndShiftReport.dart';
import '../../../providers/EmpNameProvider.dart';
import '../../EndShift/Controller/EmpDataApi.dart';

class SecondSection extends ConsumerStatefulWidget {
  const SecondSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SecondSectionState();
}

class _SecondSectionState extends ConsumerState<SecondSection> {
  TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;
  DateTime? _SecondselectedDate;
  void _selectDate(bool Start) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null &&
        (pickedDate != _selectedDate || pickedDate != _SecondselectedDate)) {
      if (Start) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
      if (!Start) {
        setState(() {
          _SecondselectedDate = pickedDate;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              // width: MediaQuery.of(context).size.width * 1,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("From date :" +
                          (_selectedDate == null
                              ? ""
                              : DateFormat("yyyy-MM-dd")
                                  .format(_selectedDate!)
                                  .toString())),
                      IconButton(
                          onPressed: () {
                            _selectDate(true);
                          },
                          icon: Icon(Icons.date_range)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("To date :" +
                          (_SecondselectedDate == null
                              ? ""
                              : DateFormat("yyyy-MM-dd")
                                  .format(_SecondselectedDate!)
                                  .toString())),
                      IconButton(
                          onPressed: () {
                            _selectDate(false);
                          },
                          icon: Icon(Icons.date_range)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_SecondselectedDate != null && _selectedDate != null)
            Expanded(
                child: TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                      onTap: () => _controller.clear(),
                      controller: _controller,
                      decoration: const InputDecoration(
                          hintText: "Select ...",
                          suffixIcon: Icon(Icons.keyboard_arrow_down)),
                    ),
                    onSuggestionSelected: (A) async {
                      _controller.text =
                          ("${A.PK_Shift_ID} start:${(A.StartTime)!.split("T")[0]} End:${(A.Endtime) == null ? "" : (A.Endtime)!.split("T")[0]}");
                      var res = await ref
                          .read(EmpDataControllerProvider)
                          .getdata(A.PK_Shift_ID.toString());

                      final mine = await ref
                          .read(EmpDataNameProvider)
                          .GetName(A.PK_Shift_ID.toString());

                      ref
                          .read(EmpStringNotifierProvider.notifier)
                          .Setvalue(mine);
                      ref.read(EmpEndShiftProvider.notifier).update(res);
                    },
                    itemBuilder: (context, itemData) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            "${itemData.PK_Shift_ID} start:${(itemData.StartTime)!.split("T")[0]} End:${(itemData.Endtime) == null ? "" : (itemData.Endtime)!.split("T")[0]}"),
                      );
                    },
                    errorBuilder: (context, error) =>
                        Text("Some Thing go Wrong"),
                    suggestionsCallback: (A) async {
                      final _list = await ref
                          .read(EmpShiftIntervalApiProvider)
                          .GetData(
                              DateFormat("yyyy-MM-dd")
                                  .format(_selectedDate!)
                                  .toString(),
                              DateFormat("yyyy-MM-dd")
                                  .format(_SecondselectedDate!)
                                  .toString());
                      return _list.where((element) {
                        return ("${element.PK_Shift_ID} start:${element.StartTime} End:${element.Endtime}")
                            .toLowerCase()
                            .contains(A.toLowerCase());
                      });
                    }))
        ],
      ),
    );
  }
}
