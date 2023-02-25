import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Screen/text_extracted_page.dart';
import '../Utils/image_cropper_part.dart';
import '../Utils/image_picker_class.dart';
import 'image_dialog_modal.dart';

class pan_card_extraction extends StatelessWidget {
  const pan_card_extraction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onPress(BuildContext context) {
      imagePickerModal(context, onCameraTap: () {
        log("Camera");
        pickImage(source: ImageSource.camera).then((value) {
          if (value != '') {
            imageCropperView(value, context).then((value) {
              if (value != '') {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => TextExtractedPage(
                      path: value,
                      type: 'pan',
                    ),
                  ),
                );
              }
            });
          }
        });
      }, onGalleryTap: () {
        log("Gallery");
        pickImage(source: ImageSource.gallery).then((value) {
          if (value != '') {
            imageCropperView(value, context).then((value) {
              if (value != '') {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => TextExtractedPage(
                      path: value,
                      type: 'pan',
                    ),
                  ),
                );
              }
            });
          }
        });
      });
    }

    return Card(
      elevation: 0,
      color: Colors.blue,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          onPress(context);
        },
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Center(child: Text('Scan PAN card number')),
        ),
      ),
    );
  }
}
