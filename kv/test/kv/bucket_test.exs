defmodule KV.BucketTest do
  # The async option allows to run multiple tests simultaneously
  # However, async must only be set to true when the test does not
  # rely on or change any global values.
  use ExUnit.Case, async: true

  setup do
    # By using the start_supervised!/1 function, ExUnit will
    # guarantee that the registry process will be shutdown
    # 'before' the next test starts.
    bucket = start_supervised!(KV.Bucket)
    %{bucket: bucket}
  end

  test "Store values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3

    assert KV.Bucket.delete(bucket, "milk") == 3
    assert KV.Bucket.get(bucket, "milk") == nil
  end
end
