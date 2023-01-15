import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PDFview extends StatelessWidget {

  PDFview();

  @override
  Widget build(BuildContext context) {
    Widget child = const Center(child: CircularProgressIndicator());
      child =Container(

      );/*SfPdfViewer.memory(
        f!,
        key: _pdfViewerKey,
      );*/
    return Scaffold(
      appBar: AppBar(title: const Text('Pdf Viewer')),
      body: child,
    );
  }
}
