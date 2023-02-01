//
//  MainViewModel.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//

import Combine
import Factory
import Foundation
import Alamofire

class CharactersViewModel : ObservableObject {

  @Injected(UseCaseContainer.getCharactersUseCase) private var getCharactersUseCase
   
  @Published var uiState : MainViewUiState = .loading
  @Published var characters : [CharactersDto] = []

  var page: Int = 1
  var lastPage: Bool = false
  var locked : Bool = false
    
  var disposables = Set<AnyCancellable>()
    
  init()  {
    locked = true
    getCharactersUseCase.invoke()
      .receive(on: DispatchQueue.main)
      .sink { [weak self] value in
        guard let self = self else { return }
        self.locked = false

        guard let characterList = value else {
          self.uiState = .error
          return
        }

        if characterList.results.isEmpty {
          self.uiState = .empty
          return
        }

        self.uiState = .success
        self.characters = characterList.results
        self.page += 1
      }.store(in: &disposables)
  }

  func getNextPage() {
    guard !lastPage else {
      return
    }

    guard !locked else {
      return
    }

    locked = true
    getCharactersUseCase.invoke(page: page)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] value in
        guard let self = self else { return }

        self.locked = false
        guard let characterList = value else {
          self.uiState = .error
          return
        }

        if characterList.results.isEmpty {
          self.lastPage = true
          return
        }

        self.page =  characterList.info.pages > self.page ? self.page + 1 : self.page
        self.characters.append(contentsOf: characterList.results)
        if characterList.info.pages <= self.page {
          self.lastPage = true
        }
      }.store(in: &disposables)

  }


  enum MainViewUiState {
    case loading
    case success
    case empty
    case start
    case error
  }

}
