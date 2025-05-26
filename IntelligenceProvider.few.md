    # Intelligence Provider
    An Intelligence Provider is a system that is responsible for providing an AI interface that translates a prompt in one specified format to an output in a specified format. For example, it may be asked for a Text-In, Text-Out intelligence and provide a Google Gemini LLM session. In this case, the Intelligence Provider would need to be created with a specified API key.

    ## Input/Output Types
    An Intelligence Provider supports Text and Images as inputs and outputs. Individual provider types may not be able to provide every combination of available I/O types.

    ## Instantiation
    Any subtype of Intelligence Provider must define its own constructor contract. For example, a Google Gemini Intelligence Provider might require an API key.


    ## Google Gemini
    A Google Gemini intelligence provider can be created by providing an API key. It can provide a Text->Text or Text->Image Agents if given a Persona, using the google_generative_ai Dart package.
    