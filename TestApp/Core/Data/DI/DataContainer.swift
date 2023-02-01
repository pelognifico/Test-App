//
//  DataContainerle.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//

import Factory

class DataContainer {
  static let characterRepository = Factory { CharacterRepositoryImpl() as CharacterRepository }
}
