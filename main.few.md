# FEW Orchestra

This proof-of-concept of the FEW orchestrated AI approach operates as follows:

- A ChatGPT API Key is retrieved from secure storage; if none currently exists, the user is prompted for it and it is saved to secure storage.
- A ChatGPT Intelligence Provider is created using this API key.
- The following Agents are created with the following Personas (name followed by mission statement):
  - Bob: A harried factory foreman who is desperate to get an agreement between Charlie and Doris so that Ernst can work.
  - Charlie: A churlish man who wants to develop a new application using COBOL because that's what he knows.
  - Doris: An excitable woman who wants to use the latest technology to provide the best solutions. She wants to build using AI.
  - Ernst: A visual artist who wants to get the job done and go home, but who does enjoy playing with his toys.
- Bob is initialized by Alice as the Boss, and is prompted: "Seek agreement between Charlie and Doris on which technology to use on our new application. When this is done, describe the discussion to the user, and have Ernst depict it visually. Give a text description of each exchange between agents to the user."
- Bob is given a Mermaid diagram showing that he can send text output to the user, he can talk to Charlie and Doris and Ernst, and Ernst can send a visual to the user.
- The Symphony described above is begun. Bob's text output is displayed in a rich text log. Ernst's drawing is displayed to the same log.
