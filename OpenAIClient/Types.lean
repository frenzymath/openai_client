import Lean
open Lean

structure OpenAIClient where
  baseUrl : String
  apiKey : String := ""
deriving Inhabited, Repr

structure OpenAIMessage where
  role : String
  content : String
deriving FromJson, ToJson, Repr

structure OpenAICompletionRequest where
  model : String
  prompt : String
  n : Nat := 8
  temperature : Float := 0.7
  max_tokens : Nat := 8192
  stream : Bool := false
  logprobs : Bool := false
deriving ToJson

structure OpenAIChatRequest where
  model : String
  messages : List OpenAIMessage
  n : Nat := 5
  temperature : Float := 0.7
  max_tokens : Nat := 8192
  stream : Bool := false
  logprobs : Bool := false
deriving ToJson

structure OpenAIChatCompletionTokenLogprob where
  token : String
  logprob : Float
deriving FromJson, Repr

structure OpenAIChoiceLogprobs where
  content: Option (List OpenAIChatCompletionTokenLogprob) := none
  refusal: Option (List OpenAIChatCompletionTokenLogprob) := none
deriving FromJson, Repr

structure OpenAIChatChoice where
  index : Nat
  message : OpenAIMessage
  logprobs : Option OpenAIChoiceLogprobs := none
deriving FromJson, Repr

structure OpenAICompletionChoice where
  text : String
deriving FromJson

structure OpenAIChatResponse where
  id : String
  choices : List OpenAIChatChoice
deriving FromJson, Repr

structure OpenAICompletionResponse where
  id : String
  choices : List OpenAICompletionChoice
deriving FromJson
