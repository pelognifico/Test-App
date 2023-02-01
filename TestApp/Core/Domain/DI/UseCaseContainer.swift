//
//  MainCaseContainer.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//

import Factory

class UseCaseContainer {
  static let getCharactersUseCase = Factory { GetCharatersUseCase() }
}
