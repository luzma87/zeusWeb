package arazu

class PdfViewerTagLib {
    static defaultEncodeAs = [taglib: 'none']
    //static encodeAsForTags = [tagName: [taglib:'html'], otherTagName: [taglib:'none']]

    def pdfViewer = {attrs->
       def url =  request.scheme + "://" + request.serverName + ":" + request.serverPort
        out<< render(template:"/templates/pdfViewer",model: ["url":url])
    }

}
