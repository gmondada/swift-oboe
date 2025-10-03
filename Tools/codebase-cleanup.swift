#!/usr/bin/swift

import Foundation

extension String {
    func substring(_ from: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: from)...])
    }
}

class Header {

    struct Copyright {
        var message: String
        var owner: String
        var year: Int
        var rights: String?
        var note: String?
    }

    var filename: String
    var project: String?
    var user: String
    var date: Date
    var hasCleanFormat = true

    var copyrights: [Copyright] = []

    init?(lines: [String]) {
        let dateString: String
        var textLines: [String] = []
        var index = 0

        // extract pure text

        for index in 0 ..< lines.count {
            guard lines[index].hasPrefix("//") else {
                return nil
            }
            textLines.append(lines[index].substring(2).trimmingCharacters(in: .whitespacesAndNewlines))
        }

        // skip initial empty line

        guard index < textLines.count && textLines[index] == "" else {
            return nil
        }
        index += 1

        // parse filename

        guard index < textLines.count && textLines[index] != "" else {
            return nil
        }
        filename = textLines[index].trimmingCharacters(in: .whitespacesAndNewlines)
        index += 1

        // parse project

        guard index < textLines.count else {
            return nil
        }
        if textLines[index] != "" {
            project = textLines[index]
            index += 1
        } else {
            project = nil
        }

        // skip empty line

        guard index < textLines.count && textLines[index] == "" else {
            return nil
        }
        index += 1

        // check for creator info

        guard index < textLines.count else {
            return nil
        }
        guard textLines[index].hasPrefix("Created by") else {
            return nil
        }
        let creation = textLines[index]

        guard let r1 = creation.range(of: "Created by "),
            let r2 = creation.range(of: " on "),
            creation.last == "." else
        {
            return nil
        }

        user = String(creation[r1.upperBound ..< r2.lowerBound])
        dateString = String(creation[r2.upperBound..<creation.index(creation.endIndex, offsetBy: -1)])

        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd.MM.yy"
        dateFormatter1.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter1.timeZone = TimeZone(secondsFromGMT: 0)
        var date = dateFormatter1.date(from:dateString)
        if date == nil {
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "MMM d, yyyy"
            dateFormatter2.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter2.timeZone = TimeZone(secondsFromGMT: 0)
            date = dateFormatter2.date(from:dateString)
        }
        guard let date else {
            return nil
        }
        self.date = date
        if dateString != Self.formatDate(date) {
            hasCleanFormat = false
        }
        index += 1

        // check for copyright

        while true {
            let message: String
            let owner: String
            let year: Int
            let rights: String?
            let notice: String?

            if textLines.count <= index {
                break
            }

            // parse copyright line

            let line = textLines[index]

            let pattern = #"(?<copyright>Copyright (©|\(c\))) (?<year>\d{4}) (?<owner>[^\.]*)\.\s*(?<rights>.*)"#
            let regex = try! NSRegularExpression(pattern: pattern, options: [])

            let nsrange = NSRange(line.startIndex ..< line.endIndex, in: line)
            if let match = regex.firstMatch(in: line,
                                            options: [],
                                            range: nsrange)
            {
                let nsr1 = match.range(withName: "copyright")
                if nsr1.location == NSNotFound {
                    return nil
                }
                let r1 = Range(nsr1, in: line)!
                message = String(line[r1])

                let nsr2 = match.range(withName: "year")
                if nsr2.location == NSNotFound {
                    return nil
                }
                let r2 = Range(nsr2, in: line)!
                year = Int(String(line[r2]))!

                let nsr3 = match.range(withName: "owner")
                if nsr3.location == NSNotFound {
                    return nil
                }
                let r3 = Range(nsr3, in: line)!
                owner = String(line[r3])

                let nsr4 = match.range(withName: "rights")
                if nsr4.location != NSNotFound && nsr4.length > 0 {
                    let r4 = Range(nsr4, in: line)!
                    rights = String(line[r4])
                } else {
                    rights = nil
                }
            } else {
                break
            }

            index += 1

            // parse notice

            if index < textLines.count && textLines[index] != "" && !textLines[index].hasPrefix("Copyright") {
                notice = textLines[index]
                index += 1
            } else {
                notice = nil
            }

            // skip empty line

            guard index < textLines.count && textLines[index] == "" else {
                return nil
            }
            index += 1

            // store copyright

            copyrights.append(Copyright(message: message, owner: owner, year: year, rights: rights, note: notice))
        }

        // check to be at the end of the header

        if index != textLines.count {
            return nil
        }
    }

