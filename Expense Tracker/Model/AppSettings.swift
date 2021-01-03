//
//  AppSettings.swift
//  Expense Tracker
//
//  Created by isEmpty on 02.01.2021.
//

import UIKit

struct AppSettings {
    
    // MARK: - Keys
    private struct Keys {
        static let startColor = "startColor"
        static let endColor = "endColor"
        static let userInterfaceStyle = "userInterfaceStyle"
        static let isPasscodeEnabled = "isPasscodeEnabled"
        static let passcodeService = "launchingPasscode"
        static let passcode = "passcode"
        static let currency = "currency"
        static let roundedFormat = "roundedFormat"
        static let displaying = "displaying"
        static let isFirstLoading = "isFirstLoading"
    }

    //MARK: - Static Properties
    public static let shared = AppSettings()
    
    // MARK: - Instance Properties
    public var isFirstLoading: Bool {
        get {
            return userDefaults.bool(forKey: Keys.isFirstLoading)
        } set {
            userDefaults.setValue(newValue, forKey: Keys.isFirstLoading)
        }
    }
    public var startColor: UIColor {
        get {
            let hex = userDefaults.string(forKey: Keys.startColor) ?? ""
            return UIColor(hex: hex) ?? #colorLiteral(red: 0.549, green: 0.298, blue: 0.831, alpha: 1.000)
        } set {
            userDefaults.setValue(newValue.toHex, forKey: Keys.startColor)
        }
    }
    public var endColor: UIColor {
        get {
            let hex = userDefaults.string(forKey: Keys.endColor) ?? ""
            return UIColor(hex: hex) ?? #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)
        } set {
            userDefaults.setValue(newValue.toHex, forKey: Keys.endColor)
        }
    }
    public var userInterfaceStyle: UIUserInterfaceStyle {
        get {
            return UIUserInterfaceStyle(rawValue: userDefaults.integer(forKey: Keys.userInterfaceStyle)) ?? .unspecified
        } set {
            userDefaults.setValue(newValue.rawValue, forKey: Keys.userInterfaceStyle)
        }
    }
    public var isPasscodeEnabled: Bool{
        get{
            return userDefaults.bool(forKey: Keys.isPasscodeEnabled)
        } set {
            userDefaults.setValue(newValue, forKey: Keys.isPasscodeEnabled)
        }
    }
    public var passcode: String {
        get {
            let genericPwdQueryable = GenericPasswordQueryable(service: Keys.passcodeService)
            let store = SecureStore(secureStoreQueryable: genericPwdQueryable)
            return try! store.getValue(for: Keys.passcode) ?? ""
        } set {
            isPasscodeEnabled = true
            let genericPwdQueryable = GenericPasswordQueryable(service: Keys.passcodeService)
            let store = SecureStore(secureStoreQueryable: genericPwdQueryable)
            try? store.setValue(newValue, for: Keys.passcode)
        }
    }
    public var currency: String {
        get {
            return userDefaults.string(forKey: Keys.currency) ?? "$"
        } set {
            userDefaults.setValue(newValue, forKey: Keys.currency)
        }
    }
    public var roundedFormat: String {
        get {
            return userDefaults.string(forKey: Keys.roundedFormat) ?? "%.0f"
        } set {
            userDefaults.setValue(newValue, forKey: Keys.roundedFormat)
        }
    }
    public var displaying: Displaying {
        get {
            return Displaying(rawValue: userDefaults.integer(forKey: Keys.displaying)) ?? .allTime
        } set {
            userDefaults.setValue(newValue.rawValue, forKey: Keys.displaying)
        }
    }
    private let userDefaults = UserDefaults.standard
    
    //MARK: - Instance Methods
    public mutating func configureFirstLoading() {
        // Appearance Configuration
        startColor = #colorLiteral(red: 0.549, green: 0.298, blue: 0.831, alpha: 1.000)
        endColor = #colorLiteral(red: 0.345, green: 0.212, blue: 0.733, alpha: 1.000)
        userInterfaceStyle = .unspecified
        // Internal App Configuration
        currency = "$"
        roundedFormat = "%.1f"
        displaying = .allTime
    }
    
    // MARK: - Object Lifecycle
    private init() {}
    
}

public enum Displaying: Int, CaseIterable, CustomStringConvertible {
    case week, month, year, allTime
    
    public var description: String {
        switch self {
        case .week:
            return "Last week."
        case .month:
            return  "Last month."
        case .year:
            return "Last year."
        case .allTime:
            return "For all the time."
        }
    }
}
