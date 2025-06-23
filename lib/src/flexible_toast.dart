import 'package:flexible_toast/src/src.dart';
import 'package:flutter/material.dart';

/// A customizable, transient notification class (similar to toast/snackbar).
/// These notifications appear at the top, center, or bottom of the screen
/// and disappear after a specified duration or when dismissed by the user.
class CNotify {
  final String? title; // Optional string title for the notification.
  final Widget?
  titleWidget; // Optional custom widget for the notification title. If both are provided, titleWidget takes precedence.
  final int?
  duration; // Duration in milliseconds the notification stays on screen. Defaults to 5000ms.
  final NotifyType?
  type; // Type of notification (success, warning, error). Defaults to NotifyType.error.
  final String? message; // The main string message of the notification.
  final Widget?
  messageWidget; // Optional custom widget for the notification message. If both are provided, messageWidget takes precedence.
  final Widget? successIcon; // Custom icon for success notifications.
  final Color? successIconColor; // Custom icon color for success notifications.
  final Widget? warningIcon; // Custom icon for warning notifications.
  final Color? warningIconColor; // Custom icon color for warning notifications.
  final Widget? errorIcon; // Custom icon for error notifications.
  final Color? errorIconColor; // Custom icon color for error notifications.
  final Color?
  successColor; // Custom background color for success notifications. Defaults to Colors.blue.
  final Color?
  warningColor; // Custom background color for warning notifications. Defaults to Colors.orange.
  final Color?
  errorColor; // Custom background color for error notifications. Defaults to Colors.red.
  final Color?
  backgroundColor; // Custom background color for the notification card, overrides type-specific colors.
  final Color?
  titleColor; // Custom title text color for the notification. Defaults to Colors.white.
  final Color?
  messageColor; // Custom message text color for the notification. Defaults to Colors.white.
  final Widget? closeIcon; // Custom close icon for the notification.
  final Color?
  closeColor; // Custom close icon color for the notification. Defaults to Colors.white.
  final double?
  height; // Optional fixed height for the notification card. If null, the height adapts to content.
  final double?
  width; // Optional fixed width for the notification card. If null, the width adapts to content.
  final double?
  elevation; // Optional custom elevation (shadow depth) for the notification card. Defaults to 4.
  final EdgeInsets?
  padding; // Optional custom padding around the notification card. Defaults vary based on position.
  final DismissDirection?
  dismissDirection; // Optional custom dismiss direction for the swipe-to-dismiss gesture. Defaults to DismissDirection.up.
  final NotifyPosition
  position; // Position where the notification will be displayed (top, center, bottom). Defaults to NotifyPosition.top.

  bool _isOpen = false; // Indicates whether the notification is currently open.
  late OverlayEntry
  _overlayEntry; // The OverlayEntry where the notification is displayed.
  late AnimationController
  _animationController; // Controls the entrance/exit animation of the notification.
  VoidCallback?
  closeCallBack; // Callback function to be executed when the notification is dismissed.

  // Static variable: Keeps track of the currently active CNotify instance.
  // This ensures that only one notification is shown at a time to prevent UI clutter.
  static CNotify? _currentNotify;

  /// Private constructor to enforce static `show` method usage.

  CNotify._({
    required OverlayEntry overlayEntry,
    this.duration,
    this.title,
    this.titleWidget,
    this.type,
    this.message,
    this.messageWidget,
    this.successIcon,
    this.successIconColor,
    this.warningIcon,
    this.warningIconColor,
    this.errorIcon,
    this.errorIconColor,
    this.successColor,
    this.warningColor,
    this.errorColor,
    this.backgroundColor,
    this.closeIcon,
    this.closeColor,
    this.titleColor,
    this.messageColor,
    this.height,
    this.width,
    this.elevation,
    this.padding,
    this.dismissDirection,
    this.closeCallBack,
    required this.position,
  }) : _overlayEntry = overlayEntry {
    _animationController = AnimationController(
      vsync: tickerProviderService,
      duration: const Duration(
        milliseconds: 400,
      ), // Animation duration for slide in/out
    );
    _showInternal();
  }

