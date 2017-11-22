defmodule ExfileImagemagick.MontageTest do
  use ExUnit.Case, async: true

  alias Exfile.LocalFile

  test "it works" do
    path = EITH.image_path("DSC08511s25.jpg")
    file = %LocalFile{path: path}
    {:ok, file} = ExfileImagemagick.Montage.call(file, [extra_args: "-geometry 100x100 -quality 100", format: "png"])
    {:ok, file} = ExfileImagemagick.Metadata.call(file, [], [])

    assert file.meta["format"] == "PNG"
    assert file.meta["image_size"] == "100x100"
  end
end
