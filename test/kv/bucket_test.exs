defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link([])
    %{bucket: bucket}
  end

  test "if the key does not exists the bucket will returns `nil`", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "does-not-exists") == nil
  end

  test "Bucket.put will create a key with the specified value", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end
end
