let

 pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/2024-12-14.tar.gz") {};

 rpkgs = builtins.attrValues {
  inherit (pkgs.rPackages) quarto ggplot2 gmm Ecdat dplyr tidyr janitor tibble;
 };

 system_packages = builtins.attrValues {
  inherit (pkgs) R glibcLocalesUtf8 quarto;
 };

  in
  pkgs.mkShell {
    LOCALE_ARCHIVE = if pkgs.system == "x86_64-linux" then  "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive" else "";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";

    buildInputs = [ rpkgs system_packages ];
      
  }