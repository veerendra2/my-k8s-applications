#!/usr/bin/python
import sys
import logging
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0,"/usr/local/apache2/htdocs/myapp")

from flask_app import app as application
