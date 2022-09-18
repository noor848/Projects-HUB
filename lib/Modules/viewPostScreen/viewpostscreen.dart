import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ViewPostScreen extends StatelessWidget {
  const ViewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("View Post Screen")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network("https://assets.entrepreneur.com/content/3x2/2000/1391122457-10-most-have-ingredients-successful-invention.jpg"),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("An invention is a unique or novel device,method,"
                  "composition or process. The invention process is a process within an overall engineering and product development process. It may be an improvement upon a machine or product or a new process for creating an object or a result."
                  " An invention that achieves a completely unique function or result may be a radical breakthrough. Such works are novel and "
                  "not obvious to others skilled in the same field. An inventor may be taking a big step toward success or failure.Some inventions can be patented. The system of patents was established to encourage inventors by granting limited-term, limited monopoly on inventions determined to be sufficiently novel, non-obvious, and useful. A patent legally protects the intellectual property rights of the inventor and legally recognizes that a claimed invention is actually an invention. The rules and requirements for patenting an invention vary by country and the process of obtaining a patent is often expensive.",
              maxLines: 15,
                overflow: TextOverflow.ellipsis,
              ),
            )
            
          ],
        ),
      ),
      
      
    );
  }
}
