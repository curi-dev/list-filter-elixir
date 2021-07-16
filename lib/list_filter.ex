defmodule ListFilter do
  @numbers Enum.into(0..9, [], fn elem -> Integer.to_string(elem) end)

  def call(data) when not is_list(data) do
    {:error, "Only a list is permitted as parameter."}
  end

  def call(mix_list) do
    case all_strings(mix_list) do
      {:ok, _result} ->
        mix_list
        |> filter_numeric()
        |> parse_elements()
        |> filter_odd_numbers()
        |> verify_and_respond()

      {:error, _result} ->
        {:error, "Plase provide a list with only strings."}
    end
  end

  # maybe i can improve this function
  defp all_strings(list) do
    case Enum.all?(list, &String.valid?/1) do
      true -> {:ok, true}
      false -> {:error, false}
    end
  end

  defp filter_numeric(mix_list) do
    result =
      Enum.filter(mix_list, fn elem ->
        String.split(elem, "", trim: true)
        |> Enum.all?(fn value -> String.contains?(value, @numbers) end)
      end)

    result
  end

  defp parse_elements(string_list) do
    string_list
    |> Enum.map(fn elem -> String.to_integer(elem) end)
  end

  defp filter_odd_numbers(numbers_list) do
    Enum.filter(numbers_list, fn elem -> rem(elem, 2) != 0 end)
  end

  defp verify_and_respond(result) do
    case length(result) do
      0 -> {:ok, "There is no odd numbers in this list"}
      _ -> {:ok, result}
    end
  end
end