    func format() -> [String] {
        let dateString = Self.formatDate(date)

        var ret = [String]()
        ret.append("//")
        ret.append("//  \(filename)")
        if let p = project {
            ret.append("//  \(p)")
        }
        ret.append("//")
        ret.append("//  Created by \(user) on \(dateString).")
        for c in copyrights {
            var rights = ""
            if let r = c.rights {
                rights = " " + r
            }
            ret.append("//  \(c.message) \(c.year) \(c.owner).\(rights)")
            if let note = c.note {
                ret.append("//  \(note)")
            }
        }
        ret.append("//")
        return ret
    }

    private static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: date)
    }
}

extension Header: CustomStringConvertible {
    var description: String {
        return format().joined(separator: "\n")
    }
}

func getGitAppearingDate(_ url: URL) -> Date? {
    let task = Process()
    task.launchPath = "/bin/bash"
    task.arguments = ["-c", "touch /tmp/__git_date; rm /tmp/__git_date; cd \"\(url.deletingLastPathComponent().path)\"; git log --format=%aI -- \(url.lastPathComponent) | tail -1 > /tmp/__git_date"]
    task.launch()
    task.waitUntilExit()
    let dateString = try! String.init(contentsOf: URL(string:"file:///tmp/__git_date")!, encoding: .utf8)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    dateFormatter.calendar = Calendar(identifier: .iso8601)
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    return dateFormatter.date(from: dateString.trimmingCharacters(in: .whitespacesAndNewlines))
}

func checkLicense(url: URL, header h: Header) -> Bool {
    var altered = false
    guard h.copyrights.count == 1 else {
        fatalError("Multiple copyrights found in file \(url)")
    }
    let project = "swift-oboe"
    if h.project != project {
        h.project = project
        altered = true
    }
    let note = "MIT License. See the file LICENSE for details."
    if h.copyrights[0].note != note {
        h.copyrights[0].note = note
        altered = true
    }
    if h.copyrights[0].rights != nil {
        h.copyrights[0].rights = nil
        altered = true
    }

    return altered
}

func processHeader(url: URL, header: [String]) -> [String]? {

    if let h = Header(lines: header) {
        // print(h)
        var altered = false
        if h.filename != url.lastPathComponent {
            print("Bad filename in header of file \(url)")
            h.filename = url.lastPathComponent
            altered = true
        }
        if h.copyrights.isEmpty {
            h.copyrights.append(Header.Copyright(
                message: "Copyright (c)",
                owner: "Gabriele Mondada",
                year: Calendar.current.component(.year, from: h.date),
                rights: nil,
                note: nil
            ))
            altered = true
        }
        for c in h.copyrights {
            if c.year != Calendar.current.component(.year, from: h.date) {
                print("File and copyright dates do not match in \(url)")
            }
        }
        if (checkLicense(url: url, header: h)) {
            print("License text is not correct in file \(url)")
            altered = true
        }
        if !h.hasCleanFormat {
            print("Header does not have a clean format in file \(url)")
            altered = true
        }
        if altered {
            return h.format()
        }
    } else {
        if header.count > 0 {
            print("Unstandard header in file \(url)")
        } else {
            print("Missing header in file \(url)")
        }
    }
    return nil
}

