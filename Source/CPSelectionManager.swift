//
// Created by Chope on 2016. 4. 27..
// Copyright (c) 2016 Chope. All rights reserved.
//

import UIKit

public enum CPSelectionType {
    case single
    case multiple
    case limitedMultiple(Int)
}

public enum CPSelectionErrorType: Error {
    case wrongSelectionType
}

open class CPSelectionManager {
    open var selectionType = CPSelectionType.single {
        didSet {
            self.unselectAll()
        }
    }
    open var changedSelection: ((CPSelectionManager) -> ())? = nil
    internal var controls = [UIControl]()

    open func add(control: UIControl) -> CPSelectionManager {
        control.addTarget(self, action: #selector(touchUpInside(at:)), for: UIControlEvents.touchUpInside)
        self.controls.append(control)
        return self
    }

    open func removeAllControls() -> CPSelectionManager {
        self.controls.removeAll()
        return self
    }

    open func selectAll() throws {
        switch self.selectionType {
        case .multiple:
            if self.countOfSelection() != self.controls.count {
                for control in self.controls {
                    control.isSelected = true
                }
                self.changedSelection?(self);
            }
        default:
            throw CPSelectionErrorType.wrongSelectionType
        }
    }

    open func unselectAll() {
        for control in self.controls {
            control.isSelected = false
        }
        self.changedSelection?(self);
    }

    open func selectedControls() -> [UIControl] {
        return self.controls.filter({ $0.isSelected })
    }

    open func countOfSelection() -> Int {
        return self.selectedControls().count
    }

    @objc func touchUpInside(at control: UIControl) {
        switch self.selectionType {
        case .single:
            self.unselectAll()
            control.isSelected = !control.isSelected
        case .multiple:
            control.isSelected = !control.isSelected
        case .limitedMultiple(let maxCount):
            if control.isSelected {
                control.isSelected = false
            } else if self.countOfSelection() < maxCount {
                control.isSelected = !control.isSelected
            } else {
                return
            }
        }

        self.changedSelection?(self);
    }
}
