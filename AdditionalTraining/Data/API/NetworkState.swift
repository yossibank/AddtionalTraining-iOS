//
//  NetworkState.swift
//  AdditionalTraining
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/14.
//

enum NetworkState {
    case standby
    case loading
    case finished
    case error(Error)
}
