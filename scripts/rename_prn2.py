
import sys

sys.path.append("c:/Users/f.nikolakopoulos/AppDATA/Roaming/source/acad2/acad/")

from rename import (prn2pdf,
                    clean_plot_folder)

from backup_file import backup_current_document


def fetch_args():
    res = []
    for i in range(1,5):
        try:
            fl = float(sys.argv[i])
            res.append(fl)
            print(f"""fl[{i}]={fl}""")
        except ValueError:
            print("Error: No more floats")
    return res



prn2pdf()
backup_current_document()
clean_plot_folder()
