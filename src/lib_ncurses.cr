# Fix for UTF-8 on ubuntu (ncursesw)
{% if flag?(:linux) %}
  @[Link("gpm")]
  @[Link("ncursesw")]
{% else %}
  @[Link("ncurses")]
{% end %}

lib LibNCurses
  type Window = Void*
  alias FileDescriptor = Int32

  ATTR_SHIFT = 8_u32
  $color_pairs = COLOR_PAIRS : Int32
  $colors = COLORS : Int32
  $bstate : UInt64 # button state bits

  struct MEvent
    id : Int16 # ID to distinguish multiple devices
    x : Int32
    y : Int32
    z : Int32 # event coordinates
  end

  enum Attribute
    NORMAL     = 1_u32 - 1_u32
    ATTRIBUTES = 1_u32 << (0_u32 + ATTR_SHIFT)
    CHARTEXT   = (1_u32 << (0_u32 + ATTR_SHIFT)) - 1_u32
    COLOR      = ((1_u32 << 8_u32) - 1_u32) << (0_u32 + ATTR_SHIFT)
    STANDOUT   = 1_u32 << (8_u32 + ATTR_SHIFT)
    UNDERLINE  = 1_u32 << (9_u32 + ATTR_SHIFT)
    REVERSE    = 1_u32 << (10_u32 + ATTR_SHIFT)
    BLINK      = 1_u32 << (11_u32 + ATTR_SHIFT)
    DIM        = 1_u32 << (12_u32 + ATTR_SHIFT)
    BOLD       = 1_u32 << (13_u32 + ATTR_SHIFT)
    ALTCHARSET = 1_u32 << (14_u32 + ATTR_SHIFT)
    INVIS      = 1_u32 << (15_u32 + ATTR_SHIFT)
    PROTECT    = 1_u32 << (16_u32 + ATTR_SHIFT)
    HORIZONTAL = 1_u32 << (17_u32 + ATTR_SHIFT)
    LEFT       = 1_u32 << (18_u32 + ATTR_SHIFT)
    LOW        = 1_u32 << (19_u32 + ATTR_SHIFT)
    RIGHT      = 1_u32 << (20_u32 + ATTR_SHIFT)
    TOP        = 1_u32 << (21_u32 + ATTR_SHIFT)
    VERTICAL   = 1_u32 << (22_u32 + ATTR_SHIFT)
    ITALIC     = 1_u32 << (23_u32 + ATTR_SHIFT)
  end

  enum Key
    DOWN      = 0o402
    UP        = 0o403
    LEFT      = 0o404
    RIGHT     = 0o405
    HOME      = 0o406
    BACKSPACE = 0o407
    F1        = 0o410 + 1
    F2        = 0o410 + 2
    F3        = 0o410 + 3
    F4        = 0o410 + 4
    F5        = 0o410 + 5
    F6        = 0o410 + 6
    F7        = 0o410 + 7
    F8        = 0o410 + 8
    F9        = 0o410 + 9
    F10       = 0o410 + 10
    F11       = 0o410 + 11
    F12       = 0o410 + 12
    ENTER     = 0o527
    KEY_MOUSE = 0o631
  end

  @[Flags]
  enum MouseMask
    BUTTON1_PRESSED        # mouse button 1 down
    BUTTON1_RELEASED       # mouse button 1 up
    BUTTON1_CLICKED        # mouse button 1 clicked
    BUTTON1_DOUBLE_CLICKED # mouse button 1 double clicked
    BUTTON1_TRIPLE_CLICKED # mouse button 1 triple clicked
    BUTTON2_PRESSED        # mouse button 2 down
    BUTTON2_RELEASED       # mouse button 2 up
    BUTTON2_CLICKED        # mouse button 2 clicked
    BUTTON2_DOUBLE_CLICKED # mouse button 2 double clicked
    BUTTON2_TRIPLE_CLICKED # mouse button 2 triple clicked
    BUTTON3_PRESSED        # mouse button 3 down
    BUTTON3_RELEASED       # mouse button 3 up
    BUTTON3_CLICKED        # mouse button 3 clicked
    BUTTON3_DOUBLE_CLICKED # mouse button 3 double clicked
    BUTTON3_TRIPLE_CLICKED # mouse button 3 triple clicked
    BUTTON4_PRESSED        # mouse button 4 down
    BUTTON4_RELEASED       # mouse button 4 up
    BUTTON4_CLICKED        # mouse button 4 clicked
    BUTTON4_DOUBLE_CLICKED # mouse button 4 double clicked
    BUTTON4_TRIPLE_CLICKED # mouse button 4 triple clicked
    BUTTON_SHIFT           # shift was down during button state change
    BUTTON_CTRL            # control was down during button state change
    BUTTON_ALT             # alt was down during button state change
    ALL_MOUSE_EVENTS       # report all button state changes
    REPORT_MOUSE_POSITION  #
  end

  fun initscr : Window
  fun endwin
  fun raw
  fun noecho
  fun wtimeout(window : Window, timeout : Int32)
  fun wprintw(window : Window, format : UInt8*, ...)
  fun wgetch(window : Window) : Int32
  fun mvwprintw(window : Window, row : Int32, col : Int32, format : UInt8*, ...)
  fun wrefresh(window : Window)
  fun keypad(window : Window, value : Bool)
  fun wattr_on(window : Window, attribute : Attribute, unused : Void*)
  fun wattr_off(window : Window, attribute : Attribute, unused : Void*)
  fun getbegy(window : Window) : Int32
  fun getbegx(window : Window) : Int32
  fun getmaxy(window : Window) : Int32
  fun getmaxx(window : Window) : Int32
  fun notimeout(window : Window, value : Bool)
  fun wmove(window : Window, row : Int32, col : Int32) : Int32
  fun nodelay(window : Window, value : Bool)
  fun wclear(window : Window)
  fun newwin(height : Int32, width : Int32, row : Int32, col : Int32) : Window
  fun start_color : Int32
  fun has_colors : Bool
  fun can_change_color : Bool
  fun init_color(slot : Int16, red : Int16, green : Int16, blue : Int16) : Int32
  fun init_pair(slot : Int16, foreground : Int16, background : Int16) : Int32
  fun wcolor_set(window : Window, slot : Int16, unused : Void*) : Int32
  fun cbreak : Int32
  fun nocbreak : Int32
  fun curs_set(visibility : Int32) : Int32
  fun move(x : Int32, y : Int32) : Int32
  fun addstr(str : LibC::Char*) : Int32
  fun addch(chr : LibC::Char)
  fun refresh
  fun clear
  fun box(window : Window, x : Int32, y : Int32) : Int32
  fun wborder(window : Window, ls : Int32, rs : Int32, ts : Int32, bs : Int32, tl : Int32, tr : Int32, bl : Int32, br : Int32) : Int32
  fun mousemask(newmask : UInt64, oldmask : UInt64*) : UInt64
end
