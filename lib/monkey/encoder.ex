defimpl Poison.Encoder, for: Any do
  def encode(%{__struct__: _} = struct, options) do
    map =
      struct
      |> Map.from_struct()
      |> sanitize_map

    Poison.Encoder.Map.encode(map, options)
  end

  defp sanitize_map(map) do
    Map.drop(map, [:__meta__, :__struct__])
  end
end

defimpl Poison.Encoder, for: Monkey.Datapoints.Image do
  def encode(model, opts) do
    datapoint =
      model
      |> Map.take([
        :caption,
        :compression_format,
        :depth,
        :filesize,
        :height,
        :storage_path,
        :width
      ])
      |> Poison.Encoder.encode(opts)
  end
end

defimpl Poison.Encoder, for: Monkey.Labels.ImageClass do
  def encode(model, opts) do
    model
    |> Map.take([
      :class
    ])
    |> Poison.Encoder.encode(opts)
  end
end
