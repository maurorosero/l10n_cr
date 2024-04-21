# -*- coding: utf-8 -*-
import re, validators
from validate_email import validate_email

### VALIDATION FUNCTIONS CLASS
class Validate():
    def __init__(self):
        self.domain=None

    def dns1(self, domain):
        self.domain = domain
        return validators.domain(self.domain)

    def email1(self, email):
        regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,7}\b'
        result = False
        if (re.fullmatch(regex, email)):
            result = True
        return result

    def email2(self, email):
        result = False
        if validate_email(email, verify=True):
            result = True
        return result
