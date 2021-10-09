import 'package:flutter/cupertino.dart';
import 'package:shop_app/screen/upload_product_form.dart';

import 'bottom_bar.dart';

class MainScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [BottomBarScreen(), UploadProductForm()],
    );
  }
}
