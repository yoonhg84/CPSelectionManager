//
//  ViewController.swift
//  CPSelectionManager
//
//  Created by Chope on 2016. 4. 27..
//  Copyright (c) 2016 Chope. All rights reserved.
//


import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var unselectAllButton: UIButton!
    @IBOutlet weak var multipleButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet var collectionOfItemButtons: [UIButton] = [UIButton]()
    @IBOutlet var collectionOfMenuButtons: [UIButton] = [UIButton]()
    
    var itemSelectionManager = CPSelectionManager()
    var menuSelectionManager = CPSelectionManager()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.itemSelectionManager.selectionType = .single
        self.itemSelectionManager.changedSelection = { [weak self] (manager: CPSelectionManager) in
            self?.countLabel?.text = "count : \(manager.countOfSelection())"
        }

        self.collectionOfItemButtons.forEach {
            let _ = self.itemSelectionManager.add(control: $0)
        }

        self.collectionOfMenuButtons.forEach {
            let _ = self.menuSelectionManager.add(control: $0)
        }
        self.menuSelectionManager.selectionType = .single
        self.menuSelectionManager.changedSelection = { [weak self] (manager: CPSelectionManager) in
            guard let selectedControl = manager.selectedControls().first, let multipleButton = self?.multipleButton else {
                return
            }

            self?.selectAllButton?.isEnabled = (selectedControl == multipleButton)
        }
    }

    @IBAction func single() {
        self.itemSelectionManager.selectionType = .single
    }

    @IBAction func multiple() {
        self.itemSelectionManager.selectionType = .multiple
    }

    @IBAction func limitedMultiple() {
        self.itemSelectionManager.selectionType = .limitedMultiple(3)
    }

    @IBAction func selectAll() {
        try? self.itemSelectionManager.selectAll()
    }

    @IBAction func selectNone() {
        self.itemSelectionManager.unselectAll()
    }
}
