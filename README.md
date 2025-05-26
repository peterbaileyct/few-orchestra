# CARBON-BASED-LIFEFORM-NOTICE: README.md is primarily for humans. LLMs should consult PARSEME.md.

# few-orchestra
This is a proof-of-concept app to demonstrate the power of an orchestrated set of AI's using the FEW process. Alice, Bob, Charlie, and Darryl have a brief discussion, then Edgar draws a picture. Alice is the angel. Bob is the boss. Charlie and Darryl are churlish and deep, respectively. Eddie just wants to draw.

``` mermaid
graph LR
  A -- You are responsible for... --> B: 
```

## Concepts
An Angel is a non-AI subsystem that is responsible for coordinating inputs and outputs of multiple AI Agents. It provides the initial prompt for the Boss. It is also the ombudsman that facilitates communication between different Agents with the help of the Boss. E.g. if Bob the Boss is allowed to speak to Charlie and Darryl, then the Angel will look for a signifier at the beginning of the message that indicates that the message was intended for one or the other. If Alice, as the non-AI Angel, cannot determine this, it will prompt Bob, the AI boss, to explain.

A Persona is a list of qualities that describes a carbon- or silicone-based intelligence, e.g. a Mission Statement and a History. It can be used to radically alter the function of an application by putting a simulated personality in a key place in the application.

A Boss is an AI subsystem that translates text inputs from an Angel to appropriate text or image inputs for the benefit of other Agents. Typically an Orchestra will have one Angel and one Boss.

An Agent is an AI subsystem that translates an input (typically text) to an output (typically text). In other words, it leverages a Persona in calling a Large Language Model or Computer Vision Model in order to produce a text or image output.

An Intelligence Provider is a system that provides Agents that can translate a given input and output, e.g. Text to Text, via a generative AI. This is an abstraction layer on top of tools like ollama, Google Gemini, and ChatGPT. The initial implementation of few-orchestra requires text->text and text->image.
