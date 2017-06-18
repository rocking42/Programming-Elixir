defmodule Scheduler do
  def run(num, module, func, to_calc) do
    (1..num)
    |> Enum.map(fn(_) -> spawn(module, func, self()) end)
    |> schedule_proc(to_calc, [])
  end

  def schedule_proc(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [next|tail] = queue
        send pid, {:fib, next, self()}
        schedule_proc(processes, tail, results)
      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_proc(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1,_}, {n2,_} -> n1 <= n2 end)
        end
      {:answer,number,result,_pid} ->
        schedule_proc(processes, queue, [{number,result}|results])
    end
  end
end
