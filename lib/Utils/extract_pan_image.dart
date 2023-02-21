

//   Future<void> _onCapturePressed() async {
//     try {
//       final image = await _cameraController.takePicture();
//       final panNumber = await _extractPANNumber(image.path);
//       setState(() {
//         _panNumber = panNumber;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<String> _extractPANNumber(String imagePath) async {
//     final image = FirebaseVisionImage.fromFilePath(imagePath);
//     final textRecognizer = FirebaseVision.instance.textRecognizer();
//     final visionText = await textRecognizer.processImage(image);
//     final pattern = RegExp(r'[A-Z]{5}[0-9]{4}[A-Z]{1}');
//     for (final textBlock in visionText.blocks) {
//       final text = textBlock.text;
//       final match = pattern.firstMatch(text);
//       if (match != null) {
//         return match.group(0);
//       }
//     }
//     return null;
