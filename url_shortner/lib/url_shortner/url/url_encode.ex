defmodule UrlShortner.Url.UrlEncode do
  # encoding the url

  # thi will produce a unicode code
    def encode_url(params) do

      # this will generate a unique key
    new_encode = :crypto.strong_rand_bytes(5)
    |> Base.encode64(padding: false)

    # this will replace with the new string
    String.replace(params, params, new_encode)
  end
end
