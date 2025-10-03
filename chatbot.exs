defmodule Chatbot do
  @moduledoc """
  Chatbot met patronen en antwoordopties via higher-order functions.
  """

  def start do
    IO.puts("Chatbot gestart! Typ 'stop' om af te sluiten.")
    loop()
  end

# Ik maak hier een eigen loop zodat je na elke input weer terugkomt in de loop todat je stop typt
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

  # Nu verwacht generate_response gewoon een string en print deze inplaats van dezelfde io functie de heletijd aan te roepen
  defp generate_response(message) when is_binary(message) do
    IO.puts(message)
  end

  defp respond(input) do
    cond do
      String.contains?(input, "hallo") ->
        generate_response("Hoi! Hoe gaat het met je?")

      String.contains?(input, "hoe gaat") ->
        generate_response("Met mij gaat het prima! En met jou?")
        show_options([
          {"Goed!", "Mooi zo! Blijf zo doorgaan 😃"},
          {"Mwah, kan beter.", "Hopelijk knapt je dag nog op 💪"},
          {"Niet zo best...", "Sterkte! Praat erover met iemand die je vertrouwt ❤️"}
        ])

      String.contains?(input, "grap") ->
        generate_response("Wil je een grap horen?")
        show_options([
          {"Ja, vertel een grap!", "Waarom zijn Elixir-programmeurs altijd vrolijk? Alles is immutable! 😂"},
          {"Nee, liever niet.", "Geen probleem! We kletsen gewoon verder 🙂"}
        ])

      String.contains?(input, "naam") ->
        generate_response("Ik ben een simpele chatbot 🙂")

      true ->
        generate_response("Daar heb ik nog geen antwoord op...")
    end
  end

  # De opties worden door middel van high-order functies gegenereerd de gebruiker kiest een nummer en de bijbehorende string wordt doorgegeven aan generate_response
  defp show_options(options) do
    Enum.with_index(options, 1)
    |> Enum.each(fn {{label, _}, i} -> IO.puts("#{i}. #{label}") end)

    choice =
      IO.gets("Kies een optie (nummer): ")
      |> String.trim()
      |> Integer.parse()

    case choice do
      {num, _} when num >= 1 and num <= length(options) ->
        {_label, message} = Enum.at(options, num - 1)
        generate_response(message)

      _ ->
        IO.puts("Ongeldige keuze, probeer opnieuw.")
    end
  end
end

Chatbot.start()
