from acad import DOC

d=DOC()


output_pdf = "C://Users//filip//AppData//Roaming//draw//plots//0.pdf"


doc = d.doc
# Get the Active Layout (Model or Paper Space)
layout = doc.Layouts.Item("Model")  # Change to a paper space layout if needed


PlotDevice = "PDF.pc3"
Orientation = 'Landscape'

#works if style is autospool
# Use the command-line PLOT method
plot_command = (
    '-PLOT\n' +  # Silent plot mode
    'Y\n' +  # Detailed plot configuration
    'Model\n' +  # Layout (Change to "Layout1" if needed)
    PlotDevice + '\n' + # Plotter name
    'A4\n' +  # Paper size
    '\n' + 
    Orientation + '\n' + # Orientation
    'No\n' +  # Plot upside down?
    'Extents\n' +  # Plot area
    'Fit' + '\n' + 
    'Center\n' +  # center
 
    'Yes\n' +  # Center the plot
    'default.ctb' + '\n' +  # plot style name
    'Yes' + '\n' + # plot with lineweights
    'A' + '\n' + # shade plot
    'Yes' + '\n' +
    'Yes' + '\n'
#    f'"{output_pdf}"\n'   # Output file path
)


#doc.SendCommand(plot_command)

#I am moved ploting handlers to plot.lsp
def plot_window_landscape():
    doc.SendCommand("bpl ")

