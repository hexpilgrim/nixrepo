# pkgs/cursor/default.nix
{ pkgs ? import <nixpkgs> {} }:

# Cursor is distributed as an AppImage (Type 2 wrapped here)
# This does not sandbox or unpack the app—just makes it executable
# AppImages rely on host libraries present in the runtime environment
pkgs.appimageTools.wrapType2 {
  pname = "cursor";
  version = "1.5.10";
  name = "cursor";

  # Fetch AppImage from official Cursor CDN
  src = pkgs.fetchurl {
    url = "https://downloads.cursor.com/production/7ad52fff14641ec6373a31c19463856cace32640/linux/x64/Cursor-1.5.10-x86_64.AppImage";
    sha256 = "0c3ac691b0b8bcf1fc50c0184bd5e09b13c1480db0cef3c151dae9e6f500af58";
  };

  # Metadata for package introspection and indexing
  meta = with pkgs.lib; {
    description = "Cursor AI-powered code editor";
    homepage = "https://www.cursor.so/";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
