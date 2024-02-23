import 'package:buffalos/Featuers/EndShiftReport/Widgets/FristSection.dart';
import 'package:buffalos/Featuers/EndShiftReport/Widgets/SecondSection.dart';
import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:buffalos/utility/lineargragr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/EmpDataProviderEndShiftReport.dart';
import '../../../providers/EmpNameProvider.dart';

class EndShiftReportScreen extends ConsumerStatefulWidget {
  const EndShiftReportScreen({super.key});
  static const path = "/EndShiftReportScreen";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EndShiftReportScreenState();
}

class _EndShiftReportScreenState extends ConsumerState<EndShiftReportScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: linear),
        child: Scaffold(
          appBar: Customappbar(text: "End Shift Report"),
          drawer: MyDrawer(context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const FristSection(),
                const SecondSection(),
                Consumer(
                  builder: (context, ref, child) {
                    final name = ref.read(EmpStringNotifierProvider);
                    final data = ref.watch(EmpEndShiftProvider);

                    return Expanded(
                        child: data == null
                            ? const SizedBox()
                            : SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(name ?? ""),
                                        Text(data.StartTime!.split("T")[0]),
                                        Text(data.StartTime!
                                            .split("T")[1]
                                            .split(".")[0]),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Orders",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              data.price.toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Orders After Discount",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.TotalAfterDiscount ?? "")
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Discount",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.Discount ?? "").toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Cash",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.Cashprice ?? "").toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Visa",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.Visaprice ?? "").toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Host",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.Hordercount ?? "")
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Orders Count",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.ordercount ?? "")
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Returns Count",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.returncount ?? "")
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Returns Value",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.returnedvalue ?? "")
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Expenses",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.expensecount ?? "")
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Expenses Value",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.expprice ?? "").toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Unpaid Delivery Orders",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.NotPaidDelivery ?? "")
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Total Unpiad Table Orders",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.NotPaidTables ?? "")
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Value Carried over from",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.TransferedFrom ?? "")
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Value Carried Over To",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.TransferedTo ?? "")
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Net Cash",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.NetCash ?? "").toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Net Oeder value",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Text(
                                              (data.NetCash ?? "").toString(),
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        ExpansionTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Total companies",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Text(
                                                data.Total().toString(),
                                                style: TextStyle(fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          children: [
                                            ...data.companyes!
                                                .map((e) => Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            e["CompanyName"],
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          Text(
                                                            (e["CompOrderValue"])
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                        ]))
                                                .toList()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
