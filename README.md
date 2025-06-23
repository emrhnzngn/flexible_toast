<h1><code>flexible_toast</code></h1>
<p><a href="https://pub.dev/packages/flexible_toast"><img src="https://img.shields.io/pub/v/flexible_toast" alt="Pub Version"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
<a href="https://github.com/emrhnzngn/flexible_toast"><img src="https://img.shields.io/github/stars/emrhnzngn/flexible_toast?style=social" alt="Stars"></a></p>
<p>A highly customizable, transient notification system for Flutter, similar to Android's "Toast" or a simplified "Snackbar." Display beautiful, adaptable notifications at the top, center, or bottom of your screen that disappear automatically or can be dismissed by the user.</p>
<hr>
<h2>✨ Features</h2>
<ul>
<li><strong>Flexible Positioning:</strong> Display notifications at the top, center, or bottom of the screen.</li>
<li><strong>Customizable Content:</strong> Use simple strings for title and message, or provide custom widgets for full control.</li>
<li><strong>Notification Types:</strong> Built-in support for <code>success</code>, <code>warning</code>, and <code>error</code> types with default styling.</li>
<li><strong>Custom Icons &amp; Colors:</strong> Override default icons and background/text colors for each notification type or provide a general background color.</li>
<li><strong>Dismissible:</strong> Notifications can be dismissed by swiping or tapping a custom close icon.</li>
<li><strong>Auto-Dismiss:</strong> Configurable duration for automatic dismissal.</li>
<li><strong>Adaptive Height/Width:</strong> Notifications adapt to their content by default, with options for fixed dimensions.</li>
<li><strong>Callbacks:</strong> Execute a <code>VoidCallback</code> when the notification is dismissed.</li>
<li><strong>Single Instance:</strong> Ensures only one <code>CNotify</code> instance is active at a time to prevent UI clutter.</li>
</ul>
<hr>
<h2>📸 Screenshots &amp; Demos</h2>
<p><strong>Showcase the <code>flexible_toast</code> in action!</strong>
Replace these placeholders with actual images, GIFs, or short MP4s to demonstrate your notifications.</p>
<h3>Top Notification Example</h3>
![1](https://github.com/user-attachments/assets/856f7a9f-62ac-4a25-b095-08c0930a7fff)
<em>A brief description of what this demo shows (e.g., "A success notification appearing at the top").</em></p>
<h3>Center Notification Example</h3>
![2](https://github.com/user-attachments/assets/7eea448a-fefd-4a0b-9ae1-3cf2ca1a55e2)
<em>A brief description of what this demo shows (e.g., "A warning notification fading in at the center").</em></p>
<h3>Bottom Notification Example</h3>
![4](https://github.com/user-attachments/assets/2d9f9c35-7b14-450b-92de-a9b995b1cd43)
<em>A brief description of what this demo shows (e.g., "An error notification sliding up from the bottom").</em></p>
<h3>Custom Notification Example</h3>
![6](https://github.com/user-attachments/assets/d751164e-7461-4c0c-9629-04444e3deded)
<em>A brief description of what this demo shows (e.g., "A fully customized notification with a unique icon and colors." ).</em></p>
<hr>
<h2>🚀 Getting Started</h2>
<h3>1. Add to your <code>pubspec.yaml</code></h3>
<pre><code class="language-yaml">dependencies:
  flutter:
    sdk: flutter
  flexible_toast: ^latest_version # Use the latest version from pub.dev
</code></pre>
<p>Then, run <code>flutter pub get</code> in your project's root directory.</p>
<h3>2. Import it</h3>
<pre><code class="language-dart">import 'package:flexible_toast/flexible_toast.dart';
import 'package:flutter/material.dart'; // Make sure you import material.dart
</code></pre>
<hr>
<h2>💡 Usage Examples</h2>
<p>The <code>CNotify.show</code> static method is all you need!</p>
<h3>Basic Success Notification (Top)</h3>
<pre><code class="language-dart">ElevatedButton(
  onPressed: () {
    CNotify.show(
      context: context,
      title: 'Success!',
      message: 'Your operation was completed successfully.',
      type: NotifyType.success,
      position: NotifyPosition.top,
      duration: 3000, // 3 seconds
    );
  },
  child: const Text('Show Success (Top)'),
),
</code></pre>
<p>![1](https://github.com/user-attachments/assets/0cc5dfc0-be11-4e67-8b29-03856cef17b0)</p>
<h3>Warning Notification (Center)</h3>
<pre><code class="language-dart">ElevatedButton(
  onPressed: () {
    CNotify.show(
      context: context,
      title: 'Heads Up!',
      message: 'Something needs your attention. Please review.',
      type: NotifyType.warning,
      position: NotifyPosition.center,
      duration: 5000, // 5 seconds
    );
  },
  child: const Text('Show Warning (Center)'),
),
</code></pre>
<p>![2](https://github.com/user-attachments/assets/2c0f5eaf-fdfe-4a7f-89a7-cace96515127)</p>
<h3>Error Notification (Bottom)</h3>
<pre><code class="language-dart">ElevatedButton(
  onPressed: () {
    CNotify.show(
      context: context,
      title: 'Error Occurred!',
      message: 'Failed to save data. Please try again.',
      type: NotifyType.error,
      position: NotifyPosition.bottom,
      dismissDirection: DismissDirection.horizontal, // Can dismiss left/right
      closeCallBack: () {
        print('Error notification was dismissed!');
      },
    );
  },
  child: const Text('Show Error (Bottom)'),
),
</code></pre>

<p>![3](https://github.com/user-attachments/assets/a4b009bd-b230-4941-9902-6f18186365fc)</p>
<hr>
<h2>🎨 Customization</h2>
<p><code>flexible_toast</code> offers extensive customization options.</p>
<h3>Custom Icons and Colors</h3>
<pre><code class="language-dart">ElevatedButton(
  onPressed: () {
    CNotify.show(
      context: context,
      title: 'Custom Alert!',
      message: 'This is a notification with a custom look.',
      type: NotifyType.warning, // Can still use a type for defaults not overridden
      position: NotifyPosition.top,
      backgroundColor: Colors.deepPurple, // Overrides type-specific color
      successIcon: const Icon(Icons.star_rounded, color: Colors.amberAccent), // Custom icon for success
      titleColor: Colors.amberAccent,
      messageColor: Colors.white70,
      closeIcon: const Icon(Icons.close, color: Colors.white),
      elevation: 8.0,
      padding: const EdgeInsets.all(20.0), // More padding
    );
  },
  child: const Text('Show Custom Notification'),
),
</code></pre>

<p>![4](https://github.com/user-attachments/assets/f4bce8f3-17bf-441e-a288-c167a8b31eaa)</p>
<h3>Using Widgets for Title and Message</h3>
<p>You can provide any <code>Widget</code> for the title and message, giving you ultimate control over their appearance.</p>
<pre><code class="language-dart">ElevatedButton(
  onPressed: () {
    CNotify.show(
      context: context,
      titleWidget: Row(
        children: [
          Icon(Icons.thumb_up, color: Colors.lightGreenAccent),
          SizedBox(width: 8),
          Text(
            'Operation Complete!',
            style: TextStyle(
              color: Colors.lightGreenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
      messageWidget: Text(
        'All files have been successfully synchronized to the cloud.',
        style: TextStyle(color: Colors.white, fontSize: 13),
      ),
      backgroundColor: Colors.green.shade800,
      position: NotifyPosition.top,
      duration: 4000,
    );
  },
  child: const Text('Show Widget-Based Notification'),
),
</code></pre>

<p>![5](https://github.com/user-attachments/assets/bffcb246-6dc1-4916-8161-b284b1ca8b66)</p>
<h3>Fixed Height and Width</h3>
<pre><code class="language-dart">ElevatedButton(
  onPressed: () {
    CNotify.show(
      context: context,
      title: 'Fixed Size',
      message: 'This notification has a predefined height and width.',
      type: NotifyType.warning, // Assuming you add an warning type or use default
      backgroundColor: Colors.blueGrey,
      height: 80.0,
      width: 300.0,
      position: NotifyPosition.center,
    );
  },
  child: const Text('Show Fixed Size Notification'),
),
</code></pre>
<p>![6](https://github.com/user-attachments/assets/2671da60-a0aa-4e18-a84c-66a30752bade)</p>
<hr>
<h2>🤝 Contributing</h2>
<p>Contributions are welcome! If you find a bug or have a feature request, please open an issue on the <a href="https://github.com/emrhnzngn/flexible_toast/issues">GitHub repository</a>.</p>
<hr>
<h2>📄 License</h2>
<p>This package is released under the MIT License. See <code>LICENSE</code> file for more details.</p>
<hr>
<h2>👨‍💻 Author</h2>
<p><a href="https://github.com/emrhnzngn">emrhnzngn</a></p>
<hr>
