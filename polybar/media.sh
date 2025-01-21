#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# show media playing status based on playerctl w/ controls
echo $(playerctl metadata -f '{{artist}} - {{title}}' 2>/dev/null | sed -E 's/(.{30}).+/\1.../') %{A1:playerctl previous:}%{A} %{A1:playerctl play-pause:}$(playerctl status 2>/dev/null | grep Playing >/dev/null && echo '' || echo '')%{A} %{A1:playerctl next:}%{A}
