defmodule TestCase do
  # Callback invoked by `use`.
  #
  # For now it returns a quoted expression that
  # imports the module itself into the user code.
  @doc false
  defmacro __using__(_opts) do
    quote do
      import TestCase

      # Initialize @tests to an empty list
      @tests []

      # Invoke TestCase.__before_compile__/1 before the module is compiled
      @before_compile TestCase
    end
  end

  @doc """
  Defines a test case with the given description.

  ## Examples

      test "arithmetic operations" do
        4 = 2 + 2
      end

  """
  defmacro test(description, do: block) do
    function_name = String.to_atom("test " <> description)
    quote do
      @tests [unquote(function_name) | @tests]
      def unquote(function_name)(), do: unquote(block)
    end
  end


  # This will be invoked right before the target module is compiled
  # giving us the perfect opportunity to inject the `run/0` function
  @doc false
  defmacro __before_compile__(_env) do
    quote do
      def run do
        Enum.each @tests, fn name ->
          IO.puts "Running #{name}"
          apply(__MODULE__, name, [])
        end
      end
    end
  end
end

defmodule MyTest do
  use TestCase

  test "hello" do
    "hello" = "world"
  end
end

MyTest.run()
