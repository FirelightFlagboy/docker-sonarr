def opt(f):
  . as $in | try f catch $in;

def semver_cmp:
    sub("\\+.*$"; "")
  | capture("^(?<v>[^-]+)(?:-(?<p>.*))?$") | [.v, .p // empty ]
  | map(split(".") | map(opt(tonumber)))
  | .[1] |= (. // {});

def latest_release:
  to_entries | sort_by(.value.version | semver_cmp) | last | .value;

def format_asset:
  {
    "filename": .url | split("/") | last,
    "download_url": .url,
    "digest": ["sha256", .hash] | join(":"),
  };

def to_output:
  {
    "version": .version,
    "assets": {
      "arm64": .linuxMusl.arm64.archive | format_asset,
      "amd64": .linuxMusl.x64.archive | format_asset,
    }
  };

. | latest_release | to_output
