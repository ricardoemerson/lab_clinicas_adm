import 'package:flutter/material.dart';

import '../../../core/env/env.dart';

class CheckinImageAlertDialog extends AlertDialog {
  CheckinImageAlertDialog(
    BuildContext context, {
    super.key,
    required String imagePath,
  }) : super(
          content: Image.network(
            '${Env.backendBaseUrl}/$imagePath',
            fit: BoxFit.cover,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
}
