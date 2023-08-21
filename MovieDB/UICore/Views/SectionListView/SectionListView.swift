//
//  SectionListView.swift
//  TMDB-Combine
//
//  Created by umair irfan on 31/07/2023.
//

import SwiftUI

struct SectionListView<Content: View>: View {
    
    var sections: [Layout]
    var content: (Layout) -> Content
    
    init(sections: [Layout], @ViewBuilder content: @escaping (Layout) -> Content) {
        self.sections = sections
        self.content = content
    }
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 250))]) {
            ForEach(sections, id: \.id) { section in
                Section(header: SectionHeader(title: section.title)) {
                    content(section)
                }
            }
        }
    }
    
//    var body: some View {
//        LazyVGrid(columns: [GridItem(.adaptive(minimum: 250))]) {
//            ForEach(sections, id: \.id) { section in
//                Section(header: SectionHeader(title: section.title)) {
//                    SectionItemView(section: section)
//                }
//            }
//        }
//    }
}

//struct SectionListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SectionListView(sections: [])
//    }
//}
