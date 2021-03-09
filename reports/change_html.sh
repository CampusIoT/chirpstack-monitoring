#!/bin/bash
replacement="<li><a href='https://lns.campusiot.imag.fr/#/organizations/6/gateways/7276ff0039030716'>7276ff0039030716</a>: KER_FEMTO_030716_P307 - (org 6) - 2021-03-07T19:14:43.804084Z+CHANGED</li>"
id_to_replace="7276ff0039030716"

sed -i '$id_to_replace/c $replacement' test.html
#sed -i 's/^/\t\t/' <filename>