  /// Displays a customizable notification on the screen.
  ///
  /// Before a new notification is displayed, any currently active notification will be dismissed.
  ///
  /// **Parameters:**
  /// - `context`: The `BuildContext` to access the `OverlayState` for displaying the notification.
  /// - `title`: An optional string title for the notification.
  /// - `titleWidget`: An optional custom widget for the notification title. If both `title` and `titleWidget` are provided, `titleWidget` takes precedence.
  /// - `message`: The main string message of the notification.
  /// - `messageWidget`: An optional custom widget for the notification message. If both `message` and `messageWidget` are provided, `messageWidget` takes precedence.
  /// - `duration`: The time in milliseconds the notification remains visible. Defaults to 5000ms.
  /// - `type`: Defines the notification's category (e.g., success, warning, error). Defaults to `NotifyType.error`.
  /// - `successIcon`, `warningIcon`, `errorIcon`: Optional custom widgets for the respective notification type icons. If not provided, default Material Icons are used.
  /// - `successIconColor`, `warningIconColor`, `errorIconColor`: Optional custom colors for the respective type icons.
  /// - `successColor`, `warningColor`, `errorColor`: Optional custom background colors for the notification card based on type.
  /// - `backgroundColor`: An optional custom background color for the notification card that overrides type-specific colors.
  /// - `titleColor`: An optional custom color for the title text. Defaults to `Colors.white`.
  /// - `messageColor`: An optional custom color for the message text. Defaults to `Colors.white`.
  /// - `closeIcon`: An optional custom widget for the close icon.
  /// - `closeColor`: An optional custom color for the close icon.
  /// - `height`: An optional fixed height for the notification card. If null, height adapts to content.
  /// - `width`: An optional fixed width for the notification card. If null, width adapts to content.
  /// - `elevation`: An optional custom elevation (shadow depth) for the notification card. Defaults to 4.
  /// - `padding`: An optional `EdgeInsets` for spacing around the notification card. Defaults vary by `position` (e.g., `EdgeInsets.all(12.0).copyWith(top: kToolbarHeight)` for `NotifyPosition.top`).
  /// - `dismissDirection`: An optional `DismissDirection` for the swipe-to-dismiss gesture. Defaults to `DismissDirection.up`.
  /// - `position`: Determines where the notification appears on the screen (top, center, bottom). Defaults to `NotifyPosition.top`.
  /// - `closeCallBack`: A callback function executed when the notification is dismissed (via swipe, close icon, or timeout).
  static void show({
    required BuildContext context,
    String? title,
    Widget? titleWidget,
    String? message,
    Widget? messageWidget,
    int? duration,
    NotifyType type = NotifyType.error, // Default notification type: error
    Widget? successIcon, // Custom icon for success notifications
    Color? successIconColor, // Custom icon color for success notifications
    Widget? warningIcon, // Custom icon for warning notifications
    Color? warningIconColor, // Custom icon color for warning notifications
    Widget? errorIcon, // Custom icon for error notifications
    Color? errorIconColor, // Custom icon color for error notifications
    Color? successColor, // Custom background color for success notifications
    Color? warningColor, // Custom background color for warning notifications
    Color? errorColor, // Custom background color for error notifications
    Color? backgroundColor, // Custom background color for any notification type
    Color? titleColor, // Custom title text color
    Color? messageColor, // Custom message text color
    Widget? closeIcon, // Custom close icon
    Color? closeColor, // Custom close icon color
    double? height, // Optional custom height for the notification card
    double? elevation, // Optional custom elevation for the notification card
    double? width, // Optional custom width for the notification card
    EdgeInsets? padding, // Optional custom padding around the notification card
    DismissDirection? dismissDirection, // Optional custom dismiss direction
    NotifyPosition position = NotifyPosition.top, // Default position: top
    VoidCallback? closeCallBack, // Add closeCallBack parameter
  }) {
    // Before displaying a new notification, dismiss any currently active notification
    if (_currentNotify != null && _currentNotify!._isOpen) {
      _currentNotify!
          ._dismissInternal(); // Call dismiss on the old notification
    }

    final overlay = Overlay.of(context);
    // Create a temporary OverlayEntry. The actual builder will be set in _showInternal.
    final overlayEntry = OverlayEntry(builder: (ctx) => Container());

    _currentNotify = CNotify._(
      overlayEntry: overlayEntry, // Pass the created OverlayEntry
      duration: duration,
      title: title,
      titleWidget: titleWidget,
      message: message,
      messageWidget: messageWidget,
      type: type,
      successIcon: successIcon,
      successIconColor: successIconColor,
      warningIcon: warningIcon,
      warningIconColor: warningIconColor,
      errorIcon: errorIcon,
      errorIconColor: errorIconColor,
      successColor: successColor,
      warningColor: warningColor,
      errorColor: errorColor,
      closeColor: closeColor,
      closeIcon: closeIcon,
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      messageColor: messageColor,
      height: height,
      width: width,
      elevation: elevation,
      padding: padding,
      dismissDirection: dismissDirection,
      position: position,
      closeCallBack: closeCallBack,
    );

    overlay.insert(_currentNotify!._overlayEntry);
  }

