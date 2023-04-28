//
//  DetailView.swift
//  FirebaseTest
//
//  Created by Dylan Murphy on 4/28/23.
//

import SwiftUI

struct DetailView: View {
    let event : Event
    
    @State private var title = ""
    @State private var description = ""
    @State private var labels = ""
    @State private var date = ""
    @State private var address = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(event.title)")
                .font(.largeTitle)
                .fontWeight(.bold)
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 2)
                .foregroundColor(.gray)
            HStack(alignment: .top){
                Text("Description:")
                    .fontWeight(.bold)
                ScrollView {
                    Text("\"\(description)\"")
                }
                .frame(width: 250, height: 125)
            }
            
            .minimumScaleFactor(0.5)
            
            HStack (alignment: .top){
                Text("\nEvent Categories:")
                    .fontWeight(.bold)
                Text("\n\(labels)")
            }
            
            HStack (alignment: .top){
                Text("\nAddress:")
                    .fontWeight(.bold)
                Text("\n\(address)")
            }
            HStack (alignment: .top){
                Text("\nDate:")
                    .fontWeight(.bold)
                Text("\n\(date)")
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            for element in event.labels {
                if !labels.isEmpty {
                    labels = labels + ", " +  element
                } else {
                    labels = element
                }
            }
                if event.description.isEmpty {
                    description = "N/A"
                } else {
                    description = event.description
                }
            if !event.start.isEmpty {
                    var oldString = event.start
                    date = String(oldString.prefix(10))
                } else {
                    date = "N/A"
                }
                
                if (event.entities == nil) {
                    address = "N/A"
                } else {
                    address = event.entities![0].formatted_address!
                }
                
                
            }
        }
        
        
    }

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(event: Event(title: "Live at Red Rocks", description: "See the best concert ever in a natural amphitheater aslkjdhfkjsbdf nsdkjf skjdf akjdsf kjdk fasdkfh akljdf kasdfkj asjkdf kjsdanfjk akjdsf kjasdjkfn kjsdnf kjnasdfkj nasdjkfn kjasdfjk ajksdfka sdff", labels: ["Concert", "Performing arts"], entities: [Entity(formatted_address: "24 Denver Drive")], start: "2023-07-24T00:00:00Z"))
    }
}
