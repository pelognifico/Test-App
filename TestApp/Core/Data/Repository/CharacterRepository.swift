//
//  MainRepository.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//

import Factory
import Combine
import Alamofire

protocol CharacterRepository {
  func getCharacters(page: Int?) -> AnyPublisher<CharactersListDto?,Never>
}

