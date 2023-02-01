//
//  NetworkContainer.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//

import Factory

class NetworkContainer {
  static let charactersRemoteDataSource = Factory { CharacterRemoteDataSourceImpl() as CharacterRemoteDataSource }
}
