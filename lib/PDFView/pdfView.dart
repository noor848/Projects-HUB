
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFView extends StatelessWidget {
  Uint8List? f;
  PDFView(this.f);
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget child = const Center(child: CircularProgressIndicator());
    if (f != null) {
      child = SfPdfViewer.memory(
        f!,
        key: _pdfViewerKey,
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Pdf Viewer')),
      body: child,
    );
  }
}
