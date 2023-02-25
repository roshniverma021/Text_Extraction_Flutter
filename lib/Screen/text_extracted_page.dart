import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextExtractedPage extends StatefulWidget {
  final String? path;
  final String type;

  const TextExtractedPage({Key? key, this.path, required this.type})
      : super(key: key);

  @override
  State<TextExtractedPage> createState() => _TextExtractedPageState();
}

class _TextExtractedPageState extends State<TextExtractedPage> {
  bool _isLoading = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Text Extracted Page")),
        body: _isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  maxLines: MediaQuery.of(context).size.height.toInt(),
                  controller: controller,
                  decoration: const InputDecoration(
                      hintText: "Extracted Text goes here..."),
                ),
              ));
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isLoading = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    final panCardPattern = RegExp(r'[A-Z]{5}[0-9]{4}[A-Z]{1}');
    final aadhaarCardPattern = RegExp(r'^\d{4}\s\d{4}\s\d{4}$');

    for (final textBlock in recognizedText.blocks) {// textblock will have instance of TextBlock and textblock.text will have line wise text

      final text = textBlock.text;
      if (widget.type == 'pan') {
        final match = panCardPattern.firstMatch(text);
        if (match != null) {
          controller.text = text;
        }
      } else if (widget.type == 'aadhaar') {
        final match = aadhaarCardPattern.firstMatch(text);
        if (match != null) {
          controller.text = "Aadhaar Card Number is: ${text}";
        }
      }
    }
    if (controller.text == '')
      controller.text = "Wrong document uploaded/ image is not clear";

    //End processing state
    setState(() {
      _isLoading = false;
    });
  }
}
