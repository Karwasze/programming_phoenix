defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       score: 0,
       message: "Take a guess",
       session_id: session["live_socket_id"]
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-number= {n} ><%= n %></a>
      <% end %>
      <pre>
        <%= @current_user.email %>
        <%= @session_id %>
      </pre>
    </h2>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string
  end

  def generate_winning_number() do
    Enum.random(1..10) |> to_string()
  end

  def handle_event("guess", %{"number" => guess} = _data, socket) do
    winning_number = socket.assigns.winning_number

    won? =
      case guess do
        ^winning_number -> true
        _ -> false
      end

    message =
      if won? do
        "Your guess: #{guess}, was correct."
      else
        "Your guess: #{guess}, was incorrect, try again."
      end

    score =
      if won? do
        socket.assigns.score + 1
      else
        socket.assigns.score - 1
      end

    time = time()
    {:noreply, assign(socket, message: message, score: score, time: time)}
  end
end
