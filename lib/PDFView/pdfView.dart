import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduationproject1/Cubit/cubitMainScreen.dart';

import '../Cubit/StateMainScreen.dart';

class PDFview extends StatelessWidget {

  PDFview();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitMainScreen,MainScreenState>(
      builder: (BuildContext context, state) {
        return   Scaffold(
          appBar: AppBar(title: const Text('Pdf Viewer')),
          body:Container()
          ,
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}
