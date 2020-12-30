### Brief summary
So, what’s the whole point of this? Well, during the mission, Auris will be flying over the Earth collecting data. Because its storage capacity is finite, the satellite will eventually need to downlink its data in order to be successful in its mission. The satellite can’t downlink at any time, because we have a finite number of ground stations we can downlink to, and the times when it is collecting data are not uniform, so everything is variable (BUT, they are all dependent on time, which is good, because that means we can model it).

Basically, the idea of this application would be to take in inputs such as current position, current storage, and current time, and output the best times to downlink. It will output a range of times that will make it easier to make decisions about when to downlink. Constants include data rates, location of ground stations, and info about the satellite such as storage capacity. These constants could be controlled through a config file. Also, every downlink costs money, so the purpose of the application is to minimize costs by optimizing the downlinking times while retaining all of the mission data. The application will be primarily written with the Auris mission in mind, but the idea is to make this accessible to future missions, not just Auris. If this application is developed in time, it could even be implemented during mission operations for Stratus.



### More documentation
https://docs.google.com/document/d/1YOChiQLyRnPaX0hLRmEjBCIv2O7e-1wwqxq_aRixu6A/edit?usp=sharing
