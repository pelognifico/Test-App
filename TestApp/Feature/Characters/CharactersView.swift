//
//  MainView.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//

import SwiftUI


struct CharactersMainView: View {
  @StateObject var viewModel: CharactersViewModel = .init()

  var body: some View {
    VStack {
      switch viewModel.uiState {
      case .loading:
        ProgressView()
      case .success:
        CharactersListView(characters: viewModel.characters )
          .environmentObject(viewModel)
      default:
        EmptyView()

      }
    }
  }
}

struct CharactersListView : View {
  @EnvironmentObject var viewModel : CharactersViewModel
  let characters : [CharactersDto]
  let coordinateSpaceName = "charactersScrollview"
  @State private var heightContent: CGFloat = 0.0
  @State private var heightGeometry: CGFloat = 0.0

  var body: some View {
      CustomNavView {
          NavigationStack {
            ScrollView {
                VStack {
                    Spacer(minLength: 5)
                    HStack {
                        VStack {
                          ForEach(characters) { character in
                            NavigationLink(value: character) {
                              CharacterView(character: character)
                            }
                          }
                          .padding()
                          .background(Color .init(red: 223/255, green: 223/255, blue: 223/255))
                          .clipShape(RoundedRectangle(cornerRadius: 15)).listRowSeparator(.hidden)
                          .listRowBackground(Color .init(red: 245/255, green: 245/255, blue: 245/255)).shadow(color: .init(red: 100/255, green: 100/255, blue: 100/255), radius: 8)
                            Divider()
                        }
                        .background(
                          GeometryReader { geometryProxy in
                            Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self, value: geometryProxy.frame(in: .named(coordinateSpaceName)).origin)
                        .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
                        .preference(key: ScrollContentFramePreferenceKey.self, value: geometryProxy.frame(in: .global))
                        })
                    }
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 15)).listRowSeparator(.hidden)
                    .listRowBackground(Color .init(red: 245/255, green: 245/255, blue: 245/255)).shadow(color: .init(red: 100/255, green: 100/255, blue: 100/255), radius: 8)
                }
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetDidChange)
            .onPreferenceChange(SizePreferenceKey.self) { newSize in
              DispatchQueue.main.async {
                self.heightContent = newSize.height
              }
            }
            .navigationDestination(for: CharactersDto.self) { character in
              VStack {
                  Text(character.gender)
                  HomeDetailView(name:  character.name, status:  character.status, species:  character.species, gender:  character.gender, origin:  character.origin.name, image: character.image)
              }
            }
          }
      }
    
  }

  private func offsetDidChange(point: CGPoint) {
    if heightContent > 0, abs(point.y) + 800 >= (heightContent - heightGeometry) {
      viewModel.getNextPage()
    }
  }
}

struct CharacterView : View {
  let character : CharactersDto
  var body: some View {
      HStack {
      
          let url = URL(string: character.image)
          AsyncImage(url: url) { image in
              
              image.resizable()
                  .scaledToFill()
                  .frame(width: 80, height: 80)
                  .cornerRadius(40)
                  .padding(5).clipShape(Circle()).overlay(Circle().stroke(Color.init(red: 92/255, green: 4/255, blue: 22/255), lineWidth: 2)).shadow(color: Color.gray,radius: 0)
          }placeholder: {
              ProgressView()
          }

          VStack(alignment: .leading) {
              Text(character.name)
                  .font(.title)
                  .foregroundColor(.black)
                  .glowBorder(color: .black, lineWidth: 1)
                  .lineLimit(2)
              Text(character.species)
                  .font(.subheadline)
                  .font(.title).foregroundColor(.black)
          }
          Spacer()
          
      }
   }
}

struct HomeDetailView: View {
    @State var name: String
    @State var status: String
    @State var species: String
    @State var gender: String
    @State var origin: String
    @State var image: String

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false ) {
            
            ZStack {
                Image("efecto")
                    .resizable()
                    .scaledToFill()
                
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                   
                    let url = URL(string: image)
                    AsyncImage(url: url) { image in
                       
                        Spacer(minLength: 0)
                        image.resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .cornerRadius(18)
                            .padding(0)
                    } placeholder: {
                        ProgressView()
                    }
                 
                    HStack {
                        Text(name).font(.title).foregroundColor(.white)
                            .glowBorder(color: .black, lineWidth: 4)
                        
                    }
                    
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 10) {
                            Text("Status :").padding(.leading, -130).padding().font(.title).bold().lineLimit(2).glowBorder(color: .white, lineWidth: 3)
                            
                            
                            Text(status).fontWeight(.semibold).foregroundColor(.white)
                                .glowBorder(color: .black, lineWidth: 4)
                            
                            Spacer()
                            
                        }.frame(width: 190, height: 70).padding(.leading , 60)
                        
                        HStack {
                            Text("Species :").padding(.leading, -130).padding().font(.title).bold().lineLimit(2).glowBorder(color: .white, lineWidth: 3)
                            
                            
                            Text(species).fontWeight(.semibold).foregroundColor(.white)
                                .glowBorder(color: .black, lineWidth: 4)
                            
                            Spacer()
                            
                        }.frame(width: 190, height: 70).padding(.leading , 60)
                        
                        HStack{
                            Text("Gender :").padding(.leading, -130).padding().font(.title).bold().lineLimit(2).glowBorder(color: .white, lineWidth: 3)
                            
                            
                            Text(gender).fontWeight(.semibold).foregroundColor(.white)
                                .glowBorder(color: .black, lineWidth: 4)
                            
                            Spacer()
                            
                        }.frame(width: 190, height: 70).padding(.leading , 60)
                        
                        HStack {
                            Text("Origin :").padding(.leading, -130).padding().font(.title).bold().lineLimit(2).glowBorder(color: .white, lineWidth: 3)
                            
                            Text(origin).fontWeight(.semibold).foregroundColor(.white)
                                .glowBorder(color: .black, lineWidth: 4)
                            
                            Spacer()
                            
                        }.frame(width: 190, height: 70).padding(.leading , 60)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .padding(-5).navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left").foregroundColor(Color.white)
            })
        }
        .scaledToFill().edgesIgnoringSafeArea(.top).background(Color .black)
    }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value _: inout CGSize, nextValue _: () -> CGSize) {}
}


struct ScrollOffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGPoint = .zero
  static func reduce(value _: inout CGPoint, nextValue _: () -> CGPoint) {}
}

struct ScrollContentFramePreferenceKey: PreferenceKey {
  static var defaultValue: CGRect = .zero
  static func reduce(value _: inout CGRect, nextValue _: () -> CGRect) {}
}


struct CharactersMainView_Previews: PreviewProvider {
  static var previews: some View {
      CharactersMainView()
  }
}
