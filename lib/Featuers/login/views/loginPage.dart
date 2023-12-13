import '../Controller/loginController.dart';
import '../../../utility/lineargragr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class loginPage extends ConsumerStatefulWidget {
  const loginPage({super.key});

  @override
  ConsumerState<loginPage> createState() => _loginPageState();
}

class _loginPageState extends ConsumerState<loginPage> {
  var loading = false;
  String _email = "";
  String _password = "";
  bool _secuired = true;
  final _formKey = GlobalKey<FormState>();
  void save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        loading = true;
      });
      await ref
          .read(loginControllerProvider)
          .signincont(_email, _password, context);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xffF89321),
            Color(0xffF15A2B),
          ]),
        ),
        child: Scaffold(
          body: loading == true
              ? const Center(child: CircularProgressIndicator.adaptive())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: .3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .33,
                          child: Center(
                            child: Image.asset(
                              height: 100,
                              "assets/img/image005.png",
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .62,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: constraints.maxWidth * .01,
                                    vertical: constraints.maxHeight * .05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19),
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * .1,
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text("User name"),
                                            SizedBox(
                                              height:
                                                  constraints.maxHeight * .03,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please Enter valid email";
                                                }
                                                return null;
                                              },
                                              onSaved: (newValue) {
                                                _email = newValue!;
                                              },
                                              decoration: InputDecoration(
                                                hintText: "Enter your Email",
                                                prefixIcon:
                                                    const Icon(Icons.lock),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  constraints.maxHeight * .04,
                                            ),
                                            const Text("Password"),
                                            SizedBox(
                                              height:
                                                  constraints.maxHeight * .04,
                                            ),
                                            TextFormField(
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Please password valid email";
                                                }
                                                return null;
                                              },
                                              onSaved: (newValue) {
                                                _password = newValue!;
                                              },
                                              autocorrect: false,
                                              obscureText: _secuired,
                                              decoration: InputDecoration(
                                                hintText: "Enter your password",
                                                prefixIcon:
                                                    const Icon(Icons.lock),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _secuired = !_secuired;
                                                    });
                                                  },
                                                  icon: _secuired == false
                                                      ? const Icon(Icons
                                                          .remove_red_eye_outlined)
                                                      : const Icon(
                                                          Icons.remove_red_eye),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  constraints.maxHeight * .03,
                                            ),
                                            SizedBox(
                                              width: constraints.maxWidth,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    width:
                                                        constraints.maxWidth *
                                                            .46,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        gradient: linear),
                                                    child: TextButton(
                                                      style: TextButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          splashFactory: NoSplash
                                                              .splashFactory),
                                                      onPressed: () {},
                                                      child: const Text(
                                                          "Login to MQQ"),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        constraints.maxWidth *
                                                            .46,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        gradient: linear),
                                                    child: TextButton(
                                                      style: TextButton.styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          splashFactory: NoSplash
                                                              .splashFactory),
                                                      onPressed: () {
                                                        save();
                                                      },
                                                      child: const Text(
                                                          "Login to ezdan"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ]),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
