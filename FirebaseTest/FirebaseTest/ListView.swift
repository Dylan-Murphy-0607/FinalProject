//
//  ListView.swift
//  FirebaseTest
//
//  Created by Dylan Murphy on 4/27/23.
//

import SwiftUI
import Firebase

@MainActor

struct ListView: View {
    @StateObject var eventsVM = EventViewModel()
    var title : String
    var category : String
    var latitude : String
    var longitude : String
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(eventsVM.eventsArray) {
                    event in
                    LazyVStack {
                        NavigationLink {
                            DetailView(event : event)
                        } label: {
                            Text("\(event.title)")
                        }
                    }
                    .task {
                        eventsVM.longitude = longitude
                        eventsVM.latitude = latitude
                        eventsVM.category = category
                        await eventsVM.loadNextIfNeeded(event: event, urlParam: "https://api.predicthq.com/v1/events/?category=CAT&limit=10&location_around.origin=LA%2CLO&offset=10&sort=start&start.gte=DATE&within=15mi%40LA%2CLO")
                    }
                }
                
                if eventsVM.isLoading {
                    ProgressView()
                        .scaleEffect(4)
                        .tint(.purple)
                }
            }
            
            .navigationTitle(title)
            .font(.title)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Text("Total Events: \(eventsVM.count)")
                        .bold()
                        .foregroundColor(.purple)
                }
                ToolbarItem(placement: .bottomBar) {
                    Text("Sorted by Date")
                        .bold()
                        .foregroundColor(.purple)
                }
            }
            
        }
        
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
            Task {
                eventsVM.longitude = longitude
                eventsVM.latitude = latitude
                eventsVM.category = category
                await eventsVM.getData(urlParam: "https://api.predicthq.com/v1/events/?category=CAT&limit=10&location_around.origin=LA%2CLO&offset=10&sort=start&start.gte=DATE&within=15mi%40LA%2CLO")
            }
        }
        
    }
    //}
    
    
    
    
    //}
    
    
    
    // }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ListView(title: "Performing Arts", category: "performing-arts", latitude: "42.36", longitude: "-71.05")
        }
    }
}
