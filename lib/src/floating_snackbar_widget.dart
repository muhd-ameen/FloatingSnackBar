import 'package:flutter/material.dart';

import 'floating_snackbar_enums.dart';
import 'floating_snackbar_theme.dart';

/// A tappable action rendered on the trailing edge of a floating snackbar.
@immutable
class FloatingSnackBarAction {
  /// Creates an action with a [label] and an [onPressed] callback.
  const FloatingSnackBarAction({
    required this.label,
    required this.onPressed,
    this.textColor,
    this.dismissOnPressed = true,
  });

  /// The button label.
  final String label;

  /// Invoked when the action is tapped.
  final VoidCallback onPressed;

  /// Optional color for the action label (defaults to the snackbar text color).
  final Color? textColor;

  /// Whether tapping the action also dismisses the snackbar. Defaults to true.
  final bool dismissOnPressed;
}

/// The visual card for a floating snackbar.
///
/// This is an internal widget driven by the overlay controller. It animates
/// itself in on insertion using [animation], and calls [onDismiss] once its
/// exit animation completes so the controller can remove it.
class FloatingSnackBarWidget extends StatefulWidget {
  /// Creates the visual snackbar card.
  const FloatingSnackBarWidget({
    super.key,
    required this.message,
    required this.theme,
    required this.type,
    required this.position,
    required this.animation,
    required this.duration,
    required this.onDismiss,
    this.title,
    this.leading,
    this.action,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.titleStyle,
    this.dismissOnTap = false,
    this.showProgress = false,
  });

  /// The body text.
  final String message;

  /// The active theme used to resolve unset styling.
  final FloatingSnackBarTheme theme;

  /// The semantic type, controlling default color/icon.
  final FloatingSnackBarType type;

  /// Screen anchor.
  final FloatingSnackBarPosition position;

  /// Entrance/exit animation.
  final FloatingSnackBarAnimation animation;

  /// Visible duration before auto-dismiss.
  final Duration duration;

  /// Called when the card has finished its exit animation and should be
  /// removed from the overlay.
  final VoidCallback onDismiss;

  /// Optional bold title shown above [message].
  final String? title;

  /// Optional leading widget (usually an [Icon]). Overrides the type's default
  /// icon when provided.
  final Widget? leading;

  /// Optional trailing action button.
  final FloatingSnackBarAction? action;

  /// Background color override.
  final Color? backgroundColor;

  /// Text color override.
  final Color? textColor;

  /// Message text style override.
  final TextStyle? textStyle;

  /// Title text style override.
  final TextStyle? titleStyle;

  /// Whether tapping the card dismisses it.
  final bool dismissOnTap;

  /// Whether to render a countdown progress bar.
  final bool showProgress;

  @override
  State<FloatingSnackBarWidget> createState() => _FloatingSnackBarWidgetState();
}

class _FloatingSnackBarWidgetState extends State<FloatingSnackBarWidget>
    with TickerProviderStateMixin {
  late final AnimationController _enterController;
  late final AnimationController _progressController;
  bool _dismissing = false;

  @override
  void initState() {
    super.initState();
    _enterController = AnimationController(
      vsync: this,
      duration: widget.theme.animationDuration,
    )..forward();

    _progressController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _dismiss();
      }
    });
  }

  @override
  void dispose() {
    _enterController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _dismiss() async {
    if (_dismissing) return;
    _dismissing = true;
    _progressController.stop();
    if (mounted) {
      await _enterController.reverse();
    }
    widget.onDismiss();
  }

  Color get _background =>
      widget.backgroundColor ?? widget.theme.backgroundColorFor(widget.type);

  Color get _textColor => widget.textColor ?? widget.theme.textColor;

  Widget? _buildLeading() {
    if (widget.leading != null) return widget.leading;
    final icon = widget.theme.iconFor(widget.type);
    if (icon == null) return null;
    return Icon(icon, color: _textColor);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;
    final isTop = widget.position == FloatingSnackBarPosition.top;

    final messageStyle = (theme.textStyle ?? const TextStyle())
        .copyWith(color: _textColor)
        .merge(widget.textStyle);
    final titleStyle =
        (theme.titleStyle ?? const TextStyle(fontWeight: FontWeight.bold))
            .copyWith(color: _textColor)
            .merge(widget.titleStyle);

    final leading = _buildLeading();

    Widget content = Material(
      color: Colors.transparent,
      child: Container(
        padding: theme.padding,
        decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.circular(theme.borderRadius),
          boxShadow: theme.elevation > 0
              ? [
                  BoxShadow(
                    color: Colors.black.withAlpha(60),
                    blurRadius: theme.elevation * 2,
                    offset: Offset(0, theme.elevation / 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (leading != null) ...[
                  leading,
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.title != null)
                        Text(widget.title!, style: titleStyle),
                      Text(widget.message, style: messageStyle),
                    ],
                  ),
                ),
                if (widget.action != null) ...[
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      widget.action!.onPressed();
                      if (widget.action!.dismissOnPressed) _dismiss();
                    },
                    child: Text(
                      widget.action!.label,
                      style: TextStyle(
                        color: widget.action!.textColor ?? _textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (widget.showProgress)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: AnimatedBuilder(
                    animation: _progressController,
                    builder: (context, _) => LinearProgressIndicator(
                      value: 1.0 - _progressController.value,
                      minHeight: 3,
                      backgroundColor: _textColor.withAlpha(40),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _textColor.withAlpha(180),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    if (widget.dismissOnTap) {
      content = GestureDetector(onTap: _dismiss, child: content);
    }

    // Swipe-to-dismiss.
    content = Dismissible(
      key: const ValueKey('floating_snackbar_dismissible'),
      direction: DismissDirection.horizontal,
      onDismissed: (_) {
        _dismissing = true;
        _progressController.stop();
        widget.onDismiss();
      },
      child: content,
    );

    content = _applyEntrance(content, isTop);

    return Positioned(
      top: isTop ? 0 : null,
      bottom: isTop ? null : 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(padding: theme.margin, child: content),
      ),
    );
  }

  Widget _applyEntrance(Widget child, bool isTop) {
    final curved = CurvedAnimation(
      parent: _enterController,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    switch (widget.animation) {
      case FloatingSnackBarAnimation.fade:
        return FadeTransition(opacity: curved, child: child);
      case FloatingSnackBarAnimation.scale:
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.85, end: 1.0).animate(curved),
            child: child,
          ),
        );
      case FloatingSnackBarAnimation.slide:
        final begin = Offset(0, isTop ? -1.2 : 1.2);
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position:
                Tween<Offset>(begin: begin, end: Offset.zero).animate(curved),
            child: child,
          ),
        );
    }
  }
}
