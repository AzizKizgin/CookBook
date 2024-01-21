//
//  DataFetchable.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 21.01.2024.
//

import Foundation

protocol DataFetchable {
    associatedtype DataType
    func fetchData(completion: @escaping ([DataType]?) -> Void)
}
