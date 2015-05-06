//
//  Object.swift
//  d-i
//
//  Created by Tomohiro Nakamura on 5/6/15.
//  Copyright (c) 2015 tomohiron. All rights reserved.
//

import Foundation

protocol Object {
	var score : Int { get }
}

class Application : Object, Equatable {
	
	let path : String
	let fullPath : String
	let score : Int
	
	init(path: String, fullPath: String) {
		self.path = path
		self.fullPath = fullPath
		self.score = 10 // TODO set better score based on user's history etc
	}
}

func ==(lhs: Application, rhs: Application) -> Bool {
	return lhs.fullPath == rhs.fullPath
}