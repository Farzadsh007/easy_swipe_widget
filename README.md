# 📦 EasySwipeWidget

[![pub package](https://img.shields.io/pub/v/easy_swipe_widget.svg)](https://pub.dev/packages/easy_swipe_widget)
[![GitHub stars](https://img.shields.io/github/stars/Farzadsh007/easy_swipe_widget.svg)](https://github.com/Farzadsh007/easy_swipe_widget)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A **customizable Flutter widget** that allows users to **swipe left or right** with optional **removal and smooth animations**.

---

## 🎬 Demo
<img src="https://raw.githubusercontent.com/Farzadsh007/easy_swipe_widget/master/example/swipe_widget_demo.gif" width="300" alt="swipe_widget_demo"/>

---

## ✨ Features
✔️ **Swipe left or right**  
✔️ **Remove widget on swipe** (optional)  
✔️ **Smooth scale animation** (optional)  
✔️ **Customizable swipe threshold**  
✔️ **Highly flexible & lightweight**

---

## 🚀 Installation

**1️⃣ Add dependency**
```yaml
dependencies:
  easy_swipe_widget: ^0.0.1
```
2️⃣ Import package

```yaml 
import 'package:easy_swipe_widget/easy_swipe_widget.dart';
```

🎯 Usage
Basic Example
```
EasySwipeWidget(
  removeAfterSwipe: false,
  enableScaleAnimation: true,
  onSwipe: (direction) {
    print("Swiped ${direction == SwipeDirection.left ? 'Left' : 'Right'}");
  },
  child: Container(
    padding: EdgeInsets.all(20),
    color: Colors.blue,
    child: Text(
      "Swipe me left or right!",
      style: TextStyle(color: Colors.white),
    ),
  ),
);
```
⚙️ Customization

| Property           | Type                | Default | Description                                                                 |
|--------------------|---------------------|---------|-----------------------------------------------------------------------------|
| child              | Widget              | -       | The content inside the swipeable area.                                     |
| onSwipe            | Function(SwipeDirection) | null    | Callback when the widget is swiped.                                      |
| removeAfterSwipe   | bool                | false   | Whether the widget should be removed after a successful swipe.               |
| swipeThreshold     | double              | 0.3     | Swipe threshold as a fraction of screen width.                             |
| enableScaleAnimation | bool                | true    | Enables scale animation when dragging.                                     |
💡 Example App
A full working example is available in the example/ folder.

🛠️ Contributing
If you find any issues or want to add new features, feel free to open an issue or submit a PR!

📜 License
This project is licensed under the MIT License.
See the LICENSE file for details.

