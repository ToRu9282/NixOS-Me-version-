{
  programs.git = { # https://nixos.wiki/wiki/Git
    enable = true;

    # lfs.enable = true; # https://git-lfs.com/

    userName  = "ToRu9282";
    userEmail = "toru9282@gmail.com";

    # aliases = {
		#   pu = "push";
    #   co = "checkout";
    #   cm = "commit";
    #   s = "status";
    # };
  };

  programs.gitui = { # Terminal UI
    enable = true;
  };
}
