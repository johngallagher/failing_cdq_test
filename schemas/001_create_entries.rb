schema "001" do
  entity "Entry" do
    datetime :startedAt
    datetime :finishedAt

    integer64 :duration
  end
end
