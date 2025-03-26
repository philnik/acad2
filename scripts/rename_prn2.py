
import sys

sys.path.append("c:/Users/f.nikolakopoulos/AppDATA/Roaming/source/acad2/acad/")

from rename import (prn2pdf,
                    clean_plot_folder)

from backup_file import backup_current_document

prn2pdf()
backup_current_document()
clean_plot_folder()
