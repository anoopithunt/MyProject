
import SwiftUI

struct SearchBar: View {
    
    @State var text: String
    
    var body: some View {
        VStack {
            
            ZStack {
                // background
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.yellow)
                    .frame(height: 36)
                
                HStack(spacing: 6) {
                    Spacer()
                        .frame(width: 0)
                    
                    // 􀊫
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white)
                    
                    // TextField
                    TextField("Search", text: $text)
//                        .placeholder(when: text.isEmpty, color: Color.gray) {
//                            Text("Search")
//                     }
                    Spacer()
                    // 􀁑
                    if !text.isEmpty {
                        Button {
                            text.removeAll()
                       
                        } label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 6)
                    }
                }
            }
            .padding(.horizontal)
        }.background(Color.red.opacity(0.3))
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: "")
//        HomePageSlide()
    }
}
