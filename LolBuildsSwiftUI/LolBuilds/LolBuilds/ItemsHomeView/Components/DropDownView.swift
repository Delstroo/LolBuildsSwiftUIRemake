//
//  PopoverView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/18/23.
//

import SwiftUI

struct DropDown: View {
    @ObservedObject private var viewModel = ItemHomeViewModel()
    //    @State private var selectedCategory: ItemAttribute = .health // Default category
    @State private var isDropdownOpen = false
    var filterAction: () -> Void
    @State var selectedCategory = "All"

    var body: some View {
        VStack() {
            ZStack {
                Button(action: {
                    withAnimation {
                        viewModel.isDropdownOpen.toggle()
                    }
                }) {
                    ZStack {
//                        RoundedRectangle(cornerRadius: 12)
//                            .frame(width: 54, height: 54)
//                            .foregroundColor(.blue)
                        
                        HStack {
                            Text(selectedCategory)
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.white)
                            
                            
                            Image(systemName: "chevron.up")
                                .foregroundColor(.white)
                                .font(.title3)
                                .rotationEffect(.degrees(viewModel.isDropdownOpen ? 0 : 180)) // Rotate 180 degrees when transitioning
                                .padding(.trailing, 8)
                        }
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 25))

                    }
                }
                .frame(width: UIScreen.main.bounds.width, alignment: .trailing)
            }
            
            if viewModel.isDropdownOpen {
                            VStack(alignment: .leading) {
                                ScrollView {
                                    ForEach(Array(ItemHomeViewModel.ItemAttribute.allCases), id: \.self) { category in
                                        Button {
                                            // Set viewModel.categorySelected directly
                                            viewModel.categorySelected = category.rawValue
                                            self.selectedCategory = category.rawValue
                                            UserDefaults().setValue(category.rawValue, forKey: "itemCategory")
                                            withAnimation(.easeInOut) {
                                                viewModel.isDropdownOpen.toggle()
                                            }
                                            filterAction()
                                        } label: {
                                            Text(category.rawValue.replaceCapitalLetters())
                                    .foregroundColor(selectedCategory == category.rawValue ? .blue : Color.label)
                                
                                        }
                            .onTapGesture {
                                    viewModel.categorySelected = category.rawValue
                                withAnimation {
                                    viewModel.isDropdownOpen.toggle()
                                }
                            }
                            .padding(.vertical, 5)
                            .padding(.horizontal, 12)
                            .transition(.opacity)
                            .opacity(viewModel.isDropdownOpen ? 1 : 0)
                        }
                    }
                }
                .frame(height: 250)
                .background(Color.secondarySystemBackground)
                .cornerRadius(5)
                .shadow(radius: 2)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
            }
        }
    }
}

#Preview {
    DropDown(filterAction: {})
}
