/// Customizable floating snackbars/toasts for Flutter.
///
/// Two entry points:
///  * [floatingSnackBar] - the original one-line function (backward compatible).
///  * [FloatingSnackBar] - the rich API with variants, positioning, theming,
///    actions, progress, and context-free (overlay) display.
library;

export 'src/floating_snackbar.dart';
export 'src/floating_snackbar_api.dart';
export 'src/floating_snackbar_enums.dart';
export 'src/floating_snackbar_theme.dart';
export 'src/floating_snackbar_widget.dart'
    show FloatingSnackBarWidget, FloatingSnackBarAction;
