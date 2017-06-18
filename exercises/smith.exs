smith = fn prefix ->
  fn name -> "#{prefix} #{name}" end
end

IO.puts(smith.("mrs").("smith"))