func convertTabsToSpaces(_ originalLine: String) -> String? {
    var line = originalLine
    var altered = false
    scan: while true {
        var pos = 0
        for c in line {
            if c == "\t" {
                let index = line.index(line.startIndex, offsetBy: pos)
                let spaceCount = 4 - (pos % 4)
                let spaces = String([Character].init(repeating: " ", count: spaceCount))
                line.remove(at: index)
                line.insert(contentsOf: spaces, at: index)
                altered = true
                continue scan
            }
            pos += 1
        }
        break
    }
    return altered ? line : nil
}

func removeTrailingBlanks(_ originalLine: String) -> String? {
    var line = originalLine
    var altered = false
    while true {
        if let last = line.last, last.unicodeScalars.count == 1 && last.unicodeScalars.first!.value <= 32 {
            // this is a blank
            line.removeLast()
            altered = true
        } else {
            break
        }
    }
    return altered ? line : nil
}

func parseSourceFile(_ url: URL) {
    let content = try! String.init(contentsOf: url, encoding: .utf8)
    if content.unicodeScalars.firstIndex(of: "\r") != nil {
        print("Invalid eol char in \(url)")
        return
    }

    // split into lines

    var lines = content.components(separatedBy: "\n")
    var fileAltered = false

    // detect header

    var headerLineCount = 0
    for index in 0..<lines.count {
        let line = lines[index]
        if line.starts(with: "//") {
            headerLineCount = index + 1
        } else {
            break
        }
    }

    // process header

    if let h = processHeader(url: url, header: Array(lines[0..<headerLineCount])) {
        var newLines = h
        newLines.append(contentsOf: lines[headerLineCount...])
        lines = newLines
        fileAltered = true
    }

    // process all lines

    for index in 0..<lines.count {
        var line = lines[index]
        var lineAltered = false
        if let procLine = removeTrailingBlanks(line) {
            print("Trailing blanks found in \(url) (\(index + 1))")
            line = procLine
            lineAltered = true
        }
        if let procLine = convertTabsToSpaces(line) {
            print("Tabs found in \(url) (\(index + 1))")
            line = procLine
            lineAltered = true
        }
        if lineAltered {
            lines[index] = line
            fileAltered = true
        }
    }

    // check for non-ascii chars

    for index in headerLineCount..<lines.count {
        let line = lines[index]
        for scalar in line.unicodeScalars {
            if (scalar.value < 32 && scalar.value != 9) || scalar.value >= 128 {
                print("Non-ascii char '\(scalar)' [\(scalar.value)] found in \(url) (\(index + 1))")
                break
            }
        }
    }

    // check for final newline

    if lines.isEmpty || lines.last != "" {
        print("Missing final newline in \(url)")
        lines.append("")
        fileAltered = true
    }
    while lines.count >= 2 && lines[lines.count - 2] == "" {
        print("Multiple final newlines in \(url)")
        lines.removeLast()
        fileAltered = true
    }

    // write back if altered

    if fileAltered {
        print("Updating file \(url)")
        let newContent = lines.joined(separator: "\n")
        try! newContent.write(to: url, atomically: false, encoding: .utf8)
    }
}

func scan(_ url: URL) {
    let urls = try! FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.isDirectoryKey] , options: [.skipsHiddenFiles])

    for url in urls {
        // print(url)
        if try! url.resourceValues(forKeys: [.isDirectoryKey]).isDirectory! {
            scan(url)
        } else {
            if url.pathExtension == "c" || url.pathExtension == "cpp" || url.pathExtension == "h" || url.pathExtension == "m" || url.pathExtension == "swift" {
                parseSourceFile(url)
            }
        }
    }
}

let currentDir = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
precondition(currentDir.lastPathComponent == "Tools")
let rootDir = currentDir.deletingLastPathComponent()
scan(rootDir.appendingPathComponent("Sources"))
