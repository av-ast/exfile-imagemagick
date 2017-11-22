defmodule ExfileImagemagick.Montage do
  @moduledoc """
  Montage a composite image by combining several separate images

  Options:

  * `:format` - the desired format the output file should be in. Example: jpeg, png, gif, etc.
  * `:extra_args` - extra arguments for GM utility. Example: "-geometry 163x210 -quality 100".
  """

  @behaviour Exfile.Processor

  import ExfileImagemagick.Utilities
  alias Exfile.LocalFile

  alias ExfileImagemagick.SysRunner

  def call(file, opts) do
    file = coerce_to_file(file)

    new_path = Exfile.Tempfile.random_file!("imagemagick")
    destination = destination_with_format(new_path, opts)

    montage_args = extra_args(opts) ++ [file.path, destination]

    case SysRunner.cmd("montage", montage_args) do
      {_, 0} ->
        {:ok, %LocalFile{path: new_path}}
      {error, _} ->
        {:error, error}
    end
  end
end
