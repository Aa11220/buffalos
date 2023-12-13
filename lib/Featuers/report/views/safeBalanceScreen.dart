import 'package:buffalos/Featuers/report/controller/SafeDataController.dart';
import 'package:buffalos/models/SafeData.dart';
import 'package:buffalos/utility/commonwidget/appbar.dart';
import 'package:buffalos/utility/commonwidget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utility/lineargragr.dart';

class SafeDataScreen extends ConsumerStatefulWidget {
  const SafeDataScreen({super.key});
  static const path = "/safeDataScreen";
  @override
  ConsumerState<SafeDataScreen> createState() => _SafeDataState();
}

class _SafeDataState extends ConsumerState<SafeDataScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: linear,
        ),
        child: Scaffold(
          appBar: Customappbar(text: "Safe Data"),
          drawer: MyDrawer(context),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
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
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.white,
                          height: 75,
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(snapshot.data![index].SafeName!)),
                              Expanded(
                                  child: Text(
                                      (snapshot.data![index].Balance ?? 0)
                                          .toString()))
                            ],
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
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
