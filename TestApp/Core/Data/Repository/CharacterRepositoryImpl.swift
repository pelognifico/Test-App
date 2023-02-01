//
//  UserRepositoryImpl.swift
//  TestApp
//
//  Created by Carlos Villamizaron 1/31/23.
//

import Factory
import Combine
import Alamofire

class CharacterRepositoryImpl : CharacterRepository {
    
  @Injected(NetworkContainer.charactersRemoteDataSource) private var remoteDataSource

  func getCharacters(page: Int?) -> AnyPublisher<CharactersListDto?, Never> {
    return remoteDataSource.getCharacters(page: page)
    }

}
