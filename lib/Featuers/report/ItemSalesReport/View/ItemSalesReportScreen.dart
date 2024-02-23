import 'package:buffalos/apis/userapi.dart';
import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/lineargragr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../apis/Emails/SendEmail.dart';
import '../../../../apis/ItemReportApi.dart';
import '../../../../apis/categoriesapi.dart';
import '../../../../models/ItemReportModule.dart';
import '../../../../utility/pdf/Pdf_api.dart';
import '../../../EndShift/Controller/EmailDataController.dart';
import '../../../Products/Controller/itemscontroller.dart';

class ItemsalesReportScreen extends ConsumerStatefulWidget {
  const ItemsalesReportScreen({super.key});
  static const path = "/ItemsalesReportScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ItemsalesReportScreenState();
}

class _ItemsalesReportScreenState extends ConsumerState<ItemsalesReportScreen> {
  bool? mysafe;
  final TextEditingController Items = TextEditingController();
  final TextEditingController category = TextEditingController();
  SuggestionsBoxController it = SuggestionsBoxController();
  SuggestionsBoxController cat = SuggestionsBoxController();
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
          mysafe = null;
        });
      }
      if (!Start) {
        setState(() {
          _SecondselectedDate = pickedDate;
          mysafe = null;
        });
      }
    }
  }

  bool isloading = false;
  String? value = "10";
  String? _value2 = "Quantity";
  List<ItemReportModule>? data;
  int? empid;
  String? itemsid;
  String? Categoryid;
  String? ItemName;
  String? CategoryName;
  @override
  void initState() {
    empid = ref.read(authprovider).logedin.pkEmpId;
    super.initState();
  }

  Future<List<ItemReportModule>> SetData() async {
    final response = await ref.read(ItemReportApiProvider).getallemp(
        (empid ?? 0).toString(),
        DateFormat("yyyy-MM-dd").format(_selectedDate!).toString(),
        DateFormat("yyyy-MM-dd").format(_SecondselectedDate!).toString(),
        Categoryid,
        itemsid);

    print(data);
    return response;
  }

  void _onsave(bool send) async {
    if (_selectedDate != null && _SecondselectedDate != null) {
      var editedlista = int.tryParse(value!) == null
          ? data
          : (data ?? []).take(int.parse((value ?? "").toString())).toList();
      final me = await PDFUtils.generatepdfItemSales(
          SortedBy: _value2!,
          Category: CategoryName ?? "",
          ItemName: ItemName ?? "",
          StartTime: DateFormat("yyyy-MM-dd").format(_selectedDate!).toString(),
          EndTime:
              DateFormat("yyyy-MM-dd").format(_SecondselectedDate!).toString(),
          LimitOfView: value ?? "",
          itemData: editedlista);
      if (send) {
        try {
          setState(() {
            isloading = true;
          });
          final list =
              await ref.read(EmailToControllerProvider).getall(context);
          await ref.read(SendEmailApiProvider).addfile(me, "welcom", list);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Done")));
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Error Happen")));
        }
        setState(() {
          isloading = false;
        });
      } else {
        PDFUtils.openFile(me);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Enter data First"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(gradient: linear),
      child: GestureDetector(
        child: GestureDetector(
          onTap: () {
            cat.close();
            it.close();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: Customappbar(text: "Items sales report"),
            drawer: MyDrawer(context),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("From date : " +
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
                      Text("To date : " +
                          (_SecondselectedDate == null
                              ? ""
                              : DateFormat("yyyy-MM-dd")
                                  .format(_SecondselectedDate!)
                                  .toString())),
                      IconButton(
                          onPressed: () {
                            _selectDate(false);
                          },
                          icon: Icon(Icons.date_range))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("Items"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .30,
                            child: TypeAheadFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().isEmpty) {
                                  return "Enter value";
                                }
                                return null;
                              },
                              onReset: () => Items.clear(),
                              textFieldConfiguration: TextFieldConfiguration(
                                onTap: () {
                                  Items.clear();
                                  itemsid = null;
                                  mysafe = null;
                                },
                                controller: Items,
                                decoration: const InputDecoration(
                                    hintText: "Select ...",
                                    suffixIcon:
                                        Icon(Icons.keyboard_arrow_down)),
                              ),
                              onSuggestionSelected: (suggestion) {
                                Items.text = suggestion.itemName!;
                                ItemName = suggestion.itemName!;
                                itemsid = suggestion.pkItemId.toString();
                                setState(() {
                                  mysafe = null;
                                });
                              },
                              suggestionsBoxController: it,
                              itemBuilder: (context, itemData) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(itemData.itemName!),
                                );
                              },
                              suggestionsCallback: (pattern) async {
                                final mylist = await ref
                                    .watch(Itemcontrollerprovider)
                                    .getItems("", selet_all: true);
                                return mylist.where((element) {
                                  return element.itemName!
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase());
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text("Category"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .30,
                            child: TypeAheadFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().isEmpty) {
                                  return "Enter value";
                                }
                                return null;
                              },
                              onReset: () => category.clear(),
                              textFieldConfiguration: TextFieldConfiguration(
                                onTap: () {
                                  category.clear();
                                  Categoryid = null;
                                },
                                controller: category,
                                decoration: const InputDecoration(
                                    hintText: "Select ...",
                                    suffixIcon:
                                        Icon(Icons.keyboard_arrow_down)),
                              ),
                              onSuggestionSelected: (suggestion) {
                                category.text = suggestion.categoryName;
                                CategoryName = suggestion.categoryName;
                                Categoryid = suggestion.pkCategory.toString();
                              },
                              itemBuilder: (context, itemData) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(itemData.categoryName),
                                );
                              },
                              suggestionsBoxController: cat,
                              suggestionsCallback: (A) async {
                                final mylist1 = await ref
                                    .watch(CategoriesApiprovider)
                                    .fetchCategories();
                                return mylist1.where((element) {
                                  return element.categoryName
                                      .toLowerCase()
                                      .contains(A.toLowerCase());
                                });
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("number of items"),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            width: MediaQuery.of(context).size.width * .30,
                            child: DropdownButton(
                                isExpanded: true,
                                value: value,
                                items: ["All", "10", "20", "30", "40", "50"]
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) async {
                                  setState(() {
                                    value = val;
                                    mysafe = null;
                                  });
                                }),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text("Sorted by"),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            width: MediaQuery.of(context).size.width * .30,
                            child: DropdownButton(
                                isExpanded: true,
                                value: _value2,
                                items: ["Quantity", "Price"]
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) async {
                                  setState(() {
                                    _value2 = val;
                                    mysafe = null;
                                  });
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            title: Text("Report"),
                            value: true,
                            groupValue: mysafe,
                            onChanged: (value) async {
                              if (_selectedDate == null &&
                                  _SecondselectedDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Please Select dates")));
                              } else {
                                data = await SetData();
                                if (_value2?.compareTo("Quantity") == 0) {
                                  data?.sort(
                                    (a, b) {
                                      return (a.totalQty ?? 0)
                                          .compareTo(b.totalQty ?? 0);
                                    },
                                  );
                                } else {
                                  data?.sort(
                                    (a, b) {
                                      return (a.Price ?? 0)
                                          .compareTo(b.Price ?? 0);
                                    },
                                  );
                                }

                                setState(() {
                                  mysafe = value!;
                                });
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text("Chart"),
                            value: false,
                            groupValue: mysafe,
                            onChanged: (value) async {
                              if (_selectedDate == null &&
                                  _SecondselectedDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Please Select dates")));
                              } else {
                                data = await SetData();
                                setState(() {
                                  mysafe = value!;
                                });
                                if (_value2?.compareTo("Quantity") == 0) {
                                  data?.sort(
                                    (a, b) {
                                      return (a.totalQty ?? 0)
                                          .compareTo(b.totalQty ?? 0);
                                    },
                                  );
                                } else {
                                  data?.sort(
                                    (a, b) {
                                      return (a.Price ?? 0)
                                          .compareTo(b.Price ?? 0);
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        )
                      ]),
                  mysafe != null
                      ? Expanded(
                          child: (mysafe == true)
                              ? SingleChildScrollView(
                                  child: Table(
                                    // border:
                                    //     TableBorder.all(color: Colors.white),
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(children: [
                                        TableCell(
                                            child: Center(child: Text("Name"))),
                                        TableCell(
                                            child: Center(
                                                child: Text("Category"))),
                                        TableCell(
                                            child:
                                                Center(child: Text("PRICE"))),
                                        TableCell(
                                            child: Center(
                                                child: Text("Quantity"))),
                                        TableCell(
                                            child:
                                                Center(child: Text("Total"))),
                                      ]),
                                      ...?(int.tryParse(value!) != null)
                                          ? data
                                              ?.take(int.tryParse(value!)!)
                                              .map((e) => TableRow(children: [
                                                    TableCell(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(e.ItemName!),
                                                    )),
                                                    TableCell(
                                                        child: Center(
                                                            child: Text(e
                                                                .CategoryName!))),
                                                    TableCell(
                                                        child: Center(
                                                            child: Text(e.Price!
                                                                .toString()))),
                                                    TableCell(
                                                        child: Center(
                                                      child: Text(e.totalQty!
                                                          .toString()),
                                                    )),
                                                    TableCell(
                                                        child: Center(
                                                      child: Text(e.TotalSales!
                                                          .toString()),
                                                    )),
                                                  ]))
                                          : data?.map((e) =>
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(e.ItemName!),
                                                )),
                                                TableCell(
                                                    child: Center(
                                                        child: Text(
                                                            e.CategoryName!))),
                                                TableCell(
                                                    child: Center(
                                                        child: Text(e.Price!
                                                            .toString()))),
                                                TableCell(
                                                    child: Center(
                                                  child: Text(
                                                      e.totalQty!.toString()),
                                                )),
                                                TableCell(
                                                    child: Center(
                                                  child: Text(
                                                      e.TotalSales!.toString()),
                                                )),
                                              ]))
                                    ],
                                  ),
                                )
                              : SfCartesianChart(
                                  primaryXAxis:
                                      CategoryAxis(maximumLabelWidth: 100),
                                  primaryYAxis:
                                      NumericAxis(minimum: 0, interval: 1000),
                                  series: <CartesianSeries<_ChartData, String>>[
                                      BarSeries<_ChartData, String>(
                                          dataSource: [
                                            ...data!
                                                .take(10)
                                                .map((e) => _ChartData(
                                                    e.ItemName ?? "",
                                                    _value2!.compareTo(
                                                                "Quantity") ==
                                                            0
                                                        ? (e.totalQty!
                                                                .toDouble() ??
                                                            0.0)
                                                        : (e.TotalSales ??
                                                            0.0)))
                                                .toList()
                                          ],
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: true),
                                          xValueMapper: (_ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (_ChartData data, _) =>
                                              data.y,
                                          color: Color.fromRGBO(8, 142, 255, 1))
                                    ])
                          // tooltipBehavior: _tooltip,
                          )
                      : Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _onsave(false);
                          },
                          child: Text("PDF")),
                      isloading == true
                          ? SizedBox(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                _onsave(true);
                              },
                              child: Text("Send PDF")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
