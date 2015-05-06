//
//  ViewController.swift
//  d-i
//
//  Created by Tomohiro Nakamura on 5/6/15.
//  Copyright (c) 2015 tomohiron. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate, NSTableViewDelegate, NSTableViewDataSource {

	@IBOutlet weak var actionTextField: NSTextField!
	@IBOutlet weak var actionCandidatesTableView: NSTableView!
	
	var applications : [Application] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		actionTextField.delegate = self
		
		actionCandidatesTableView.headerView = nil
		actionCandidatesTableView.setDelegate(self)
		actionCandidatesTableView.setDataSource(self)
	}

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
	func numberOfRowsInTableView(tableView: NSTableView) -> Int {
		if (tableView == self.actionCandidatesTableView) {
			return self.applications.count
		} else {
			return 0
		}
	}
	
	func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
		if (tableView == self.actionCandidatesTableView) {
			let id : String! = tableColumn?.identifier!
			let result = tableView.makeViewWithIdentifier(id, owner: self) as! NSTableCellView
			switch(id) {
				case "Verb":
				result.textField?.stringValue = "Launch"
				case "Object":
				result.textField?.stringValue = self.applications[row].path
			default:
				break
			}
			return result
		}
		return nil
	}
	
	override func controlTextDidChange(obj: NSNotification) {
		let textField = obj.object as! NSTextField
		if (textField == self.actionTextField) {
			// TODO
		}
	}


	@IBAction func actionEntered(sender: NSTextField) {
		let textEntered: String = sender.stringValue
		let textArr : [String] = split(textEntered) {$0==" "}
		if (textArr.count != 2) {
			println("bad text!!")
			// TODO show overlay text or something to let users enter verb and object
		} else {
			let verb : String = textArr[0]
			let object : String = textArr[1]
			println("Verb: " + verb + ", Object: " + object)
			// TODO do what user needs
			if (verb == "l") {
				applications = textActionService.getApplications(object)
				dispatch_async(dispatch_get_main_queue(), {
					self.actionCandidatesTableView.reloadData()
				})
				NSWorkspace.sharedWorkspace().launchApplication(applications[0].fullPath)
			}
		}
	}
}

