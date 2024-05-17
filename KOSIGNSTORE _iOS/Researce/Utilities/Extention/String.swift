//
//  String.swift
//  KOSIGNSTORE _iOS
//
//  Created by Hai Sombo on 4/30/24.
//

import Foundation

public extension String {
    func replace(of: String, with: String) -> String {
        return self.replacingOccurrences(of: of, with: with)
    }
    
    mutating func replaced(of: String, with: String) {
        self = self.replacingOccurrences(of: of, with: with)
    }
}
public extension String {
    func formatDate() -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
            guard let date = dateFormatter.date(from: self) else {
                return nil
            }
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.string(from: date)
        }
    
}
