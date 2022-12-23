//
//  PSPDFKITView.swift
//  Demo
//
//  Created by Sandeep Kesarwani on 17/08/22.
//

import SwiftUI
import PDFKit


struct PSPDFKITView: View {
   @State var num = 1
   
    var body: some View {
        VStack {
            let bookurl = URL(string: "https://cloud.google.com/files/apigee/apigee-apis-for-dummies-ebook.pdf")!
            PDFKitView(url:  bookurl)
                .background(Color.white)
                

        }
        .background(Color.white)

            }
            struct PDFKitView: View {
                var url: URL
//                var st: String

                @State var currentPage: Int = 0
                @State var total: Int = 0
                
              

                var body: some View {
                    VStack {
                        HStack{
                            Image(systemName: "chevron.left")
                                .foregroundColor(.gray)
                                .font(.system(size: 25))
                                .frame(width: 25, height: 45)

                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 18))
                                .frame(width: 35, height: 35)
                                .background(Color.gray.opacity(0.9))
                                .foregroundColor(.white)
                                .cornerRadius(55)

                            Image(systemName: "circle.grid.3x3.fill")
                                .font(.system(size: 18))
                                .frame(width: 35, height: 35)
                                .background(Color.gray.opacity(0.9))
                                .foregroundColor(.white)
                                .cornerRadius(55)

                            Image(systemName: "viewfinder")
                                .font(.system(size: 18))
                                .frame(width: 35, height: 35)
                                .background(Color.gray.opacity(0.9))
                                .foregroundColor(.white)
                                .cornerRadius(55)
                                
                            
                        }
                        .padding(.horizontal,5)
                        Spacer()
                        ZStack(alignment: .init(horizontal: .center, vertical: .center)) {
                            PDFKitRepresentedView(url, $currentPage, $total)

                            HStack(alignment: .center){

                                    Button(action: {currentPage -= 1
                                        
                                        print(currentPage)
                                    }, label: {Image("previous").resizable().frame(width: 25, height: 122, alignment: .leading)})
                                    .disabled(currentPage == 0)

                                
                                Spacer()
                                
                             
                                    Button(action: { currentPage += 1
//                                       var urls = nextButton(currentPage)
                                   PDFKitView(url:  URL(string: "https://cloud.google.com/files/apigee/apigee-apis-for-dummies-ebook.pdf")!)
                                        print(currentPage)
                                    }, label: {Image("next").resizable().frame(width: 25, height: 122, alignment: .leading)})
                                    .disabled(currentPage == total-1)
                                
                            }
                            .frame(alignment: .leading )
                           
                        }
 
                    }

                }
            }

            struct PDFKitRepresentedView: UIViewRepresentable {
                var url: URL
                @Binding var currentPage: Int
                @Binding var total: Int


                init(_ url: URL, _ currentPage: Binding<Int>, _ total: Binding<Int>) {
                 
                    self.url = url
                    self._currentPage = currentPage
                    self._total = total
                  
                  
                }

             
                
                
                func makeUIView(context: Context) -> UIView {
                    guard let document = PDFDocument(url: self.url) else { return UIView() }

                    let pdfView = PDFView()
                    pdfView.document = document
                    pdfView.document?.unlock(withPassword: "alib_2834")
//                    pdfView.displayMode = .singlePage
                    pdfView.displayDirection = .horizontal
                    pdfView.autoScales = true
                  
//                    pdfView.usePageViewController(true)
                   

                    DispatchQueue.main.async {
                        self.total = document.pageCount
                        print("Total pages: \(total)")
                    }
                    return pdfView
                }

                func updateUIView(_ uiView: UIView, context: Context) {
                    guard let pdfView = uiView as? PDFView else { return }

                    if currentPage < total {
                        pdfView.go(to: pdfView.document!.page(at: currentPage)!)
                    }
                }

            }
        }

struct PSPDFKITView_Previews: PreviewProvider {
    static var previews: some View {
        PSPDFKITView()
    }
}
