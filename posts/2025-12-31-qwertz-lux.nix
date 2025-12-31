{ pkgs }:
let
  ggkeyboard = pkgs.rPackages.buildRPackage {
    name = "ggkeyboard";
    src = pkgs.fetchgit {
      url = "https://github.com/b-rodrigues/ggkeyboard";
      rev = "main";
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
      rev = "main";
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

