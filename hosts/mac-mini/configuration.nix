{
  config,
  pkgs,
  ...
}: {
  # Mac Mini specific configuration
  system.defaults = {
  };

  # Mac Mini specific packages
  environment.systemPackages = with pkgs; [];
}
