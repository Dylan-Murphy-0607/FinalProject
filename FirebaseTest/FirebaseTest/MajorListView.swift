//
//  MajorListView.swift
//  FirebaseTest
//
//  Created by Dylan Murphy on 4/28/23.
//

import SwiftUI
import Firebase

struct MajorListView: View {
    @StateObject var eventsVM = EventViewModel()
    @StateObject var locationManager = LocationManager()
    let categories = ["Performing Arts", "Sports", "Concerts", "Festivals"]
    @Environment(\.dismiss) private var dismiss
    @State var latitude : String
    @State var longitude : String
    @State var starredEvents : [Event] = []
    
    var body: some View {
       
        
            
            NavigationStack {
                List {
                    NavigationLink(destination: ListView(eventsVM: eventsVM, title: "Performing Arts", category: "performing-arts",latitude: latitude, longitude: longitude)) {
                        Text("\(categories[0])")
                        Image(systemName: "music.mic")
                            .foregroundColor(.purple)
                    }
                       
                    
                    NavigationLink(destination: ListView(eventsVM: eventsVM, title: "Sports", category: "sports",latitude: latitude, longitude: longitude)) {
                        Text("\(categories[1])")
                        Image(systemName: "figure.american.football")
                            .foregroundColor(.purple)
                        
                    }
                    
                    NavigationLink(destination: ListView(eventsVM: eventsVM, title: "Concerts", category: "concerts",latitude: latitude, longitude: longitude)) {
                        Text("\(categories[2])")
                        Image(systemName: "music.note")
                            .foregroundColor(.purple)
                    }
                    
                    NavigationLink(destination: ListView(eventsVM: eventsVM, title: "Festivals", category: "festivals", latitude: latitude, longitude: longitude)) {
                        Text("\(categories[3])")
                        Image(systemName: "figure.socialdance")
                            .foregroundColor(.purple)
                    }
                    
                    NavigationLink(destination: ListView(eventsVM: eventsVM, title: "Community", category: "community",latitude: latitude, longitude: longitude)) {
                        Text("Community")
                        Image(systemName: "figure.2.arms.open")
                            .foregroundColor(.purple)
                    }
                    
                    NavigationLink(destination: ListView(eventsVM: eventsVM, title: "Expos", category: "expos", latitude: latitude, longitude: longitude)) {
                        Text("Expos")
                        Image(systemName: "megaphone.fill")
                            .foregroundColor(.purple)
                    }
                }
                .font(.largeTitle)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Sign Out") {
                            do {
                                try Auth.auth().signOut()
                                dismiss()
                            } catch {
                                print("logout unsuccessful")
                            }
                            
                        }
                    }
                }
                
                .navigationTitle("Where to?")
                
                .font(.title2)
                //.foregroundColor(.purple)
                .onAppear {
                    eventsVM.eventsArray = []
                    eventsVM.count = 0
                    
                    let lat = locationManager.location?.coordinate.latitude ?? 42.3601
                    latitude = String(lat)
                    
                    print("\nlatitude: \(latitude)")
                    
                    let long = locationManager.location?.coordinate.longitude ?? -71.0589
                    
                    longitude = String(long)
                    print("longitude: \(longitude)\n")
                
                }
               
                //.bold()
                .listStyle(.plain)
                
            }
            
            //Text("Starred Events: ")
            Spacer()
        }
        //.background(.black)
        
        
        
    }

struct MajorListView_Previews: PreviewProvider {
    static var previews: some View {
        MajorListView(latitude: "70", longitude: "70")
            .environmentObject(LocationManager())
    }
}



