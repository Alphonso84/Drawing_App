//
//  ContentView.swift
//  Drawing_App
//
//  Created by Alphonso Sensley II on 11/6/21.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    var body: some View {
        DrawingHome()
    }
}

struct DrawingHome: View {
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color: Color = .blue
    var body: some View{
        NavigationView{
            //Drawing View
            VStack {
                DrawingView(canvas: $canvas, isDraw: $isDraw, color: $color)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        HStack {
                            Button(isDraw ? "| Erase |" : "Draw") {
                                isDraw.toggle()
                            }
                            .padding()
                            ColorPicker("Color Picker", selection: $color)
                    }
                }
            }
        }
    }
}

struct DrawingView : UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isDraw: Bool
    @Binding var color: Color
    
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        let ink = PKInkingTool(.pencil, color:UIColor(color))
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDraw ? ink : eraser
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        //updating tool whenever mainView updates
        let ink = PKInkingTool(.pencil, color:UIColor(color))
        uiView.tool = isDraw ? ink : eraser
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
