import os



import os
import shutil
import re
from datetime import datetime
from collections import defaultdict


def swap_filename_date(a):
    b= a.split('_')
    c= b[0]
    return f"{b[2][:-4]}_{c[-2:]}{c[0:2]}{c[2:4]}{b[1]}{b[2][-4:]}"
Ω

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


#a = "03212025_105944_EF-09.KDSA-3500-STANDARD-LEFT-TOP-SOUND.pdf"




def move_old_files_to_folder(source_dir, target_dir, file_pattern):
    # Ensure the target directory exists
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)

    # Get all files matching the pattern
    files = [f for f in os.listdir(source_dir) if re.match(file_pattern, f)]
    
    # If no files found, exit
    if not files:
        print("No files found matching the pattern.")
        return
    
    # Group files by title (before the date part)
    grouped_files = defaultdict(list)
    for file in files:
        print(file)
        match = re.match(r'(.*)_(\d{12})\.pdf', file)

        if match:
            title, date_str = match.groups()
            date = datetime.strptime(date_str, '%y%m%d%H%M%S')
            print
            grouped_files[title].append((file, date))
    
    # Process each group (title)
    for title, file_list in grouped_files.items():
        print(title)
        # Sort the files in this group by date (descending order)
        file_list.sort(key=lambda x: x[1], reverse=True)
        
        # Keep the latest file and move the rest to the target directory
        latest_file = file_list[0][0]
        for file, _ in file_list[1:]:
            source_file = os.path.join(source_dir, file)
            target_file = os.path.join(target_dir, file)
            shutil.move(source_file, target_file)  # Move the file

        print(f"Files for title '{title}' moved. Latest file kept: {latest_file}")

def clean_plot_folder():
    source_dir = 'C:/Users/f.nikolakopoulos/AppData/Roaming/draw/plot/'
    target_dir = 'C:/Users/f.nikolakopoulos/AppData/Roaming/draw/plot/sorted/'
    file_pattern = r'.*_\d{12}\.pdf'  # Regex pattern for filenames like 
    move_old_files_to_folder(source_dir, target_dir, file_pattern)


