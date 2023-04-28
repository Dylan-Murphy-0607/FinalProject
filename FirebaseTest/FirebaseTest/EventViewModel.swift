//
//  EventViewModel.swift
//  FirebaseTest
//
//  Created by Dylan Murphy on 4/28/23.
//

import Foundation
import FirebaseFirestore

@MainActor


class EventViewModel: ObservableObject {
    @Published var category = ""
    @Published var latitude = ""
    @Published var longitude = ""
    @Published var count = 0
    
    struct Returned: Codable {
        var count: Int
        var results : [Event]
        var next : String
    }
    
    
    
    @Published var eventsArray : [Event] = []
    
    @Published var nextURL = "1"
    
    @Published var isLoading = false
    
    func getData(urlParam: String) async  {
        isLoading = true
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let urlDate = dateFormatter.string(from: currentDate)
        
        var urlString = urlParam

        urlString = urlString.replacingOccurrences(of: "LA", with: latitude)
        urlString = urlString.replacingOccurrences(of: "LO", with: longitude)
        urlString = urlString.replacingOccurrences(of: "CAT", with: category)
        urlString = urlString.replacingOccurrences(of: "DATE", with: urlDate)
        print("\nurlString: \(urlString)")
        
        //var urlString = "https://api.predicthq.com/v1/events/?category=\(category)&limit=10&location_around.origin=\(latitude)%2C\(longitude)&offset=10&sort=start&start.gte=\(urlDate)&within=15mi%40\(latitude)%2C\(longitude)"
        
        print("\nCategory: \(category)\n")
        
        guard let url = URL(string: urlString) else {
            print("ERROR 😡")
            isLoading = false
            return
        }

        print("the function is running")

        var request = URLRequest(url: url)

        //specify headers
        let headers = [ "Accept": "application/json", "Authorization": "Bearer 7zntkxaqgF3GObuugU0Qo1b4O0UOlnl6d8B1fBky",]

        request.allHTTPHeaderFields = headers

        //Specify Method
        request.httpMethod = "GET"

        //get URL Session
        let session = URLSession.shared

        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                    print("Error: \(error.localizedDescription)")
                    self.isLoading = false
                    return
                }
                guard let data = data else {
                    print("No data received")
                    self.isLoading = false
                    return
                }
                print("Data received:\n\(String(data: data, encoding: .utf8) ?? "")")
            //create the data task
            if error == nil && data != nil {

                do {
                    let returned = try JSONDecoder().decode(Returned.self, from: data)
                    //print(returned.results)
                    DispatchQueue.main.async {
                        self.eventsArray = self.eventsArray + returned.results
                        self.count = returned.count
                        if returned.next.isEmpty {
                            self.nextURL = ""
                        } else {
                            self.nextURL = returned.next
                        }
                        
                    }
                    //print("\nThis is the Events Array inside the get data function: \(self.eventsArray)\n")
                }
                catch {
                    print(data)
                    print("error parsing data")
                    self.isLoading = false
                }
                self.isLoading = false
            }
        }
        dataTask.resume()
    }
    
    func loadNextIfNeeded(event: Event, urlParam : String) async {
        print("The Load next function is running")
        
        guard let lastEvent = eventsArray.last else {
            //print(eventsArray.last?.title)
            return
        }
        if lastEvent.id == event.id {
             if !nextURL.isEmpty{
                await getData(urlParam: nextURL)
            } else {
                return
            }
            
        }
    }
    
//    func saveEvent(event : Event) async -> Bool {
//        let db = Firestore.firestore()
//
//        if let id = event.id {
//            do {
//                try await db.collection("spots").document(id).setData(event.)
//            }
//        }
//    }
}
