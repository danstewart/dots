# Fix keybinds (swap ctrl-backspace and alt-backspace)
# ~/.ipython/profile_default/startup/50-keybindings.py
import re
from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.filters import HasFocus, EmacsInsertMode, ViInsertMode

WORD = re.compile(r"[^\s._]+")

def _kill_word(event):
    buf = event.current_buffer
    pos = buf.document.find_start_of_previous_word(pattern=WORD)
    count = buf.document.cursor_position if pos is None else -pos
    if count:
        buf.delete_before_cursor(count=count)

ip = get_ipython()
ip.confirm_exit = False

if getattr(ip, "pt_app", None):
    kb = ip.pt_app.key_bindings
    active = HasFocus(DEFAULT_BUFFER) & (EmacsInsertMode() | ViInsertMode())
    kb.add("escape", "c-h", filter=active)(_kill_word)  # Alt-Backspace
    kb.add("c-w", filter=active)(_kill_word)            # Ctrl-W
