{ pkgs }:
let
  ggkeyboard = pkgs.rPackages.buildRPackage {
    name = "ggkeyboard";
    src = pkgs.fetchgit {
      url = "https://github.com/b-rodrigues/ggkeyboard";
      rev = "e7d2e63e672be95830f2ae89bf33b8c34185e1f8";
      sha256 = "sha256-Bd3QYtVC4dDdk4/EccCmxgL2QegmwvAhHWATuZVGM/I=";
    };
    propagatedBuildInputs = with pkgs.rPackages; [
      dplyr
      ggplot2
      stringr
      prismatic
      rlang
      ggforce
      purrr
    ];
  };

  lbkeyboard = pkgs.rPackages.buildRPackage {
    name = "lbkeyboard";
    src = pkgs.fetchgit {
      url = "https://github.com/b-rodrigues/lbkeyboard";
      rev = "d728eb0a46b4c7ea26cfee4367b8c74f67265348";
      sha256 = "sha256-LaJBLzdfxyjeZLmQP0m38z8ZY3QJHSqnDIbSMmrhhQk=";
    };
    propagatedBuildInputs = with pkgs.rPackages; [
      dplyr
      ggplot2
      stringr
      tidyr
      purrr
      rlang
      cli
      Rcpp
      GA
      ggkeyboard
    ];
  };
in
[
  lbkeyboard
  ggkeyboard
  pkgs.rPackages.dplyr
  pkgs.rPackages.tinytable
  pkgs.rPackages.ggplot2
]

