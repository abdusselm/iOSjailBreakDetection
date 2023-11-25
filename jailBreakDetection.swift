import Foundation
import UIKit
import MachO

private enum JailBreakTestParameters{
    static let cydiaURL: URL = URL(string: "cydia://")!
    
    static let suspiciousAppPaths: [String] =
    ["/Applications/Cydia.app",
     "/Applications/blackra1n.app",
     "/Applications/FakeCarrier.app",
     "/Applications/Icy.app",
     "/Applications/IntelliScreen.app",
     "/Applications/MxTube.app",
     "/Applications/RockApp.app",
     "/Applications/SBSettings.app",
     "/Applications/WinterBoard.app",
     "/Applications/Sileo.app"]
    
    static let suspiciousSystemPaths: [String] =
    ["/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
     "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
     "/private/var/lib/apt/",
     "/private/var/lib/cydia",
     "/private/var/mobile/Library/SBSettings/Themes",
     "/private/var/stash",
     "/private/var/tmp/cydia.log",
     "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
     "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
     "/usr/bin/sshd",
     "/usr/libexec/sftp-server",
     "/usr/sbin/sshd",
     "/etc/apt",
     "/bin/bash",
     "/Library/MobileSubstrate/MobileSubstrate.dylib"
    ]
    
    static let suspiciousLibraries: [String] =
    ["FridaGadget",
     "frida",
     "cynject",
     "libcycript"
    ]
    
    static let jailBreakText: String = "JailBreak Test Text"
}

extension UIDevice{
    
    var isJailBroken: Bool {
        get{
            if JailBrokenHelper.hasCydiaInstalled() {return true}
            if JailBrokenHelper.isContainSuspiciousAppPaths() {return true}
            if JailBrokenHelper.isContainSuspiciousSystemPaths() {return true}
            return JailBrokenHelper.canEditSystemFiles()
        }
    }
    
    var isUsingSuspiciousLibraries: Bool {
        get{
            if JailBrokenHelper.checkDYDL() {return true}
            return false
        }
    }
}

private struct JailBrokenHelper{
    static func hasCydiaInstalled() -> Bool{
        return UIApplication.shared.canOpenURL(JailBreakTestParameters.cydiaURL)
    }
    
    static func isContainSuspiciousAppPaths() -> Bool{
        for path in suspiciousAppPaths{
            if FileManager.default.fileExists(atPath: path){
                return true
            }
        }
        return false
    }
    
    static func isContainSuspiciousSystemPaths() -> Bool{
        for path in suspiciousSystemPaths{
            if FileManager.default.fileExists(atPath: path){
                return true
            }
        }
        return false
    }
    
    static func canEditSystemFiles() -> Bool{
        do{
            try JailBreakTestParameters.jailBreakText.write(toFile: JailBreakTestParameters.jailBreakText, atomically: true, encoding: .utf8)
            return true
        } catch{
            return false
        }
    }
    
    static func checkDYDL() -> Bool {
        for libraryIndex in 0..<_dyld_image_count() {
            
            guard let loadedLibrary = String(validatingUTF8: _dyld_get_image_name(libraryIndex)) else { continue }
            for suspiciousLibrary in JailBreakTestParameters.suspiciousLibraries {
                if loadedLibrary.lowercased().contains(suspiciousLibrary.lowercased()) {
                    return true
                }
            }
        }
        return false
    }
    
    static let suspiciousAppPaths:      [String] = JailBreakTestParameters.suspiciousAppPaths
    static let suspiciousSystemPaths:   [String] = JailBreakTestParameters.suspiciousSystemPaths
    
}
