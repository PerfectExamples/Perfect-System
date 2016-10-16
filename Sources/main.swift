//
//  main.swift
//  Perfect System Access Example
//
//  Created by Jonathan Guthrie on 2016-09-27.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//


import PerfectLib
import Foundation


/*
	This example demonstrates interacting with the host operating system using PerfectLib.
	See "runProc.swift" for an encapsulated function that does all the SysProcess heavy lifting.
*/

try runProc("dig", args: ["perfect.org"]) {
	str in
	print(str)
}

print("=====================================")

try runProc("ls", args: ["-la"]) {
	str in
	print(str)
}





