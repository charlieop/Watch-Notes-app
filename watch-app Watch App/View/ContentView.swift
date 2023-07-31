//
//  ContentView.swift
//  watch-app Watch App
//
//  Created by Charlie Chan on 7/21/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTY
    
    @State private var notes: [Note] = [Note(id: UUID(), text: "hello world")]
    @State private var text: String = ""
    
    // MARK: - FUNCTION
    
    func getDoccumentDir() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDoccumentDir().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("saving failed")
        }
    }
    
    func load() {
        DispatchQueue.main.async{
            do {
                let url = getDoccumentDir().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                print("loading failed")
            }
        }
    }
    
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add new note.", text: $text)
                    
                    Button {
                        // ACTION
                        guard text.isEmpty == false else { return }
                        let node = Note(id: UUID(), text: text)
                        notes.append(node)
                        text = ""
                        save()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                    //                                    .buttonStyle(BorderedButtonStyle(tint: .accentColor))
                    
                } //HStack
                Spacer()
                if notes.count > 0 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { i in
                            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    Text(notes[i].text)
                                        .lineLimit(1)
                                        .padding(.leading, 5)
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .opacity(0.25)
                        .padding(20)
                    Spacer()
                }
                
            } // VStack
            .padding()
            .onAppear(perform: load)
        } // NavView
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
