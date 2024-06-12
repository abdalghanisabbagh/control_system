import 'package:flutter/foundation.dart' show VoidCallback, kIsWeb;
import 'package:flutter/material.dart'
    show BackButton, BuildContext, StatelessWidget, Widget;
import 'package:go_router/go_router.dart';
import 'package:universal_html/html.dart' show window;

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BackButton(
      onPressed: () {
        onPressed?.call();
        kIsWeb ? window.history.back() : context.pop();
      },
    );
  }
}
