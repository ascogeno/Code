import tkinter as tk

root = tk.Tk()
root.title("Nice feather in the corner here")
root.geometry("400x100")

label = tk.Label(root, text="Hello world!")
label.pack(expand=True)

root.mainloop()