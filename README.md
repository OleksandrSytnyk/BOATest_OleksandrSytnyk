# BOATest_OleksandrSytnyk

Notes on the task:
- JSON of the response doesn’t contain an array of 6 attributes. It’s a nested dictionary, the closest to the array with
6 attributes I found in it is in inAuthV2 node - that’s what I parsed out. Used “file” as a “name”. 

Notes on the architecture:
- Using different layers in the app. On this small scale it’s not important but as the application scales it’s important to
separate responsibilities, so I wanted to showcase that.
- Using protocol oriented MVVM for the cells

TODOs:
- Add Unit tests
- Separate model for the response vs File because we’re using Codable protocol to decode from Json, it’s right now directly 
in the model, which breaks encapsulation. We should create a separate model eg. FileNetworkResponse and move all the parsing 
there. There would be a method creating a list of Files from that response and then NetworkManager would return that and
encapsulate all network related logic in it.
- Custom table view cell
