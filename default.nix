{ pkgs, ... }:
{
  shell = pkgs.mkShell {
    buildInputs = with pkgs; [
      slirp4netns
    ];
  };
}
