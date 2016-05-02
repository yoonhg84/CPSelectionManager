//
// Created by Chope on 2016. 4. 27..
// Copyright (c) 2016 Chope. All rights reserved.
//

import UIKit

public enum CPSelectionType {
    case Single
    case Multiple
    case LimitedMultiple(Int)
}

public enum CPSelectionErrorType: ErrorType {
    case WrongSelectionType
}

public class CPSelectionManager {
    public var selectionType = CPSelectionType.Single {
        didSet {
            self.unselectAll()
        }
    }
    public var changedSelection: ((CPSelectionManager) -> ())? = nil
    internal var controls = [UIControl]()

    public func addControl(control: UIControl) -> CPSelectionManager {
        control.addTarget(self, action: #selector(self.touchUpInsideAtControl(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.controls.append(control)
        return self
    }

    public func removeAllControls() -> CPSelectionManager {
        self.controls.removeAll()
        return self
    }

    public func selectAll() throws {
        switch self.selectionType {
        case .Multiple:
            if self.countOfSelection() != self.controls.count {
                for control in self.controls {
                    control.selected = true
                }
                self.changedSelection?(self);
            }
        default:
            throw CPSelectionErrorType.WrongSelectionType
        }
    }

    public func unselectAll() {
        for control in self.controls {
            control.selected = false
        }
        self.changedSelection?(self);
    }

    public func selectedControls() -> [UIControl] {
        return self.controls.filter({ $0.selected })
    }

    public func countOfSelection() -> Int {
        return self.selectedControls().count
    }

    @objc func touchUpInsideAtControl(control: UIControl) {
        switch self.selectionType {
        case .Single:
            self.unselectAll()
            control.selected = !control.selected
        case .Multiple:
            control.selected = !control.selected
        case .LimitedMultiple(let maxCount):
            if control.selected {
                control.selected = false
            } else if self.countOfSelection() < maxCount {
                control.selected = !control.selected
            } else {
                return
            }
        }

        self.changedSelection?(self);
    }
}
