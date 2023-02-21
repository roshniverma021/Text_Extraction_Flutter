import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class TextExtractedPage extends StatefulWidget {
  final String? path;
  const TextExtractedPage({Key? key, this.path}) : super(key: key);

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
        ) : Container(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            maxLines: MediaQuery.of(context).size.height.toInt(),
            controller: controller,
            decoration: const InputDecoration(hintText: "Extracted Text goes here..."),
          ),
        )
    );
  }

  void processImage(InputImage image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isLoading = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText = await textRecognizer.processImage(image);

    final pattern = RegExp(r'[A-Z]{5}[0-9]{4}[A-Z]{1}');
    for (final textBlock in recognizedText.blocks) {
      final text = textBlock.text;
      final match = pattern.firstMatch(text);
      if (match != null) {
        print("in regrex ");
        controller.text = text;
      }
    }
    if(controller.text == '')
      controller.text = "not found";
    // controller.text = recognizedText.text;

    //End processing state
    setState(() {
      _isLoading = false;
    });
  }
}