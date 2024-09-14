
gear2d : dialog {
  label = "2D Gear";
  : row {
      : column {
               spacer;
        : row {
          fixed_height = true;
          : toggle {
            key = "prec";
            label = "&Precicion";
                   }
          : popup_list {
            height = 3;    
            label = "&Pitch";
            key = "pitch_pop";
            width = 16;
                       }
              }
  : row {
          alignment = right;
          fixed_width = true;
          : edit_box {
            edit_width = 3;
            key = "teeth";
            label = "&Teeth:";
          }
          : button {
            key = "teeth_minus";
            label = "-";
          }
          : button {
            key = "teeth_plus";
            label = "+";
          }
        }
      }
      : boxed_radio_column {
        fixed_height = true;
        key = "pang";
        label = "&Pressure angle";
        : radio_button {
          key = "14.5";
          label = "14.5 deg";
        }
        : radio_button {
          key = "20";
          label = "20 deg";
        }
        : radio_button {
          key = "25";
          label = "25 deg";
        }
      }
    }
  spacer;
  ok_cancel_help_cadalog_errtile;
}

cadalog_button : retirement_button {
  key = "cadalog";
  label = "&CADalog.com...";
}

ok_cancel_help_cadalog : column {
  : row {
    fixed_width = true;
    alignment = centered;
    ok_button;
    : spacer {
      width = 2;
    }
    cancel_button;
    : spacer {
      width = 2;
    }
    help_button;
    : spacer {
      width = 2;
    }
    cadalog_button;
  }
}

ok_cancel_help_cadalog_errtile : column {
  ok_cancel_help_cadalog;
  errtile;
}
