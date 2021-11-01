import time
import re

class headArea:
    def __init__(self,Start="/*",End="*/",pre="*"):
        self.Counts=70
        self.start=Start
        self.end=End
        self.pre=pre
        self.line=1
        self.result = Start
        self.result +=self.pre*(self.Counts-len(self.result))+"\n"

    def addLine(self,s):
        if len(s)>self.Counts:
            raise Exception("headArea","input line is too large")
        self.line += 1
        count = self.Counts*self.line+self.line-1
        self.result+=s
        self.result+=" "*(count-len(self.result)-1)+self.pre+"\n"

    def endline(self):
        self.result+=" "
        self.result+=self.pre*(self.Counts-1)+"/"
        return self.result

def chead1(snip,Start="/*",End="*/",pre="*"):
    now = time.localtime()
    info={}
    years = time.strftime("%Y",now)
    head = headArea(Start,End,pre)
    Copyright=" * @Copyright (C) "+years+" Zongyang All rights reserved."
    head.addLine(Copyright)
    head.addLine(" *")
    info["Author"]="Zongyang"
    data = time.strftime("%Y-%m-%d %H:%M",now)
    info["Date"]=data
    info["File"]=snip.fn
    for k,v in info.items():
        string=" * @"+k+": "+v
        head.addLine(string)
    head.addLine(" *")
    filename = snip.fn
    result=head.endline()
    if re.match(".*\.h",filename) !=None:
        result+="\n\n"
        filename = filename.replace('.h','_h')
        result+="#ifndef "+filename.upper()
        result+="\n#define "+filename.upper()
        result+="\n"
    return result

