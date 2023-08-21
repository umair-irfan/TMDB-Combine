//
//  SectionItemView.swift
//  TMDB-Combine
//
//  Created by umair irfan on 31/07/2023.
//

import SwiftUI

struct SectionItemView<Content: View>: View {
    
    var section: Layout
    var carousel: (Program) -> Content
    
    init(section: Layout, @ViewBuilder carousel: @escaping (Program) -> Content) {
        self.section = section
        self.carousel = carousel
    }
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 250))]) {
                ForEach(section.module.content, id: \.id){ content in
                    carousel(content)
                }
            }
        }
    }
    
}

//struct SectionItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        SectionItemView(section: Layout.mockData.first!)
//    }
//}
