//---------------------------------------------------------------------------------------------------------
// MyToggles
//---------------------------------------------------------------------------------------------------------
MyToggles : dialog {
  key = "Title";
  label = "";//Title$ from lsp file
  spacer;
  : boxed_column {
    label = "Row of Toggles";
    width = 34.26;
    fixed_width = true;
    : row {
      : toggle {
        key = "Toggle1";
        label = "Toggle 1";
      }
      : toggle {
        key = "Toggle2";
        label = "Toggle 2";
      }
    }
    spacer;
  }
  : boxed_column {
    label = "Column of Toggles";
    width = 34.26;
    fixed_width = true;
    : toggle {
      key = "Toggle3";
      label = "Toggle 3";
    }
    : toggle {
      key = "Toggle4";
      label = "Toggle 4";
    }
    : toggle {
      key = "Toggle5";
      label = "Toggle 5";
    }
    spacer;
  }
  spacer;
  ok_only;
}//MyToggles