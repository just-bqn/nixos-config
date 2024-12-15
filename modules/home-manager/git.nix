{globals, ...}: {
  programs.git = {
    enable = true;
    userEmail = "self.bqnguyen@gmail.com";
    userName = "just-bqn";
  };
  services.git-sync = {
    enable = true;
    repositories.notes = {
      interval = 5;
      path = globals.notesDirectory;
      uri = "git@github.com:just-bqn/notes";
    };
  };
}
