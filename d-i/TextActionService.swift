//
//  TextActionService.swift
//  d-i
//
//  Created by Tomohiro Nakamura on 5/6/15.
//  Copyright (c) 2015 tomohiron. All rights reserved.
//

import Foundation

class TextActionService {
	
	var applications : [Application] = []
	
	init() {
		initApplications()
	}
	
	func getApplications(objectInput: String) -> [Application] {
		var tmp : [Application] = applications.filter { $0.path.rangeOfString(objectInput)?.startIndex == $0.path.startIndex }
		tmp.sort { $1.score < $0.score }
		return tmp
	}
	
	private func initApplications() {
		let theError = NSErrorPointer()
		let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.AllApplicationsDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as! [String]
		let existingDirs = dirs.filter { nsFileManager.fileExistsAtPath($0) }
		for dir in existingDirs {
			let filesInDir = nsFileManager.contentsOfDirectoryAtPath(dir, error: theError) as! [String]
			let apps = filesInDir.filter { $0.rangeOfString(".app")?.endIndex == $0.endIndex}.map { Application(path: $0, fullPath: dir + "/" + $0) }
			applications += apps
		}
	}
}

var textActionService : TextActionService!