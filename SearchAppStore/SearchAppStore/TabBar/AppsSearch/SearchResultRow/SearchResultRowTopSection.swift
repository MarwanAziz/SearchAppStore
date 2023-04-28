//
//  SearchResultRowTopSection.swift
//  SearchAppStore
//
//  Created by Marwan Aziz on 27/04/2023.
//

import SwiftUI

struct SearchResultRowTopSection: View {

    @ObservedObject var viewModel: SearchResultRowViewViewModel

    private func ratingStarts() -> some View {
        let ratingStars = viewModel.ratingStarts()

        return HStack(alignment: .top) {
            ForEach(ratingStars, id: \.id) { rateInfo in
                Image(systemName: rateInfo.systemImageName)
            }
        }
    }

    private var rowTopSectionAppIcon: some View {
        AsyncImage(url: URL(string: viewModel.iconURL), content: { image in
            image
                .resizable()
        },
        placeholder: {
            Color.secondary
        })
            .frame(width: 70, height: 70)
            .background(isPreview ? Color.red : .clear)
            .cornerRadius(15)
    }

    private var rowTopSectionTitlesAndRates: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.title)
                .font(.system(size: 14))
                .lineLimit(1)
            Text(viewModel.subtitle)
                .foregroundColor(.secondary)
                .font(.system(size: 12))
                .lineLimit(1)
            HStack (alignment: .center){
                ratingStarts()
                    .foregroundColor(.secondary)
                Text(viewModel.userRateCountInDisplayFormat())
                    .foregroundColor(.secondary)
                    .font(.system(size: 15))
            }
            .padding(.top, 4)
        }
    }

    private var rowTopSectionMoreButton: some View {
        let buttonTitle = viewModel.favourited ? "REMOVE" : "SAVE"
        return Button(action: {
            viewModel.AddRemoveButtonTapped()
        }) {
            HStack {
                Text(buttonTitle)
                    .fontWeight(.bold)
                    .font(.system(size: 11))
                    .frame(width: 70, height: 30, alignment: .center)
                    .background(Color.systemSecondary)
                    .foregroundColor(.accentColor)
                    .cornerRadius(15)
            }
        }
        .buttonStyle(.plain)
        .frame(maxHeight: .infinity, alignment: .center)
        .contentShape(Rectangle())
    }

    private var rowTopSection: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                rowTopSectionAppIcon
                rowTopSectionTitlesAndRates
                Spacer()
                rowTopSectionMoreButton
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
    }
    
    var body: some View {
        rowTopSection
    }
}

struct SearchResultRowTopSection_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SearchResultRowViewViewModel()
        SearchResultRowTopSection(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
