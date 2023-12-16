import '../controller/SafeDataController.dart';
import '../../../utility/commonwidget/appbar.dart';
import '../../../utility/commonwidget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/SafeData.dart';
import '../../../utility/lineargragr.dart';

class SafeDataScreen extends ConsumerStatefulWidget {
  const SafeDataScreen({super.key});
  static const path = "/safeDataScreen";
  @override
  ConsumerState<SafeDataScreen> createState() => _SafeDataState();
}

class _SafeDataState extends ConsumerState<SafeDataScreen> {
  List<SafeData> list = [];
  void setdata() async {
    list = await ref.read(SafeDataControllerProvider).getall();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: linear,
        ),
        child: Scaffold(
          appBar:  Customappbar(text: "Safe Data"),
          drawer: MyDrawer(context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const Row(
                children: [
                  Expanded(child: Text("Name")),
                  Expanded(child: Text("Amount"))
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: ref.read(SafeDataControllerProvider).getall(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white,
                          height: 75,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Expanded(child: Text(list[index].SafeName!)),
                              Expanded(
                                  child: Text(
                                      (list[index].Balance ?? 0).toString()))
                            ],
                          ),
                        );
                      },
                      itemCount: list.length,
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