  /// Internal method to handle showing the notification content within the OverlayEntry.
  void _showInternal() {
    _animationController.forward(); // Start the entrance animation
    _isOpen = true; // Mark the notification as open

    // Determine the icon based on type and custom icons provided
    Widget currentIcon;
    switch (type) {
      case NotifyType.success:
        currentIcon =
            successIcon ??
            Icon(
              Icons.check_circle_rounded,
              color: successIconColor ?? Colors.white,
              size: 24.0,
            );
        break;
      case NotifyType.warning:
        currentIcon =
            warningIcon ??
            Icon(
              Icons.warning_rounded,
              color: warningIconColor ?? Colors.white,
              size: 24.0,
            );
        break;
      case NotifyType.error:
        currentIcon =
            errorIcon ??
            Icon(
              Icons.error_rounded,
              color: errorIconColor ?? Colors.white,
              size: 24.0,
            );
        break;
      default:
        currentIcon = Icon(
          Icons.info_rounded,
          color: successIconColor ?? Colors.white,
          size: 24.0,
        );
    }

    // Determine the background color for the card. Custom `backgroundColor` parameter takes precedence.
    Color finalBackgroundColor;
    if (backgroundColor != null) {
      finalBackgroundColor = backgroundColor!;
    } else {
      switch (type) {
        case NotifyType.error:
          finalBackgroundColor = errorColor ?? Colors.red;
          break;
        case NotifyType.success:
          finalBackgroundColor = successColor ?? Colors.blue;
          break;
        case NotifyType.warning:
          finalBackgroundColor =
              warningColor ??
              Colors.orange; // Using orange for warning for distinctness
          break;
        default:
          finalBackgroundColor =
              Colors.grey; // Default color if type is null or unrecognized
      }
    }

    // Determine the text colors
    final Color finalTitleColor = titleColor ?? Colors.white;
    final Color finalMessageColor = messageColor ?? Colors.white;

    // Define alignment and animation offsets based on notification position
    AlignmentGeometry alignment;
    Offset beginOffset;
    Widget transitionWidget;

    switch (position) {
      case NotifyPosition.top:
        alignment = Alignment.topCenter;
        beginOffset = const Offset(0.0, -1.0);
        transitionWidget = SlideTransition(
          position: Tween<Offset>(
            begin: beginOffset,
            end: const Offset(0, 0),
          ).animate(_animationController),
          child: _buildNotificationCard(
            finalBackgroundColor,
            currentIcon,
            finalTitleColor,
            finalMessageColor,
          ),
        );
        break;
      case NotifyPosition.bottom:
        alignment = Alignment.bottomCenter;
        beginOffset = const Offset(0.0, 1.0);
        transitionWidget = SlideTransition(
          position: Tween<Offset>(
            begin: beginOffset,
            end: const Offset(0, 0),
          ).animate(_animationController),
          child: _buildNotificationCard(
            finalBackgroundColor,
            currentIcon,
            finalTitleColor,
            finalMessageColor,
          ),
        );
        break;
      case NotifyPosition.center:
        alignment = Alignment.center;
        // For center, a fade transition usually looks better than slide
        transitionWidget = FadeTransition(
          opacity: _animationController,
          child: _buildNotificationCard(
            finalBackgroundColor,
            currentIcon,
            finalTitleColor,
            finalMessageColor,
          ),
        );
        break;
    }

    // Re-assign _overlayEntry with the actual builder that builds the notification UI.
    _overlayEntry = OverlayEntry(
      builder: (context) {
        // Default padding adjusted based on position
        EdgeInsets defaultPadding;
        if (position == NotifyPosition.top) {
          defaultPadding = const EdgeInsets.all(
            12.0,
          ).copyWith(top: kToolbarHeight); // Account for status bar
        } else if (position == NotifyPosition.bottom) {
          defaultPadding = const EdgeInsets.all(
            12.0,
          ).copyWith(bottom: kToolbarHeight); // Account for nav bar
        } else {
          defaultPadding = const EdgeInsets.all(
            12.0,
          ); // Generic padding for center
        }

        return Align(
          // Aligns the notification to the specified position
          alignment: alignment,
          child: Material(
            // Provides proper handling for Card's elevation and shape
            color: Colors.transparent, // Make background transparent
            child: Column(
              // Arranges content vertically
              mainAxisSize: MainAxisSize
                  .min, // Column takes minimum vertical space required by its children
              children: [
                // Allows the user to dismiss the notification by swiping.
                Dismissible(
                  key:
                      UniqueKey(), // A unique key is required for each Dismissible
                  direction:
                      dismissDirection ??
                      DismissDirection
                          .up, // Use custom dismiss direction or default to up
                  onDismissed: (direction) {
                    _dismissInternal(); // Call the internal dismiss method when the notification is dismissed
                  },
                  // The actual notification content with its animation and padding
                  child: Padding(
                    padding:
                        padding ??
                        defaultPadding, // Use custom padding or default based on position
                    child: transitionWidget, // The animated notification card
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Starts a timer to automatically dismiss the notification after the specified duration.
    Future.delayed(Duration(milliseconds: duration ?? 5000), () {
      _dismissInternal(); // Call internal dismiss method when the timer finishes
    });
  }

  /// Builds the core notification card content.
  Widget _buildNotificationCard(
    Color cardColor,
    Widget icon,
    Color titleTxtColor,
    Color messageTxtColor,
  ) {
    Widget card = Card(
      // Visual container for the notification (card)
      color: cardColor, // Background color based on type or custom color
      elevation: elevation ?? 4, // Card's shadow depth or default
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      margin: EdgeInsets.zero, // Margin set to zero as outer padding is used
      child: Padding(
        // Inner padding for the card's content
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          // Arranges icon, title, and message horizontally
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize
              .min, // Row takes minimum horizontal space required by its children
          children: [
            icon, // Dynamic icon based on notification type or custom widget
            const SizedBox(width: 10.0), // Space between icon and text
            Expanded(
              // Title and message expand to fill available space
              child: Column(
                // Arranges title and message vertically
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize
                    .min, // Column takes minimum vertical space required by its children
                children: [
                  if (title != null ||
                      titleWidget !=
                          null) // Show title if provided as string or widget
                    titleWidget ??
                        Text(
                          title!, // Use non-nullable version as it's checked by if
                          style: TextStyle(
                            fontSize: 14.0, // Fixed font size
                            fontWeight: FontWeight.bold, // Bold for title
                            color: titleTxtColor, // Title text color
                          ),
                        ),
                  if (message != null ||
                      messageWidget !=
                          null) // Show message if provided as string or widget
                    messageWidget ??
                        Text(
                          // Show message
                          message ?? "",
                          style: TextStyle(
                            fontSize: 12.0, // Fixed font size
                            color: messageTxtColor, // Message text color
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(width: 10.0), // Space between text and close icon
            InkWell(
              // Tappable area for the close icon
              onTap: () {
                // Invoke the onClose callback if it's not null
                _dismissInternal(); // Call internal dismiss method when close icon is tapped
              },
              child:
                  closeIcon ??
                  Icon(
                    Icons.cancel, // Close icon
                    color:
                        closeColor ??
                        Colors.white, // Default color for close icon
                  ),
            ),
          ],
        ),
      ),
    );

    // Apply custom height and width if provided
    if (width != null || height != null) {
      card = SizedBox(width: width, height: height, child: card);
    }
    return card;
  }

  /// Manually dismisses the current notification.
  ///
  /// This method is intended for internal use via the static `show` method,
  /// or triggered by user interaction (swipe, close icon tap) or automatic timeout.
  /// It handles the animation reversal, removes the overlay entry,
  /// clears the static reference to this notification, and invokes the `closeCallBack`.

  void _dismissInternal() {
    if (_isOpen) {
      _animationController.reverse().then((_) {
        if (_overlayEntry.mounted) {
          _overlayEntry.remove();
        }
        if (_currentNotify == this) {
          _currentNotify = null; // Clear the static reference
        }
        closeCallBack?.call();
      });
      _isOpen = false;
    }
  }
}
