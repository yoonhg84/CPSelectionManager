//
//  ViewController.swift
//  CPSelectionManager
//
//  Created by Chope on 2016. 4. 27..
//  Copyright (c) 2016 Chope. All rights reserved.
//


import UIKit


class ViewController: UIViewController {
    @IBOutlet var collectionOfItemButtons: [UIButton] = [UIButton]()
    @IBOutlet var collectionOfMenuButtons: [UIButton] = [UIButton]()
    @IBOutlet weak var countLabel: UILabel? = nil
    var itemSelectionManager = CPSelectionManager()
    var menuSelectionManager = CPSelectionManager()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.itemSelectionManager.selectionType = .Single
        self.itemSelectionManager.changedSelection = { [weak self] (manager: CPSelectionManager) in
            self?.countLabel?.text = "count : \(manager.countOfSelection())"
        }

        self.collectionOfItemButtons.flatMap { (button: UIButton) in
            self.itemSelectionManager.addControl(button)
        }

        self.collectionOfMenuButtons.flatMap { (button: UIButton) in
            self.menuSelectionManager.addControl(button)
        }
        self.menuSelectionManager.selectionType = .Single
        self.menuSelectionManager.selectAll()
    }

    @IBAction func single() {
        self.itemSelectionManager.selectionType = .Single
    }

    @IBAction func multiple() {
        self.itemSelectionManager.selectionType = .Multiple
    }

    @IBAction func selectAll() {
        self.itemSelectionManager.selectAll()
    }

    @IBAction func selectNone() {
        self.itemSelectionManager.unselectAll()
    }
}
