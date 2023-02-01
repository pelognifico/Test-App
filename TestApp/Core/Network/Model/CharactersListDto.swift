//
//  CharactersListDto.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/2/23.
//

struct CharactersListDto : Codable {
  let info : PagingInfo
  let results : [CharactersDto]
}

struct PagingInfo : Codable {
  let count : Int
  let pages : Int
  let prev : String?
  let next : String 
}

struct CharactersDto : Codable, Identifiable, Hashable {
  let id : Int
  let name : String
  let status: String
  let species: String
  let type: String
  let gender: String
  let image: String
  let origin: CharacterOriginDto
  let location: CharacterLocationDto
  let url: String
  let episode : [String]

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(name)
  }

}

struct CharacterOriginDto: Codable, Equatable {
  let name : String
  let url : String
}


struct CharacterLocationDto: Codable, Equatable {
  let name : String
  let url : String
}

