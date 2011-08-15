local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

if T.client == "deDE" then

	L.chat_BATTLEGROUND_GET = "[B]"
	L.chat_BATTLEGROUND_LEADER_GET = "[B]"
	L.chat_BN_WHISPER_GET = "Von"
	L.chat_GUILD_GET = "[G]"
	L.chat_OFFICER_GET = "[O]"
	L.chat_PARTY_GET = "[P]"
	L.chat_PARTY_GUIDE_GET = "[P]"
	L.chat_PARTY_LEADER_GET = "[P]"
	L.chat_RAID_GET = "[R]"
	L.chat_RAID_LEADER_GET = "[R]"
	L.chat_RAID_WARNING_GET = "[W]"
	L.chat_WHISPER_GET = "Von"
	L.chat_FLAG_AFK = "[AFK]"
	L.chat_FLAG_DND = "[DND]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "ist jetzt |cff298F00online|r"
	L.chat_ERR_FRIEND_OFFLINE_S = "ist jetzt |cffff0000offline|r"
	
	L.chat_general = "Allgemein"
	L.chat_trade = "Handel"
	L.chat_defense = "LokaleVerteidigung"
	L.chat_recrutment = "Gildenrekrutierung"
	L.chat_lfg = "SucheNachGruppe"
	
	L.disband = "Gruppe wird aufgelöst."  
 
	L.datatext_download = "Download: "
	L.datatext_bandwidth = "Bandbreite: "
	L.datatext_guild = "Gilde"
	L.datatext_noguild = "Keine Gilde"
	L.datatext_bags = "Tasche: "
	L.datatext_friends = "Freunde"
	L.datatext_online = "Online: "
	L.datatext_armor = "Rüstung"
	L.datatext_earned = "Erhalten:"
	L.datatext_spent = "Ausgegeben:"
	L.datatext_deficit = "Differenz:"
	L.datatext_profit = "Gewinn:"
	L.datatext_timeto = "Zeit bis"
	L.datatext_friendlist = "Freundesliste:"
	L.datatext_playersp = "sp"
	L.datatext_playerap = "ap"
	L.datatext_playerhaste = "haste"
	L.datatext_dps = "dps"
	L.datatext_hps = "hps"
	L.datatext_playerarp = "arp"
	L.datatext_session = "Sitzung: "  
	L.datatext_character = "Charakter: "
	L.datatext_server = "Server: "
	L.datatext_totalgold = "Gesamt: "
	L.datatext_savedraid = "Instanz ID(s)"
	L.datatext_currency = "Währung:"
	L.datatext_fps = " fps & "
	L.datatext_ms = " ms"
	L.datatext_playercrit = " crit"
	L.datatext_playerheal = " heal"
	L.datatext_avoidancebreakdown = "Vermeidungsübersicht" 
	L.datatext_lvl = "lvl"
	L.datatext_boss = "Boss"
	L.datatext_miss = "Verfehlen" 
	L.datatext_dodge = "Ausweichen"  
	L.datatext_block = "Blocken" 
	L.datatext_parry = "Parieren" 
	L.datatext_playeravd = "avd: "
	L.datatext_servertime = "Serverzeit: "
	L.datatext_localtime = "Ortszeit: "
	L.datatext_mitigation = "Schadensverringerung nach Level: " 
	L.datatext_healing = "Heilung : "
	L.datatext_damage = "Schaden : "
	L.datatext_honor = "Ehre : "
	L.datatext_killingblows = "Todesstöße : "
	L.datatext_ttstatsfor = "Stats für "
	L.datatext_ttkillingblows = "Todesstöße:"
	L.datatext_tthonorkills = "Ehrenhafte Siege:"
	L.datatext_ttdeaths = "Tode:"
	L.datatext_tthonorgain = "Ehre erhalten:"
	L.datatext_ttdmgdone = "Schaden verursacht:"
	L.datatext_tthealdone = "Heilung verursacht:"
	L.datatext_basesassaulted = "Basen angegriffen:"
	L.datatext_basesdefended = "Basen verteidigt:"
	L.datatext_towersassaulted = "Türme angegriffen:"
	L.datatext_towersdefended = "Türme verteidigt:"
	L.datatext_flagscaptured = "Flaggen eingenommen:"
	L.datatext_flagsreturned = "Flaggen zurückgebracht:"
	L.datatext_graveyardsassaulted = "Friedhöfe angegriffen:"
	L.datatext_graveyardsdefended = "Friedhöfe verteidigt:"
	L.datatext_demolishersdestroyed = "Verwüster zerstört:"
	L.datatext_gatesdestroyed = "Tore zerstört:"
	L.datatext_totalmemusage = "Gesamte Speichernutzung:"
	L.datatext_control = "Kontrolliert von:"
 
	L.Slots = {
		[1] = {1, "Kopf", 1000},
		[2] = {3, "Schultern", 1000},
		[3] = {5, "Brust", 1000},
		[4] = {6, "Gürtel", 1000},
		[5] = {9, "Handgelenke", 1000},
		[6] = {10, "Hände", 1000},
		[7] = {7, "Beine", 1000},
		[8] = {8, "Füße", 1000},
		[9] = {16, "Waffenhand", 1000},
		[10] = {17, "Schildhand", 1000},
		[11] = {18, "Distanzwaffe", 1000}
	}
 
	L.popup_disableui = "Tukui funktioniert nicht mit deiner Auflösung, möchtest du Tukui ausschalten? (Drücke Abbrechen, falls du eine andere Auflösung testen willst.)"
	L.popup_install = "Dies ist das erste Mal mit Tukui V13 mit diesem Charakter. Du musst dein UI neu laden, um Aktionsleisten, Variabeln und den Chat einzustellen."  
	L.popup_reset = "Warnung! Alles wird auf Tukui Standardwerte zurückgesetzt. Trotzdem fortfahren?"
	L.popup_2raidactive = "2 Raid layouts sind aktiv, bitte eins wählen."
	L.popup_install_yes = "Yeah! (empfohlen!)"
	L.popup_install_no = "Nein, das is echt großer Mist"
	L.popup_reset_yes = "Yeah baby!"
	L.popup_reset_no = "Nein!"
 
	L.merchant_repairnomoney = "Du hast nicht genügend Gold zum Reparieren!" 
	L.merchant_repaircost = "Deine Rüstung wurde repariert für"
	L.merchant_trashsell = "Dein Abfall wurde verkauft und du erhältst"
 
	L.goldabbrev = "|cffffd700g|r"
	L.silverabbrev = "|cffc7c7cfs|r"
	L.copperabbrev = "|cffeda55fk|r"
 
	L.error_noerror = "Kein Fehler bis jetzt."
 
	L.unitframes_ouf_offline = "Offline"
	L.unitframes_ouf_dead = "Tot"
	L.unitframes_ouf_ghost = "Geist"
	L.unitframes_ouf_lowmana = "WENIG MANA"
	L.unitframes_ouf_threattext = "Bedrohung am aktuellen Ziel:"
	L.unitframes_ouf_offlinedps = "Offline"
	L.unitframes_ouf_deaddps = "|cffff0000[TOT]|r"
	L.unitframes_ouf_ghostheal = "GEIST"
	L.unitframes_ouf_deadheal = "TOT"
	L.unitframes_ouf_gohawk = "GO FALKE"
	L.unitframes_ouf_goviper = "GO VIPER"
	L.unitframes_disconnected = "D/C"
	L.unitframes_ouf_wrathspell = "Zorn"
	L.unitframes_ouf_starfirespell = "Sternenfeuer"
 
	L.tooltip_count = "Anzahl"  
 
	L.bags_noslots = "Kann keine weiteren Taschenplätze kaufen!"
	L.bags_costs = "Kosten: %.2f Gold"  
	L.bags_buyslots = "Kaufe neuen Platz mit /bags purchase yes"
	L.bags_openbank = "Du musst erst das Bankfach öffnen."
	L.bags_sort = "Sortiert deine Taschen oder die Bank, falls geöffnet."  
	L.bags_stack = "Stapelt Items neu in deinen Taschen und der Bank, falls geöffnet."  
	L.bags_buybankslot = "Kaufe Bankplatz. (Bank muss geöffnet sein)" 
	L.bags_search = "Suchen"
	L.bags_sortmenu = "Sortieren"
	L.bags_sortspecial = "Sortieren Spezialtasche"  
	L.bags_stackmenu = "Stapeln"
	L.bags_stackspecial = "Stapeln Spezialtasche" 
	L.bags_showbags = "Zeige Taschen"
	L.bags_sortingbags = "Sortieren abgeschlossen."  
	L.bags_nothingsort= "Nichts zu sortieren."
	L.bags_bids = "Benutze Taschen: "
	L.bags_stackend = "Neu stapeln abgeschlossen."  
	L.bags_rightclick_search = "Rechtsklick, um zu suchen."
	
	L.loot_fish = "Fishy loot"
	L.loot_empty = "Empty slot"
 
	L.chat_invalidtarget = "Falsches Ziel"
 
	L.mount_wintergrasp = "Tausendwinter"
 
	L.core_autoinv_enable = "Autoinvite AN: invite"  
	L.core_autoinv_enable_c = "Autoinvite AN: "   
	L.core_autoinv_disable = "Autoinvite AUS"   
	L.core_wf_unlock = "Quest Tracker entriegelt"
	L.core_wf_lock = "Quest Tracker verriegelt" 
	L.core_welcome1 = "Willkommen bei |cffC495DDTukui|r Version " 
	L.core_welcome2 = "Tippe |cff00FFFF/uihelp|r für mehr Informationen"
 
	L.core_uihelp1 = "|cff00ff00General Slash Befehle|r"
	L.core_uihelp2 = "|cffFF0000/moveui|r - UI Elemente entsperren zum Bewegen."
	L.core_uihelp3 = "|cffFF0000/rl|r - UI neu laden."
	L.core_uihelp4 = "|cffFF0000/gm|r - GM Tickets schreiben oder WoW Hilfe anzeigen."
	L.core_uihelp5 = "|cffFF0000/frame|r - Name des Frames unter dem Mauszeiger ausgeben. (für lua coder nützlich)"
	L.core_uihelp6 = "|cffFF0000/heal|r - Heil-Layout aktivieren."
	L.core_uihelp7 = "|cffFF0000/dps|r - Dps/Tank-Layout aktivieren."
	L.core_uihelp8 = "|cffFF0000/bags|r - Taschen sortieren, Bankplätze kaufen oder gegenstände stapeln."
	L.core_uihelp9 = "|cffFF0000/resetui|r - Auf Tukui Standard zurücksetzen."
	L.core_uihelp10 = "|cffFF0000/rd|r - Raid auflösen."
	L.core_uihelp11 = "|cffFF0000/ainv|r - Automatische Gruppeneinladung beim Anflüstern mit Schlüsselwort aktivieren. Du kannst dein eigenes Schlüsselwort mit `/ainv myword` einstellen"
	L.core_uihelp100 = "(Hochscrollen wenn du mehr Befehle sehen willst ...)"
 
	L.symbol_CLEAR = "Entfernen" 
	L.symbol_SKULL = "Totenschädel"
	L.symbol_CROSS = "Kreuz"
	L.symbol_SQUARE = "Quadrat"
	L.symbol_MOON = "Mond"
	L.symbol_TRIANGLE = "Dreieck"
	L.symbol_DIAMOND = "Diamant"
	L.symbol_CIRCLE = "Kreis"
	L.symbol_STAR = "Stern"
 
	L.bind_combat = "Du kannst keine Tasten im Kampf belegen."
	L.bind_saved = "Alle Tastenbelegungen wurden gespeichert."
	L.bind_discard = "Alle gerade neu belegten Tastenbelegungen wurden verworfen."
	L.bind_instruct = "Bewege deine Maus über einen Aktionsbutton, um ihn mit einem Hotkey zu belegen. Drücke Escape oder die rechte Maustaste, um die aktuelle Tastenbelegung des Buttons zu löschen."  
	L.bind_save = "Tastenbelegung speichern"
	L.bind_discardbind = "Tastenbelegung verwerfen"
 
	L.hunter_unhappy = "Dein Begleiter ist unzufrieden!"
	L.hunter_content = "Dein Begleiter ist zufrieden!"
	L.hunter_happy = "Dein Begleiter ist glücklich!"
	
	L.move_tooltip = "Tooltip bewegen"
	L.move_minimap = "Minimap bewegen"
	L.move_watchframe = "Quests bewegen"
	L.move_gmframe = "Ticket bewegen"
	L.move_buffs = "Spieler Stärkungszauber bewegen"
	L.move_debuffs = "Spieler Schwächungszauber bewegen"
	L.move_shapeshift = "Haltungs-/Totemleiste bewegen"
	L.move_achievements = "Erfolgsfenster bewegen"
	L.move_roll = "Würfelfenster bewegen"
	L.move_vehicle = "Fahrzeugausstieg bewegen"
	
	-- tuto/install
	L.install_header_1 = "Willkommen"
    L.install_header_2 = "1. Grundlegendes"
    L.install_header_3 = "2. Einheitenfenster"
    L.install_header_4 = "3. Funktionen"
    L.install_header_5 = "4. Das solltest Du wissen!"
    L.install_header_6 = "5. Kommandos"
    L.install_header_7 = "6. Abgeschlossen"
    L.install_header_8 = "1. Grundeinstellungen"
    L.install_header_9 = "2. Chat"
    L.install_header_10= "3. Frames"
    L.install_header_11= "4. Abschluss!"

    L.install_init_line_1 = "Danke, dass Du Dich für Tukui entschieden hast!"
    L.install_init_line_2 = "Du wirst mit einigen einfachen Schritten durch die Installation geführt. Bei jedem Schritt kannst Du entscheiden, ob Du die Standardeinstellungen übernehmen oder überspringen möchtest."
    L.install_init_line_3 = "Du hast auch die Möglichkeit, eine Einführung in einige der Funktionen von Tukui zu erhalten."
    L.install_init_line_4 = "Klicke auf 'Tutorial' um eine kleine Einleitung zu erhalten, oder klicke auf 'Installation' um diesen Schritt zu überspringen."

    L.tutorial_step_1_line_1 = "Dieses kurze Tutorial wird Dir einige Funktionen von Tukui zeigen."
    L.tutorial_step_1_line_2 = "Zuerst das Wichtigste, das Du wissen solltest, bevor Du mit diesem UI spielst."
    L.tutorial_step_1_line_3 = "Diese Installation ist teilweise charakterbezogen. Während einige Einstellungen, die später angewandt werden, accountweit sind, musst Du die Installation für jeden neuen Charakter starten der Tukui nutzt. Dieses Script wird automatisch beim ersten Einloggen eines Charakters mit Tukui gezeigt. Die Optionen können benutzerfreundlich mit dem Befehl /tukui angepasst werden. Erfahrene Benutzer können die Optionen auch unter /Tukui/config/config.lua anpassen."
    L.tutorial_step_1_line_4 = "Das Bearbeiten der Config.lua benötigt unter anderem Erfahrung in der Programmierung von Lua. Es wird empfohlen, die Konfiguration im Spiel per /tukui zu ändern, sollten diese Kenntnisse nicht vorhanden sein."

    L.tutorial_step_2_line_1 = "Tukui verwendet eine eingebettete Version von oUF, programmiert von Trond (Haste) A Ekseth. Es kümmert sich um alle Einheitenfenster, Buffs und Debuffs und alle klassenspezifischen Elemente."
    L.tutorial_step_2_line_2 = "Du kannst auf wowinterface.com nach oUF suchen, um mehr über dieses Werkzeug zu erfahren."
    L.tutorial_step_2_line_3 = "Falls Du einen Heiler oder Schlachtzugsleiter spielst, möchtest Du vielleicht die Heiler-Einheitenfenster aktivieren. Diese zeigen Dir mehr Informationen über Deinen Schlachtzug an. (/heal) Als DPS-Klasse oder als Tank solltest Du die schlanke Raidansicht auswählen. (/dps) Falls Du keine der beiden Ansichten oder etwas anderes benutzen möchtest, kannst Du im Addon-Manager in der Charakterübersicht diese deaktivieren."
    L.tutorial_step_2_line_4 = "Um die Positionen der Einheitenfenster zu verschieben, tippe einfach /moveui ein."

    L.tutorial_step_3_line_1 = "Tukui ist ein neudesigntes Blizzard Interface. Nicht mehr, nicht weniger. Nahezu alle Funktionen des normalen Interfaces sind auch in Tukui verfügbar. Die einzigen Funktionen, die nicht im Standard-Interface verfügbar sind, sind automatisierte Prozesse, die nicht auf dem Bildschirm sichtbar sind. Zum Beispiel automatisches Verkaufen von grauen Gegenständen beim Händlerbesuch. Oder, ein weiteres Beispiel, automatisches Sortieren der Gegenstände in den Taschen."
    L.tutorial_step_3_line_2 = "Weil nicht jeder Sachen wie DPS-Meter, Boss Mods, Aggro-Meter und ähnliches mag, haben wir uns entschieden, dass dies die beste Möglichkeit ist. Tukui wurde mit der Idee entwickelt, auf alle Klassen, Rollen, Talente, Spielstile, Vorlieben der Benutzer etc. zu passen. Deswegen ist Tukui momentan eines der populärsten Interfaces. Es passt zum Spielstil jedes Einzelnen und ist extrem anpassbar. Es ist auch so entwickelt worden, jedem einen sehr guten Start für sein eigenes Interface zu bieten, ohne dabei auf weitere Addons angewiesen zu sein. Unzählige Spieler nutzen Tukui seit 2009 als Basis für ihre eigenen Interfaces. Wirf doch mal einen Blick auf die angepassten Pakete auf unserer Webseite!"
    L.tutorial_step_3_line_3 = "Für weitere Modifikationen und Funktionen kann die entsprechende Mods-Sektion auf unserer Webseite oder http://www.wowinterface.com besucht werden."
    L.tutorial_step_3_line_4 = ""

    L.tutorial_step_4_line_1 = "Um festzulegen, wie viele Aktionsleisten Du möchtest, bewege Deine Maus an den linken oder rechten Rand der untersten Aktionsleiste. Mache das Gleiche auf der rechten Seite über dem unteren und oberen Rand. Um Text aus dem Chat zu kopieren, klicke den Knopf, der beim Überfahren des Chatfensters mit der Maus in der rechten Ecke auftaucht."
    L.tutorial_step_4_line_2 = "Die Miniaturkarte ändert die Randfarbe. Sie ist Grün, wenn Du neue Post hast. Rot, wenn Du eine neue Kalendereinladung hast, und Orange bei beidem."
    L.tutorial_step_4_line_3 = "Du kannst 80% der Datenfelder linksklicken, um verschiedene Fenster von Blizzard zu öffnen. Die Datenfelder `Freunde` und `Gilde` haben auch eine Funktion bei Rechtsklick."
    L.tutorial_step_4_line_4 = "Hier sind einige Aufklappmenüs verfügbar. Bei Rechtsklick auf [X] (Schliessen) der Tasche wird ein Aufklappmenü erscheinen, um die Taschen anzuzeigen, Gegenstände zu sortieren, den Schlüsselbund anzuzeigen, etc. Ein Klicken mit dem Mausrad auf die Miniaturkarte öffnet das Mikromenü."

    L.tutorial_step_5_line_1 = "Zu guter Letzt beinhaltet Tukui eine Reihe nützlicher Kommandos."
    L.tutorial_step_5_line_2 = "/moveui erlaubt Dir das Bewegen vieler Fenster überall auf dem Bildschirm. /enable und /disable sind nützlich um schnell Addons ein- oder auszuschalten. /rl lädt das Interface neu. /heal aktiviert das Heiler-Raidinterface und /dps aktiviert das Tank/DPS-Raidinterface."
    L.tutorial_step_5_line_3 = "/tt erlaubt es dir, dein Ziel anzuflüstern. /rc startet einen Bereitschaftscheck. /rd löst Deine Gruppe oder Raid auf. /bags zeigt einige Funktionen, die über die Kommandozeile verfügbar sind. /ainv aktiviert automatisches Einladen per anflüstern. (/ainv off) deaktiviert dies wieder."
    L.tutorial_step_5_line_4 = "/gm öffnet das Hilfe-Fenster. /install, /resetui oder /tutorial lädt dieses Installationsprogramm. /frame zeigt den Namen des Fensters unter deinem Mauszeiger und dem des übergeordneten Fensters mit einigen anderen Informationen an."

    L.tutorial_step_6_line_1 = "Die Einführung ist abgeschlossen. Du kannst sie jeder Zeit wieder starten, indem Du /tutorial eingibst."
    L.tutorial_step_6_line_2 = "Ich schlage vor, Du wirfst mal einen Blick auf die Datei Tukui/config/config.lua oder gibst /tukui ein, um das Interface deinen Bedürfnissen anzupassen."
    L.tutorial_step_6_line_3 = "Du kannst nun mit der Installation des Interface fortfahren, wenn diese noch nicht abgeschlossen ist oder Du das Interface auf die Standardeinstellungen zurücksetzen willst."
    L.tutorial_step_6_line_4 = ""

    L.install_step_1_line_1 = "Diese Schritte setzen die richtigen CVar Einstellungen für Tukui."
    L.install_step_1_line_2 = "Der erste Schritt setzt grundlegende Einstellungen."
    L.install_step_1_line_3 = "Dieser Schritt wird jedem Benutzer empfohlen, es sei denn, Du willst nur spezielle Teile der Einstellungen aktivieren."
    L.install_step_1_line_4 = "Klicke 'Weiter', um die Einstellungen anzuwenden, oder klicke 'Überspringen', wenn Du diesen Schritt überspringen möchtest."

    L.install_step_2_line_0 = "Ein weiteres Chataddon wurde gefunden. Wir überspringen diesen Schritt. Bitte drücke 'Überspringen', um mit der Installation fortzufahren."
    L.install_step_2_line_1 = "Der zweite Schritt aktiviert die richtigen Chateinstellungen."
    L.install_step_2_line_2 = "Wenn Du ein neuer Nutzer bist, ist dieser Schritt empfohlen. Wenn Du Tukui bereits benutzt, möchtest Du diesen Schritt vielleicht überspringen."
    L.install_step_2_line_3 = "Es ist normal, dass Deine Schriftgröße während der Aktivierung der Einstellungen etwas zu groß wirkt, dies wird am Ende der Installation wieder zurückgesetzt."
    L.install_step_2_line_4 = "Klicke 'Weiter', um die Einstellungen anzuwenden, oder klicke 'Überspringen', wenn Du diesen Schritt überspringen möchtest."

    L.install_step_3_line_1 = "Der dritte und letzte Schritt übernimmt die standardmässige Position der Frames."
    L.install_step_3_line_2 = "Dieser Schritt ist für jeden neuen Charakter empfohlen ."
    L.install_step_3_line_3 = ""
    L.install_step_3_line_4 = "Klicke 'Weiter', um die Einstellungen anzuwenden, oder klicke 'Überspringen', wenn Du diesen Schritt überspringen möchtest."

    L.install_step_4_line_1 = "Installation abgeschlossen."
    L.install_step_4_line_2 = "Bitte klicke auf 'Abschließen', um das Interface neu zu laden."
    L.install_step_4_line_3 = ""
    L.install_step_4_line_4 = "Viel Spass mit Tukui! Besuche uns auf http://www.tukui.org!"

    L.install_button_tutorial = "Tutorial"
    L.install_button_install = "Installation"
    L.install_button_next = "Weiter"
    L.install_button_skip = "Überspringen"
    L.install_button_continue = "Weiter"
    L.install_button_finish = "Abschließen"
    L.install_button_close = "Schließen" 
end