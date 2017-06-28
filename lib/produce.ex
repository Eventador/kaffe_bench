require Logger

messages_count = 20000

defmodule KaffeTestProducer do
  # Test configuration
  @topic "elixirtesting"
  @report_threshold 40  # milliseconds

  def runner(messages) do
    send_message(messages)
  end

  def send_message(n) do
    if n > 0 do
      key = ""
      value = ~s({"a":"#{UUID.uuid4()}","timestamp":#{:os.system_time(:milli_seconds)},"c":"aBcDeFgHiJk","d":"This is a test","e":"#{UUID.uuid4()}","f":"testing"})

      t_start = :os.system_time(:milli_seconds)
      try do
        Kaffe.Producer.produce_sync(@topic, key, value)
      rescue
        e -> e
      catch
        e -> e
      after
        t_end = :os.system_time(:milli_seconds)
        t_diff = t_end - t_start
        if t_diff > @report_threshold do
          Logger.log(:info, "Message #{n} Took: #{t_diff}")
        end
        send_message(n - 1)
      end
    end
  end
end

run_start = :os.system_time(:milli_seconds)
KaffeTestProducer.runner(messages_count)
run_end = :os.system_time(:milli_seconds)

messages_sec = (messages_count / (run_end - run_start))*1000
Logger.log(:info, "Run took #{run_end - run_start} ms, #{messages_count} messages, #{messages_sec} msg/sec")
