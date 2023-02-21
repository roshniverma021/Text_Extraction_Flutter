import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_extraction/Utils/image_picker_class.dart';
import 'Screen/text_extracted_page.dart';
import 'Utils/image_cropper_part.dart';
import 'Widgets/modal_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload Documents',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Upload Documents'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 0,
              color: Colors.blue,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              imagePickerModal(context, onCameraTap: () {
                log("Camera");
                pickImage(source: ImageSource.camera).then((value){
                  if(value != ''){
                    imageCropperView(value, context).then((value) {
                      if (value != '') {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => TextExtractedPage(
                              path: value,
                            ),
                          ),
                        );
                      }
                    });
                  }
                });
              }, onGalleryTap: () {
                log("Gallery");
                pickImage(source: ImageSource.gallery).then((value){
                  if(value != ''){
                    imageCropperView(value, context).then((value) {
                      if (value != '') {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => TextExtractedPage(
                              path: value,
                            ),
                          ),
                        );
                      }
                    });
                  }
                });
              });
            },
              child: const SizedBox(
                width: 300,
                height: 100,
                child: Center(child: Text('Scan Text')),
              ),
          ),
            ),
          ],
        ),
      ),
    );
  }
}
