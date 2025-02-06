import 'package:airline_app/screen/app_widgets/divider_widget.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const AppbarWidget({
    super.key,
    required this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: onBackPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_sharp),
              onPressed: onBackPressed,
            )
          : null,
      centerTitle: true,
      title: Text(
        title,
        style: AppStyles.textStyle_18_600,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: DividerWidget(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.2);
}
