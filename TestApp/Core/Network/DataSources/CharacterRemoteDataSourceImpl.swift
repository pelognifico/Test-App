//
//  MainRemoteDataSourceImpl.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//


import Combine
import Alamofire
import Foundation

class CharacterRemoteDataSourceImpl : CharacterRemoteDataSource {
  func getCharacters(page: Int? ) -> AnyPublisher<CharactersListDto?,Never> {
    let params : Parameters? = page == nil ? nil : ["page": page]
    return AF.request(URL(string:"https://rickandmortyapi.com/api/character")!, method: .get, parameters: params)
            .validate(statusCode: 200...304)
            .publishDecodable(type: CharactersListDto.self)
            .compactMap { response in
              return response.value
            }
            .eraseToAnyPublisher()
  }
    
}
