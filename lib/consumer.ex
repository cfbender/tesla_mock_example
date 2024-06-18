defmodule MyBroadway do
  use Broadway

  def start_link(opts) do
    name = opts[:name] || __MODULE__

    Broadway.start_link(__MODULE__,
      name: name,
      producer: [module: {Broadway.DummyProducer, []}],
      processors: [
        default: [concurrency: 50]
      ],
      batchers: [
        default: [concurrency: 5, batch_size: 10, batch_timeout: 1000]
      ]
    )
  end

  def handle_message(_processor_name, message, _context) do
    {:ok, _response} = Tesla.get("https://github.com/elixir-tesla/tesla")
    message
  end

  def handle_batch(_, messages, _, _) do
    messages
  end
end
