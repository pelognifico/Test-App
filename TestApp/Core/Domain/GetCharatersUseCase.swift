//
//  UserCharaterUseCase.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//

import Factory
import Combine
import Alamofire

class GetCharatersUseCase {
  @Injected(DataContainer.characterRepository) private var repository

  func invoke(page: Int? = nil ) -> AnyPublisher<CharactersListDto?, Never> {
    return repository.getCharacters(page: page)
  }
}
