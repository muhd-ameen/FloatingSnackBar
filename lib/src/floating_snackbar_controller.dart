import 'package:flutter/material.dart';

import 'floating_snackbar_widget.dart';

/// Internal description of a single queued snackbar request.
@immutable
class FloatingSnackBarRequest {
  /// Creates a request describing one snackbar to display.
  const FloatingSnackBarRequest(this.builder);

  /// Builds the snackbar widget, given the dismiss callback the controller
  /// supplies once the entry is inserted.
  final FloatingSnackBarWidget Function(VoidCallback onDismiss) builder;
}

/// Manages the lifecycle of floating snackbars within a single [OverlayState].
///
/// Holds at most one visible entry at a time. Additional requests are either
/// queued (default) or replace the current entry immediately.
class FloatingSnackBarController {
  /// Creates a controller bound to [overlay].
  FloatingSnackBarController(this.overlay);

  /// The overlay this controller inserts entries into.
  final OverlayState overlay;

  final List<FloatingSnackBarRequest> _queue = [];
  OverlayEntry? _current;
  bool _isShowing = false;

  /// Whether a snackbar is currently visible.
  bool get isShowing => _isShowing;

  /// Enqueues [request]. When [replace] is true, the current snackbar (and any
  /// queued ones) are dropped and [request] is shown immediately.
  void enqueue(FloatingSnackBarRequest request, {bool replace = true}) {
    if (replace) {
      _queue.clear();
      _queue.add(request);
      _removeCurrent();
      _showNext();
    } else {
      _queue.add(request);
      if (!_isShowing) _showNext();
    }
  }

  /// Dismisses the current snackbar (its exit animation still plays) and clears
  /// any queued requests.
  void dismiss() {
    _queue.clear();
    _removeCurrent();
  }

  void _removeCurrent() {
    _current?.remove();
    _current = null;
    _isShowing = false;
  }

  void _showNext() {
    if (_isShowing || _queue.isEmpty) return;
    final request = _queue.removeAt(0);
    _isShowing = true;

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => request.builder(() {
        // onDismiss: remove this entry, then advance the queue.
        if (_current == entry) {
          _current = null;
          _isShowing = false;
        }
        entry.remove();
        _showNext();
      }),
    );
    _current = entry;
    overlay.insert(entry);
  }
}
