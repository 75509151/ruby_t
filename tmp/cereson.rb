require "fileutils"
require 'cli/ui'

$func_dic = Hash["编辑ckc" => "tailckc",
			     "查看ckc" => "vickc",
                "查看robo" => 'tailrobo',
                "编辑robo" => 'virobo',
                "查看reap" => 'tailreap',
                "编辑reap" => 'vireap',
                "启动ckc" => 'start_ckc',
                "停止ckc" => 'stop_ckc',
                "查看cka" => 'tailcka',
                "编辑cka" => 'vicka',
                "查看ckc数据库" => 'sqlckc',
                "查看robocv数据库" => 'sqlrobo',
                "查看sync数据" => 'sqlsync']

def add_option(handler)
    $func_dic.keys().each{
        |key| handler.option(key) {|selection| $func_dic.send($func_dic[key], selection)}
    }
end

def taillog(log)
    system("tail -f %s" % log)
end

def vilog(log)
    system("vim -R %s" % log)
end

def vickc(selection)
    vilog("~/var/log/ckc.log")
    cereson()
end

def tailckc(selection)
    taillog("~/var/log/ckc.log")
    cereson()
end

def virobo(selection)
    vilog("~/var/log/robo.log")
    cereson()
end

def tailrobo(selection)
    taillog("~/var/log/robo.log")
    cereson()
end

def vireap(selection)
    vilog("~/var/log/reap.log")
    cereson()
end

def tailreap(selection)
    taillog("~/var/log/reap.log")
    cereson()
end

def vicka(selection)
    vilog("~/var/log/cka.log")
    cereson()
end

def tailcka(selection)
    taillog("~/var/log/cka.log")
    cereson()
end


def sqlckc(selection)
    system("sqlite3 ~/var/data/db/ckc.db")
end

def sqlsync(selection)
    system("sqlite3 ~/var/data/db/sync.db")
end


def sqlrobocv(selection)
    system("sqlite3 ~/var/data/db/robocv.db")
end

def start_ckc(selection)
    system('/home/mm/kiosk/sbin/cron/ckc start')
end

def stop_ckc(selection)
    system('/home/mm/kiosk/sbin/cron/ckc stop')
end

def cereson
	begin
		CLI::UI::Prompt.ask('CERESON') {|handler|
            add_option(handler)
	}
	rescue Interrupt
		puts "exit"
	end
end

cereson()
