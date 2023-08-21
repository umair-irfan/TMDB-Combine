//
//  SectionHeaderView.swift
//  TMDB-Combine
//
//  Created by umair irfan on 27/07/2023.
//

import SwiftUI

struct SectionHeader: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .padding(.leading, 5)
                //.foregroundStyle(.white)
            Spacer()
        }
    }
}
