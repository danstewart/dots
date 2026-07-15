# uv pip install flask-shell-ipython

# Enable auto reload
# ~/.ipython/profile_default/ipython_config.py
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = ['%autoreload 2']
