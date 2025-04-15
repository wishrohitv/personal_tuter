import 'package:flutter/material.dart';
import 'package:project_tuter/configuration.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String appLanDropDownMenu = "en";
  @override
  void initState() {
    super.initState();
    _textEditingController.text = "Tuter";
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              right: 10.0, left: 10.0, top: 10.0, bottom: 5.0),
          child: Column(
            children: [
              // top bar
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.navigate_before,
                        size: 26.0,
                      )),
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  )
                ],
              ),
              Divider(),
              // content
              Text(
                "Adjust and utilize AI response",
                style: TextStyle(color: const Color.fromARGB(102, 0, 0, 0)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Your tutes's name"),
                  // SizedBox(width: 40.0,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration.collapsed(
                          hintText: "Your own name to AI"),
                      style: TextStyle(
                          color: const Color.fromARGB(255, 140, 7, 236)),
                      autofillHints: ["Akash sir", "Sapna mam", "shilpi man"],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Your grammmar level",
                  ),
                  DropdownButton(
                    value: "begginer",
                    items: [
                      DropdownMenuItem(
                          value: "begginer", child: Text("Begginer")),
                      DropdownMenuItem(value: "medium", child: Text("Medium")),
                      DropdownMenuItem(
                          value: "advanced", child: Text("Advanced"))
                    ],
                    onChanged: (value) {},
                  )
                ],
              ),
              Divider(),

              // App language
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 8.0,
                  children: [
                    Text(
                      "App language",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 15.0),
                      child: DropdownButton(
                        value: appLanDropDownMenu,
                        items: List.generate(
                          appLang.length,
                          (index) => DropdownMenuItem(
                            value: appLang[index].keys.first,
                            child: Text(
                              appLang[index].values.first,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            appLanDropDownMenu = value!;

                            appLanguage(value);
                          });
                          print(value);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Divider(),

              // About App
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("About App"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
