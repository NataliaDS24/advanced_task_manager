import 'package:advanced_task_manager/config/config_imports.dart';

class ResponseGeneral {
  final String message;
  final bool status;

  const ResponseGeneral({
    this.message = AppStrings.voidText,
    this.status = false,
  });

  factory ResponseGeneral.success(
    String message,
  ) =>
      ResponseGeneral(
        message: message,
        status: true,
      );

  factory ResponseGeneral.failed(
    String message,
  ) =>
      ResponseGeneral(
        message: message,
        status: false,
      );
}
