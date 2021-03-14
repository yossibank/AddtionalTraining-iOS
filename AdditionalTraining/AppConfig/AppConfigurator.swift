//
//  AppConfigurator.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

import  Foundation

final class AppConfigurator {

    static var currentBaseUrl: URL {
        let path: URL? = URL(string: Resources.Strings.API.baseUrl)
        return path ?? URL(string: .blank)!
    }
}
