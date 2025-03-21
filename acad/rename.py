



import os

def swap_filename_date(a):
    b= a.split('_')
    c= b[0]
    return f"{b[2][:-4]}_{c[-2:]}{c[0:2]}{c[2:4]}{b[1]}{b[2][-4:]}"



def rename_prn_to_pdf(folder_path):
    # Check if the folder exists
    if not os.path.exists(folder_path):
        print(f"The folder {folder_path} does not exist.")
        return

    # Scan all files in the folder
    for filename in os.listdir(folder_path):
        # Create the full path to the file
        old_file_path = os.path.join(folder_path, filename)

        # Check if it's a file (skip directories)
        if os.path.isfile(old_file_path) and filename.endswith('.prn'):
            # Replace the .prn extension with .pdf
            new_filename = filename[:-4] + '.pdf'  # Remove the last 4 chars (.prn) and add .pdf
            new_filename = swap_filename_date(new_filename)
            new_file_path = os.path.join(folder_path, new_filename)
            
            # Rename the file
            os.rename(old_file_path, new_file_path)
            print(f"Renamed: {filename} -> {new_filename}")


def prn2pdf():
    folder_path = r"C:\Users\f.nikolakopoulos\AppData\Roaming\draw\plot"
    rename_prn_to_pdf(folder_path)


a = "03212025_105944_EF-09.KDSA-3500-STANDARD-LEFT-TOP-SOUND.pdf"

