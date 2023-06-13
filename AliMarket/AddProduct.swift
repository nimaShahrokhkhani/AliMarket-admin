//
//  AddProduct.swift
//  AliMarket
//
//  Created by Nima on 6/10/23.
//

import SwiftUI

struct AddProduct: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isSourceImagePickerPresented = false
    @State private var source: UIImagePickerController.SourceType = .photoLibrary
    @State private var product = ProductModel()
    @State private var name: String = ""
    @State private var selectedBrand: String = Brand.brandList[0].name
    @StateObject private var imageUploader = ImageUploader()
    @State private var isUploading = false
    let sizeList = ["xxl", "xl", "large", "medium", "small", "xs"]
    
    var body: some View {
        Form {
            Section("Image") {
                VStack {
                    HStack {
                        Button("Image") {
                            isSourceImagePickerPresented = true
                        }
                        Spacer()
                        Image(systemName: "camera")
                    }
                    if isUploading {
                        ProgressView(value: imageUploader.progress.fractionCompleted)
                            .padding()
                    }
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            Section("Name") {
                TextField("Name", text: $product.name)
            }
            Section("Category") {
                Picker("Category", selection: $product.category) {
                    ForEach(Category.allCases, id: \.rawValue) { item in
                        switch item {
                        case .MEN:
                            Text("Men")
                        case .WOMEN:
                            Text("Women")
                        case .KIDS:
                            Text("Kids")
                        }
                    }
                }
                .pickerStyle(.segmented)
            }
            Section("Type") {
                TextField("Type", text: $product.type)
            }
            Section("Price") {
                HStack {
                    Text("$")
                        .foregroundColor(.gray)
                    TextField("Price", text: $product.price)
                        .keyboardType(.decimalPad)
                }
            }
            Section("Description") {
                TextEditor(text: $product.description)
                    .frame(height: 4 * UIFont.preferredFont(forTextStyle: .body).lineHeight)
                
            }
            Section("Brand") {
                Picker("Brand", selection: $selectedBrand) {
                    ForEach(Brand.brandList, id: \.name) { brand in
//                        AsyncImage(url: URL(string: brand.icon))
                        Text(brand.name)
                    }
                }
//                .onChange(of: selectedBrand) { newValue in
//                    print("Selected Brand: \(newValue)")
//                    selectedBrand = newValue
//                }
                .pickerStyle(.menu)
            }
            Section("Count") {
                TextField("Count", text: $product.count)
            }
            Section("Size") {
                HStack {
                    ForEach(sizeList, id: \.self) { size in
                        Button(action: {
                            
                        }) {
                            Text(size)
                                .background(product.size.contains(size) ? Color.red : Color.clear)
                                .cornerRadius(5)
                        }
                        .onTapGesture {
                            if product.size.contains(size) {
                                product.size.removeAll {$0 == size}
                            } else {
                                product.size.append(size)
                            }
                        }
                    }
                }
            }
            
            ZStack {
                HStack {
                    Spacer()
                    if !isUploading {
                        Button("Add Product") {
                            isUploading = true
                            if let selectedImage = selectedImage {
                                imageUploader.uploadImage(image: selectedImage) { result in
                                    let imageUrl = try! result.get().absoluteString
                                    let brand = Brand.brandList.first(where: {$0.name == selectedBrand})
                                    let finalProduct = Product(name: product.name, dateTime: Int(Date().timeIntervalSince1970) * 1000, category: product.category, price: Double(product.price), star: 0, isMyFavourit: false, brand: brand
                                                               ,description: product.description, type: product.type, imageUrl: imageUrl, count: Int(product.count), size: product.size)
                                                                        
                                    ProductViewModel().addProduct(product: finalProduct, completion: { result in
                                        print(try! result.get())
                                        if try! result.get() == "succesfull" {
                                            isUploading = false
                                            presentationMode.wrappedValue.dismiss()
}
                                    })
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    Spacer()
                }
                if isUploading {
                    ProgressView()
                }
            }
            .listRowBackground(Color(UIColor.systemGroupedBackground))
            
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(source: source, selectedImage: $selectedImage)
        }
        .actionSheet(isPresented: $isSourceImagePickerPresented) {
            ActionSheet(title: Text("Choose an option..."), buttons: [
                .default(Text("Photo Library"), action: {
                    source = .photoLibrary
                    isImagePickerPresented = true
                }),
                .default(Text("Camera"), action: {
                    source = .camera
                    isImagePickerPresented = true
                }),
                .cancel()
            ])
        }
    }
}

struct AddProduct_Previews: PreviewProvider {
    static var previews: some View {
        AddProduct()
    }
}
