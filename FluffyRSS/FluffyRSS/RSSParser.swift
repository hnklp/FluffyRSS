//
//  RSSParser.swift
//  FluffyRSS
//
//  Created by Hynek Půta on 28/04/2025.
//

import Foundation

class RSSParser: NSObject, XMLParserDelegate {
    // třídní proměnné
    private var items: [FeedItem] = []
    private var currentElement = ""
    private var 👀 = "" //title
    private var currentLink = ""
    private var currentPubDate = ""
    private var currentText = ""

    private var channelTitleParsed = false
    private(set) var channelTitle = "Neznámý zdroj"
    private var insideItem = false

    
    init?(data: Data) {
        // inicializátor nadřazené třídy
        super.init()
        let parser = XMLParser(data: data)
        parser.delegate = self
        if !parser.parse() {
            return nil
        }
    }

    var itemsResult: [FeedItem] {
        items
    }

    // MARK: - Parser Delegate

    //ktery element jsme nacetli
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        currentText = ""
        
        if elementName == "item" {
            insideItem = true
            👀 = ""
            currentLink = ""
            currentPubDate = ""
        }
    }

    //text mezi tagy
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentText += string
    }

    //if insideitem then collect title, link, pubdate
    //after item collect channeltitle if not collected already
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let trimmed = currentText.trimmingCharacters(in: .whitespacesAndNewlines)

        if insideItem {
            switch elementName {
            case "title":
                👀 += trimmed
            case "link":
                currentLink += trimmed
            case "pubDate":
                currentPubDate += trimmed
            case "item":
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"

                let parsedDate = formatter.date(from: currentPubDate)

                let item = FeedItem(
                    id: UUID(),
                    title: 👀,
                    link: currentLink,
                    pubDate: parsedDate,
                    sourceTitle: channelTitle
                )
                items.append(item)
                insideItem = false
            default:
                break
            }
        } else if elementName == "title", !channelTitleParsed {
            channelTitle = trimmed
            channelTitleParsed = true
        }
    }
}
