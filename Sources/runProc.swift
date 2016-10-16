//
//  runProc.swift
//  Perfect-System
//
//  Created by Jonathan Guthrie on 2016-09-27.
//
//


import PerfectLib
import Foundation

#if os(Linux)
	import SwiftGlibc
#else
	import Darwin
#endif

func runProc(_ cmd: String, args: [String], read: ((String) -> ())? = nil) throws {
	try runProc(cmd, args: args, envs: [String : String](), read: read)
}

// shortcut to execute something on the commandline
// i.e.
// 	let _ = try runProc("git", args: ["clone","--depth","1","https://github.com/PerfectlySoft/PerfectDocs.git","PerfectDocsSource"], read: true)

func runProc(_ cmd: String, args: [String], envs: [String:String], read: ((String) -> ())? = nil) throws {

	// Set up environmental variables
	// Note that the PATH, HOME and LANG vars are specifically configured.
	// HOME will be set to the runtime user's home directory
	var ienvs = [("PATH", "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local"),
	             ("HOME", ProcessInfo.processInfo.environment["HOME"]!),
	             ("LANG", "en_CA.UTF-8")]

	// Additional environmental variables can be added here. 
	// This allows for situations like AWS where credentials can be specified as ENV Vars.
	for e in envs {
		ienvs.append(e)
	}

	// Building the command with arguments a s a correctly formatted string
	var newCmd = "'\(cmd)\'"
	for n in 0..<args.count {
		newCmd.append(" ${\(n)}")
	}

	// Execute the command.
	// For more information see https://www.perfect.org/docs/sysProcess.html
	let proc = try SysProcess("/bin/bash", args: ["--login", "-c", newCmd] + args, env: ienvs)

	// Reading the result of the command
	if let read = read {
		while true {
			do {
				guard let s = try proc.stdout?.readSomeBytes(count: 1024) , s.count > 0 else {
					break
				}
				let str = UTF8Encoding.encode(bytes: s)
				read(str)
			} catch PerfectLib.PerfectError.fileError(let code, _) {
				if code != EINTR {
					break
				}
			}
		}
	}
	let res = try proc.wait(hang: true)
	if res != 0 {
		let s = try proc.stderr?.readString()
		throw PerfectError.systemError(Int32(res), s!)
	}
}
