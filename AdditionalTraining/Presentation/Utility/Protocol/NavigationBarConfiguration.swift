//
//  NavigationBarConfiguration.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/13.
//

protocol NavigationBarConfiguration {
    var navigationTitle: String? { get }
}

extension NavigationBarConfiguration {
    var navigationTitle: String? { nil }
}
