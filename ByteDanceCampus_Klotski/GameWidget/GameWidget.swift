//
//  GameWidget.swift
//  GameWidget
//
//  Created by TH on 8/18/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct SmallWidget: View{
    var body: some View {
        Image("SmallWidget").resizable()
    }
}

struct MediumWidget: View{
    let todayRecommended = UserDefaults.standard.string(forKey: Klotski_today_String) ?? "横刀立马"
    
    var body: some View {
        GeometryReader { metrics in
            HStack{
                Text("华\n容\n道")
                    .font(.custom("PangMenZhengDao-Cu", fixedSize: 26.0))
                    .foregroundColor(.gray)
                    .padding()
                VStack{
                    HStack{
                        Text("今日推荐")
                            .font(.custom("PangMenZhengDao-Cu", fixedSize: 25))
                            .foregroundColor(.gray)
                            .frame(height: metrics.size.height * 0.33)
                        Image("ByteDanceLogo")
                    }
                    Text(todayRecommended)
                        .font(.custom("PangMenZhengDao-Cu", fixedSize: 42.0))
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
    }
}

struct LargeWidget: View{
    let todayRecommended = UserDefaults.standard.string(forKey: Klotski_today_String) ?? ""
    
    var body: some View {
        VStack{
            HStack{
                Text("华容道")
                Image("ByteDanceLogo")
            }
            HStack{
                Text("今日推荐")
                Text(todayRecommended)
            }
        }
    }
}

struct GameWidgetEntryView : View {
    var entry: Provider.Entry
    var family: WidgetFamily
    
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidget()
        case .systemMedium:
            MediumWidget()
        case .systemLarge:
            LargeWidget()
        default:
            EmptyView()
        }
    }
}

@main
struct GameWidget: Widget {
    let kind: String = "GameWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            GameWidgetEntryView(entry: entry,family: .systemSmall)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct GameWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameWidgetEntryView(entry: SimpleEntry(date: Date())
                                ,family: .systemSmall)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            GameWidgetEntryView(entry: SimpleEntry(date: Date())
                                ,family: .systemMedium)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            GameWidgetEntryView(entry: SimpleEntry(date: Date())
                                ,family: .systemLarge)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
