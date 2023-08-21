//
//  ProgressSubscriber.swift
//  APIClient
//
//  Created by umair irfan on 25/06/2023.
//

import Foundation
import Combine

public class AnyObserver<T>: Subscriber {
    
    public typealias Input = T
    public typealias Failure = Never
    
    private let receiveClosure: (T) -> Void
    private let completionClosure: (Subscribers.Completion<Never>) -> Void

    init(receiveClosure: @escaping (T) -> Void, completionClosure: @escaping (Subscribers.Completion<Never>) -> Void) {
        self.receiveClosure = receiveClosure
        self.completionClosure = completionClosure
    }

    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    public func receive(_ input: T) -> Subscribers.Demand {
        receiveClosure(input)
        return .none
    }

    public func receive(completion: Subscribers.Completion<Never>) {
        completionClosure(completion)
    }
}
