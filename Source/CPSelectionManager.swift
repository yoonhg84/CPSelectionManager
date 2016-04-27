//
// Created by Chope on 2016. 4. 27..
// Copyright (c) 2016 Chope. All rights reserved.
//

import UIKit

public enum CPSelectionType {
    case Single
    case Multiple
}

public class CPSelectionManager {
    public var selectionType = CPSelectionType.Single {
        didSet {
            if self.selectionType == .Single {
                if let firstSelectedControl: UIControl = self.selectedControls().first {
                    self.unselectAll()
                    firstSelectedControl.selected = true
                }
            }
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

    public func selectAll() {
        switch self.selectionType {
        case .Multiple:
            if self.countOfSelection() != self.controls.count {
                for control in self.controls {
                    control.selected = true
                }
                self.changedSelection?(self);
            }
        case .Single:
            if self.countOfSelection() == 0 {
                if let firstControl = self.controls.first {
                    firstControl.selected = true
                    self.changedSelection?(self);
                }
            }
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
        if self.selectionType == .Single {
            self.unselectAll()
        }

        control.selected = !control.selected

        self.changedSelection?(self);
    }
}
