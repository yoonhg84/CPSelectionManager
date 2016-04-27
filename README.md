# CPSelectionManager

다수의 UIButton 에서 다중 선택, 하나 선택 가능한 기능을 만들때 쉽게 이용해 보세요.

## Example

![Example](README/CPSelectionManager.gif)

## Usage

```
let selectionManager = CPSelectionManager()
selectionManager.addControl(button1)
selectionManager.addControl(button2)
selectionManager.addControl(button3)
selectionManager.addControl(button4)
selectionManager.addControl(button5)
selectionManager.selectionType = .Multiple
selectionManager.changedSelection = { manager in
}
```