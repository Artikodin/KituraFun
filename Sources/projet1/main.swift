import Kitura
import HeliumLogger
import LoggerAPI
import KituraStencil

Log.logger = HeliumLogger()



// Initialize HeliumLogger
HeliumLogger.use()

// Create a new router
let router = Router()

router.viewsPath = "./Template"

router.setDefault(templateEngine : StencilTemplateEngine())

router.all(middleware: [BodyParser(), StaticFileServer(path: "./Public")])
// Handle HTTP GET requests to /

struct Message {
  let pseudo: String
  let msg: String
}

var messages = [Message]()

router.get("/") {
    request, response, next in
    try response.render("index", context: ["messages" : messages])
    response.status(.OK)
    next()
}

router.post("/post") {
    request, response, next in
    if(request.body != nil){
        switch request.body! {
        case .urlEncoded(let data):
            let pseudo = data["pseudo"] ?? ""
            let msg = data["msg"] ?? ""
            messages.insert(Message(pseudo: pseudo, msg: msg), at: 0)
        default:
            print("Formulaire de la deconne")
        }
    }
    try response.redirect("/");
    next()
    
}

router.get("/addMessage") {
    request, response, next in
    try response.render("addMessage", context: [:])
    next()
    
}

// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: 8080, with: router)

// Start the Kitura runloop (this call never returns)
Kitura.run()