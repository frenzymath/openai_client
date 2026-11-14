module
public meta import Requests
public meta import OpenAIClient.Types

open Lean
public meta section
def getOpenAIRequestHeaders (apiKey : String) : Requests.Headers :=
  if apiKey.isEmpty then
    #[
      ("Accept", "application/json"),
      ("Content-Type", "application/json")
    ]
  else
    #[
      ("Accept", "application/json"),
      ("Content-Type", "application/json"),
      ("Authorization", s!"Bearer {apiKey}")
    ]

namespace OpenAIClient

def generateCompletion (client : OpenAIClient) (req : OpenAICompletionRequest) : Requests.RequestIO OpenAICompletionResponse := do
  let completeUrl := client.baseUrl ++ "/completions"
  Requests.post completeUrl req <| getOpenAIRequestHeaders client.apiKey

def generateChat (client : OpenAIClient) (req : OpenAIChatRequest) : Requests.RequestIO OpenAIChatResponse := do
  let chatUrl := client.baseUrl ++ "/chat/completions"
  Requests.post chatUrl req <| getOpenAIRequestHeaders client.apiKey

end OpenAIClient
