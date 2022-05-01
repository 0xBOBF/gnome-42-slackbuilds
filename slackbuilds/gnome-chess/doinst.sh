if [ -x /usr/bin/update-desktop-database ]; then
  /usr/bin/update-desktop-database -q usr/share/applications >/dev/null 2>&1
fi

if [ -e usr/share/icons/hicolor/icon-theme.cache ]; then
  if [ -x /usr/bin/gtk-update-icon-cache ]; then
    /usr/bin/gtk-update-icon-cache usr/share/icons/hicolor >/dev/null 2>&1
  fi
fi
if [ -e usr/share/glib-2.0/schemas ]; then
  if [ -x /usr/bin/glib-compile-schemas ]; then
    /usr/bin/glib-compile-schemas usr/share/glib-2.0/schemas >/dev/null 2>&1
  fi
fi

( cd usr/share/help/ca/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/ca/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/ca/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/ca/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/cs/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/cs/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/cs/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/cs/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/da/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/da/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/da/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/da/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/de/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/de/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/de/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/de/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/es/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/es/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/es/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/es/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/eu/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/eu/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/eu/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/eu/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/fr/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/fr/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/fr/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/fr/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/ko/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/ko/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/ko/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/ko/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/pl/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/pl/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/pl/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/pl/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/pt_BR/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/pt_BR/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/pt_BR/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/pt_BR/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/ru/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/ru/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/ru/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/ru/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/sv/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/sv/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/sv/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/sv/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )
( cd usr/share/help/uk/gnome-chess/figures ; rm -rf gnome-chess-40.png )
( cd usr/share/help/uk/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/gnome-chess-40.png gnome-chess-40.png )
( cd usr/share/help/uk/gnome-chess/figures ; rm -rf org.gnome.Chess.svg )
( cd usr/share/help/uk/gnome-chess/figures ; ln -sf ../../../C/gnome-chess/figures/org.gnome.Chess.svg org.gnome.Chess.svg )

