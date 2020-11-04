# MercadoLibreTest

Este proyecto se realizo como reto tecnico para mercado libre, enel cual se intenta replicar el funcionamiento basico de tres items, pantalla inicial, busqueda de elementos, vista detalle de un elemento 

# Technologies

The general development of the application was done in swift 5, and supports iOS 13.

# Launch

To Launch the application just download the repo and opent .xcodeproj , if you want to run the unitTest (MercadoLibreAppTest), and the UITest(MercadoLibreUIAppTest), just go to especific files and pres Comand + u 


# Development 

## Architecture

The application was built based on the MVVM design pattern, the main view has its respective view, viewmodel, and the model part is divided into Client, Request and  Network. 'these you will find inside the folder services'
NetWork: Is in charge of making the request as such, in this class you will find the session and the data task to launch the request .
Router: It is responsible for assembling the request you want to send, set the url, parameters and headers.
Client: It is responsible for joining the network with the router. ie launches the request event by adding the specific router. 

The way the viewController receives the response from the rejects is through a delegated protocol that implements the VC. The viewModel responds with the thin one by sending the object if required 
