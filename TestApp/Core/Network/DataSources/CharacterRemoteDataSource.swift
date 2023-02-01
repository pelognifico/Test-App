//
//  MainRemoteDataSource.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//


import Combine
import Alamofire

protocol CharacterRemoteDataSource {
  func getCharacters(page: Int?) -> AnyPublisher<CharactersListDto?,Never>
}
