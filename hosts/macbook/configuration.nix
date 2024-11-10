{
  config,
  pkgs,
  ...
}: {
  # MacBook-specific configuration
  system.defaults = {
  };

  # MacBook-specific packages
  environment.systemPackages = with pkgs; [
  ];
}
