//
//  Section.swift
//  NewsViewer
//
//  Created by ramil on 25.06.2023.
//

import Foundation


struct Section: Hashable, Equatable {
    let id = UUID()
    let type: SectionType
    
    var headerText: String {
        switch type {
        case .banner:
            return "Технологии"
        case .list:
            return "Последние"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum SectionType: Int, CaseIterable {
    case banner
    case list
}
