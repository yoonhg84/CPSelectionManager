# CPSelectionManager

다수의 UIButton 에서 다중 선택, 하나 선택 가능한 기능을 만들때 쉽게 이용해 보세요.

![Example](README/CPSelectionManager.gif)

## Installation

Support only [cocoapods](https://cocoapods.org).

### Podfile

```
pod 'CPSelectionManager'
```

## Usage

### Single selection
```
let selectionManager = CPSelectionManager()
selectionManager.addControl(button1)
selectionManager.addControl(button2)
selectionManager.selectionType = .Single
```

### Multi selection
```
let selectionManager = CPSelectionManager()
selectionManager.addControl(button1)
selectionManager.addControl(button2)
selectionManager.selectionType = .Multiple
```

### Callback
```
selectionManager.changedSelection = { manager in
    print(manager)
}
```

## License

MIT License
