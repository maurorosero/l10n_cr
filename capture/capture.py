# -*- coding: utf-8 -*-
import os, json, yaml
from yaml.loader import SafeLoader
from whiptail import Whiptail
from capture.validate import Validate

M_ERROR="ERROR!"
M_WARNING="ADVERTENCIA"
M_INFO="INFORMACIÓN"

class Capture():

    def __init__(self):
        self.mtitle=None
        self.btitle=None
        self.prompt_file=None
        self.cfg_file=None
        self.prompts=[]
        self.fingerprints=None

    def set_mtitle(self, title):
        self.mtitle = title

    def set_btitle(self, title):
        self.btitle = title

    def set_title(self, mtitle, btitle):
        set_mtitle(self, mtitle)
        set_btitle(self, btitle)

    def build_window(self):
        return Whiptail(title=self.mtitle, backtitle=self.btitle)

    def read_prompts(self, p_file=None):
        if p_file == None:
            p_file = self.prompt_file
        with open(p_file, 'r') as f:
            try:
                json_data = f.read()
                prompts=json.loads(json_data)
                self.prompts = prompts
                return prompts, None
            except ValueError as e:
                return None, str(e)

    def read_devinfo(self, p_file=None):
        if p_file == None:
            p_file = self.cfg__file
        with open(p_file) as f:
            try:
                devdata = yaml.load(f, Loader=SafeLoader)
                return devdata, None
            except ValueError as e:
                return None, str(e)

    def ask_prompts(self, widget, prompt=[]):
        prompt_result = [100, None]
        if len(prompt) >= 2:
            mesg=prompt[2] + "\n" + prompt[3]
            match prompt[1]:
                case "inputbox":
                    prompt_result = widget.inputbox(mesg)
                case "passwordbox":
                    prompt_result = widget.inputbox(mesg, password=True)
                case "radiolist":
                    prompt_result = widget.radiolist(mesg, prompt[4])
                case _:
                    prompt_result = [253, None]
        return prompt_result

    def go_capture(self, widget, prompts=[]):
        result={}
        count=0
        exit=0
        if prompts == [] or prompts == None:
            prompts = self.prompts
        while count <= len(prompts) - 1:
            p=prompts[count]
            result[p[0]] = self.ask_prompts(widget, p)
            # End to ESC Key or Error
            if result[p[0]][1] == 255:
                exit=1
                break
            # End when cancel button and first prompt
            if result[p[0]][1] == 1 and count < 1:
                exit=1
                break
            # Back to previous prompt when cancel button
            if result[p[0]][1] == 1:
                count = count - 1 - p[6]
                continue
            # Don't accept null value, stay in this prompt
            if result[p[0]][0] == "":
                continue
            # CONFIRM:
            if f"confirm" in p[5]:
                temporal = p[2]
                p[2] = "Confirmar: " + p[2]
                ck = self.ask_prompts(widget, p)
                p[2] = temporal
                if result[p[0]][0] != ck[0]:
                    widget.msgbox(M_ERROR + f" - " + p[3] + f":\n" + p[4][0])
                    continue
            else:
            # VALIDATE:
                for v in p[5]:
                    params = []
                    validator = Validate()
                    if not hasattr(validator, v):
                        widget.msgbox(M_WARNING + f" - " + p[3] + f":\n" + v + ": Validación no existe!")
                        continue
                    # Se obtiene el método del objeto
                    ck_validate = getattr(validator, v)
                    params.append(result[p[0]][0])
                    if not ck_validate(*params):
                        widget.msgbox(M_ERROR + f" - " + p[3] + f":\n" + p[4][0])
                        count = count - 1
                        break
            count = count + 1 + p[7]
        return exit, result

    def get_fingerprints(self, widget):
        fingerprint = ["sops_fingerprint", "inputbox", "Fingerprint (GPG)", "Indique la huella gpg de encriptación para el instalador", [], [], 0, 0]
        exit = False
        fp_result = [100, None]
        while not exit:
            fp_result = self.ask_prompts(widget, fingerprint)
            if fp_result[1] == 1:
                exit = True
                continue
            if fp_result[0] != "":
                exit = True
        self.fingerprints = fp_result
        return fp_result
