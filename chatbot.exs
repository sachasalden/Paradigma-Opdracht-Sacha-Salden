defmodule Chatbot do
  @moduledoc """
  Eenvoudige chatbot die reageert op patronen in de invoer.
  """

  # Functie om de bot te starten
  def start do
    IO.puts("Chatbot gestart! Typ 'stop' om af te sluiten.")
    loop()
  end

  # Hoofdloop van de chatbot
  defp loop do
    input = IO.gets("> ") |> String.trim()

    case input do
      "stop" ->
        IO.puts("Tot ziens!")

      _ ->
        respond(input)
        loop()
    end
  end

  # Higher-order functie die een reactie geeft
  defp generate_response(fun) do
    fun.()
  end

  # Reageer op bepaalde invoer
  defp respond(input) do
    cond do
      String.contains?(input, "hallo") ->
        generate_response(fn -> IO.puts("Hoi! Hoe gaat het?") end)

      String.contains?(input, "hoe gaat") ->
        generate_response(fn -> IO.puts("Met mij gaat het prima, bedankt!") end)

      String.contains?(input, "naam") ->
        generate_response(fn -> IO.puts("Ik ben een simpele Elixir chatbot 🤖") end)

      true ->
        generate_response(fn -> IO.puts("Daar heb ik nog geen antwoord op...") end)
    end
  end
end

Chatbot.start()
