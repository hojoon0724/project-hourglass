//
//  showClient.swift
//  hourglass
//
//  Created by Hojoon Kim on 4/12/24.
//

import SwiftUI

struct showClient: View {
    @Bindable var client: Client

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var sortedSessions: [Session] {
        client.sessions.sorted { first, second in
            first.startTime < second.startTime
        }
    }

    var body: some View {
        Form {
            HStack(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/, content: {
                Text("Client")
                Spacer()
                TextField("Name", text: $client.name)
                    .multilineTextAlignment(.trailing)
            })
            HStack(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/, content: {
                Text("Remaining Time")
                Spacer()
                Text("\(secondsToFullTime($client.time.wrappedValue))")
                    .monospaced()
            })
            if !client.sessions.isEmpty {
                Section("Sessions") {
                    ForEach(sortedSessions) { session in
                        VStack {
                            HStack {
                                Text(String("\(session.startTime.formatted())"))

                                Spacer()
                                Text(String("\(session.endTime?.formatted() ?? "")"))
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        showClient(client: SampleData.shared.client)
    }
}
