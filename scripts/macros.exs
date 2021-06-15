defmodule Unless do
	def fun_unless(clause, do: expression) do
		if(!clause, do: expression)
	end

	defmacro macro_unless(clause, do: expression) do
		quote do
			if(!unquote(clause), do: unquote(expression))
		end
	end
end

# require Unless
# Unless.macro_unless true, do: IO.puts "this shoud never be printed"

# Esse vai imprimir o resultado porque o `IO.puts` é executado antes de chamar
# a função  `fun_unless`
# Unless.fun_unless true, do: IO.puts "this shoud never be printed"

# Isso acontece porque a macro sempre receber uma quoted expression, ou seja,
# não executa a função.


# Uma macro não impacta uma variável de onde ele está sendo chamado
defmodule Hygiene do
	defmacro no_interference do
		quote do: a = 1
	end
end

defmodule HygieneTest do
	def go do
		require Hygiene
		a = 13
		Hygiene.no_interference()
		a
	end
end

IO.puts HygieneTest.go
# => 13

# A não ser que você use `var!` na macro
defmodule Hygiene do
	defmacro no_interference do
		quote do: var!(a) = 1
	end
end

defmodule HygieneTest do
	def go do
		require Hygiene
		a = 13
		Hygiene.no_interference()
		a
	end
end

IO.puts HygieneTest.go
# => 1


# Criar variáveis dinamicamente

defmodule Sample do
  defmacro initialize_to_char_count(variables) do
    Enum.map variables, fn(name) ->
      var = Macro.var(name, nil)
      lenght = name |> Atom.to_string()|> String.length()
      quote do
        unquote(var) = unquote(lenght)
      end
    end
  end

  def run do
    initialize_to_char_count [:red, :green, :yellow]
    [red, green, yellow]
  end
end

IO.inspect(Sample.run)
