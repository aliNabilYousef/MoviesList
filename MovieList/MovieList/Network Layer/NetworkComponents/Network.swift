//
//  Network.swift
//  MoviesList
//
//  Created by Ali Youssef on 16/07/2022.
//

import Foundation
import RxSwift

final class Network<T: Decodable> {
    
    private let scheduler: ConcurrentDispatchQueueScheduler
    let api: API
    
    init(scheme: String, host: String) {
        self.api = API(scheme: scheme, host: host)
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }

}
