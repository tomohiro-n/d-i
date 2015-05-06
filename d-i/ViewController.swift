//
//  ViewController.swift
//  d-i
//
//  Created by Tomohiro Nakamura on 5/6/15.
//  Copyright (c) 2015 tomohiron. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
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
				let applications : [Application] = textActionService.getApplications(object)
				NSWorkspace.sharedWorkspace().launchApplication(applications[0].fullPath)
			}
		}
	}
}

