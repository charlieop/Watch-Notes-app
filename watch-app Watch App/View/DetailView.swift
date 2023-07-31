//
//  DetailView.swift
//  watch-app Watch App
//
//  Created by Charlie Chan on 7/22/23.
//

import SwiftUI

struct DetailView: View {
    
    let note: Note
    let count: Int
    let index: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            HStack {
                Capsule()
                    .frame(height: 1)
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }.foregroundColor(.accentColor)
            
            Spacer()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                Spacer()
                Text("\(index+1)/\(count)")
                Spacer()
                Image(systemName: "info")
                    .imageScale(.large)
            }.foregroundColor(.secondary)
            
        }.padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static var sampleData = Note(id: UUID(), text: "hello world")
    
    static var previews: some View {
        DetailView(note: sampleData, count: 5, index: 1)
    }
}
