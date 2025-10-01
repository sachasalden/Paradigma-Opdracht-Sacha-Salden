defmodule Chatbot do
  @moduledoc """
  Chatbot met patronen en antwoordopties via higher-order functions.
  """

  def start do
    IO.puts("Chatbot gestart! Typ 'stop' om af te sluiten.")
    loop()
  end

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

  defp generate_response(fun), do: fun.()

  defp respond(input) do
    cond do
      String.contains?(input, "hallo") ->
        generate_response(fn -> IO.puts("Hoi! Hoe gaat het met je?") end)

      String.contains?(input, "hoe gaat") ->
        IO.puts("Met mij gaat het prima! En met jou?")
        show_options([
          {"Goed!", fn -> IO.puts("Mooi zo! Blijf zo doorgaan 😃") end},
          {"Mwah, kan beter.", fn -> IO.puts("Hopelijk knapt je dag nog op 💪") end},
          {"Niet zo best...", fn -> IO.puts("Sterkte! Praat erover met iemand die je vertrouwt ❤️") end}
        ])

      String.contains?(input, "grap") ->
        IO.puts("Wil je een grap horen?")
        show_options([
          {"Ja, vertel een grap!", fn -> IO.puts("Waarom zijn Elixir-programmeurs altijd vrolijk? Alles is immutable! 😂") end},
          {"Nee, liever niet.", fn -> IO.puts("Geen probleem! We kletsen gewoon verder 🙂") end}
        ])

      String.contains?(input, "naam") ->
        generate_response(fn -> IO.puts("Ik ben een simpele chatbot ") end)

      true ->
        generate_response(fn -> IO.puts("Daar heb ik nog geen antwoord op...") end)
    end
  end

  # Hier gebruiken we een higher-order function: de opties zijn tuples van {label, functie}
  defp show_options(options) do
    Enum.with_index(options, 1)
    |> Enum.each(fn {{label, _}, i} -> IO.puts("#{i}. #{label}") end)

    choice =
      IO.gets("Kies een optie (nummer): ")
      |> String.trim()
      |> Integer.parse()

    case choice do
      {num, _} when num >= 1 and num <= length(options) ->
        {_label, action} = Enum.at(options, num - 1)
        generate_response(action)   # hier roep ik de gekozen functie aan

      _ ->
        IO.puts("Ongeldige keuze, probeer opnieuw.")
    end
  end
end

Chatbot.start()
