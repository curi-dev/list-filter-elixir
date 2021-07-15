defmodule ListFilter do
  def call(data) when not is_list(data) do
    {:error, "Please provide a list"}
  end

  def call(mix_list) do
    mix_list
    |> filter_numeric()
    |> filter_odd_numbers()
    |> verify_result()
  end

  defp verify_result(result) do
    case length(result) do
      0 -> {:ok, "There is no odd numbers in this list"}
      _ -> {:ok, result}
    end
  end

  defp filter_numeric(mix_lixt) do
    Enum.filter(mix_lixt, fn elem -> is_integer(elem) end)
  end

  defp filter_odd_numbers(numbers_list) do
    Enum.filter(numbers_list, fn elem -> rem(elem, 2) != 0 end)
  end
end
