import 'package:flutter/material.dart';

/// A widget that allows users to swipe left or right.
///
/// The widget supports swipe detection, optional removal after swipe,
/// and an optional scaling animation when dragging starts.
class EasySwipeWidget extends StatefulWidget {
  /// The child widget to be swiped.
  final Widget child;

  /// Callback function triggered when a swipe occurs.
  final void Function(SwipeDirection direction)? onSwipe;

  /// Whether the widget should be removed after a successful swipe.
  final bool removeAfterSwipe;

  /// The swipe threshold as a fraction of screen width (default: `0.3`).
  final double swipeThreshold;

  /// Enables or disables the scale animation on drag start (default: `true`).
  final bool enableScaleAnimation;

  /// Creates a swipeable widget with customizable behavior.
  const EasySwipeWidget({
    super.key,
    required this.child,
    this.onSwipe,
    this.removeAfterSwipe = false,
    this.swipeThreshold = 0.3, // 30% of the screen width
    this.enableScaleAnimation = true,
  });

  @override
  SwipeWidgetState createState() => SwipeWidgetState();
}

/// Enum representing swipe directions.
enum SwipeDirection { left, right }

/// State class managing the swipe interaction.
class SwipeWidgetState extends State<EasySwipeWidget>
    with TickerProviderStateMixin {
  late AnimationController _moveController;
  late AnimationController _scaleController;
  late Animation<double> _moveAnimation;
  late Animation<double> _scaleAnimation;

  Offset _offset = Offset.zero;
  bool _isRemoved = false;

  @override
  void initState() {
    super.initState();

    /// Controls the swipe animation (returns to original position if necessary).
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    /// Controls the scale animation when dragging starts.
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200), // Smooth scaling effect
      upperBound: 1.1, // Max scale (10% larger)
      lowerBound: 1.0, // Normal scale
    );

    _scaleAnimation = _scaleController;
  }

  @override
  void dispose() {
    _moveController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  /// Handles when the user starts dragging.
  void _onHorizontalDragStart(DragStartDetails details) {
    if (widget.enableScaleAnimation) {
      _scaleController.forward(); // Start scaling effect
    }
  }

  /// Updates the widget position as the user swipes.
  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offset += Offset(details.primaryDelta!, 0);
    });
  }

  /// Handles the end of a drag motion, either returning or removing the widget.
  void _onHorizontalDragEnd(DragEndDetails details) {
    double screenWidth = MediaQuery.of(context).size.width;
    double threshold = widget.swipeThreshold * screenWidth;

    if (widget.enableScaleAnimation) {
      _scaleController.reverse(); // Reset scale animation
    }

    if (_offset.dx.abs() > threshold) {
      // Determine swipe direction
      SwipeDirection direction =
          _offset.dx > 0 ? SwipeDirection.right : SwipeDirection.left;
      widget.onSwipe?.call(direction); // Trigger the callback

      if (widget.removeAfterSwipe) {
        setState(() {
          _offset = Offset.zero;
          _isRemoved = true; // Remove widget from the UI
        });
      } else {
        // Animate back to original position
        _moveAnimation =
            Tween<double>(begin: _offset.dx, end: 0).animate(_moveController)
              ..addListener(() {
                setState(() {
                  _offset = Offset(_moveAnimation.value, 0);
                });
              });

        _moveController.forward(from: 0);
      }
    } else {
      // Animate back to original position if below threshold
      _moveAnimation =
          Tween<double>(begin: _offset.dx, end: 0).animate(_moveController)
            ..addListener(() {
              setState(() {
                _offset = Offset(_moveAnimation.value, 0);
              });
            });

      _moveController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isRemoved && widget.removeAfterSwipe) return const SizedBox.shrink();

    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Transform.translate(
        offset: _offset,
        child: widget.enableScaleAnimation
            ? Transform.scale(
                scale: _scaleAnimation.value, // Apply scale effect
                child: widget.child,
              )
            : widget.child,
      ),
    );
  }
}
