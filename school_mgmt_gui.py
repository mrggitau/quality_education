import tkinter as tk
from tkinter import messagebox, ttk
from openpyxl import Workbook
import psycopg2
from tkinter import filedialog

# Database connection
def connect_db():
    try:
        return psycopg2.connect(
            dbname="school_db",
            user="postgres",
            password="12345678",
            host="localhost",
            port="5432"
        )
    except Exception as e:
        messagebox.showerror("Connection Error", str(e))
        return None

# ---------- LOGIN ----------
# ---------- LOGIN ----------
def login_window():
    login = tk.Tk()
    
    # Set fullscreen window and configure basic window styles
    login.attributes('-fullscreen', True)  # Set fullscreen
    login.configure(bg="#f9f9f9")  # Set background color
    login.geometry("1200x800")  # Set window size
    login.resizable(True, True)  # Allow resizing

    login.title("Login")
    
    # Add a modern title label with custom font
    title_label = tk.Label(login, text="Welcome Back!", font=("Helvetica", 24, "bold"), fg="#333", bg="#f9f9f9")
    title_label.pack(pady=30)

    # Label and Entry widget styling
    tk.Label(login, text="Username:", font=("Arial", 11), bg="#f9f9f9").pack(pady=10)  # Styled Label
    username_entry = tk.Entry(login, font=("Arial", 12), relief="solid", bd=1, width=30, justify="center")  # Styled Entry
    username_entry.pack(pady=5)

    tk.Label(login, text="Password:", font=("Arial", 12), bg="#f9f9f9").pack(pady=10)  # Styled Label
    password_entry = tk.Entry(login, show="*", font=("Arial", 12), relief="solid", bd=1, width=30, justify="center")  # Styled Entry
    password_entry.pack(pady=5)

    def login_check():
        user = username_entry.get()
        pwd = password_entry.get()
        if user == "admin" and pwd == "password123":
            login.destroy()
            show_main_menu()
        else:
            messagebox.showerror("Login Failed", "Invalid username or password.")

    # Stylish Login button with hover effect
    def on_enter(e):
        login_btn.config(bg="#4CAF50", fg="white")

    def on_leave(e):
        login_btn.config(bg="#fff", fg="#4CAF50")

    login_btn = tk.Button(login, text="Login", font=("Arial", 12, "bold"), command=login_check, width=20, height=2, relief="solid", bd=1)
    login_btn.pack(pady=20)
    login_btn.bind("<Enter>", on_enter)
    login_btn.bind("<Leave>", on_leave)
    
    login.mainloop()

# ---------- MAIN MENU ----------
# ---------- MAIN MENU ----------
def show_main_menu():
    global root
    root = tk.Tk()
    root.attributes('-fullscreen', True) 
    root.title("School Management System")
    root.configure(bg="#f9f9f9")  # Set background color for the window
    root.geometry("600x500")  # Set window size
    root.resizable(False, False)  # Prevent resizing

    # Title Label Styling
    tk.Label(root, text="🎓 School Management System", font=("Arial", 14, "bold"), bg="#f9f9f9", fg="#333").pack(pady=10)

    # Buttons for main menu with enhanced styling (reduced font size)
    btns = [
        ("➕ Add Student", add_student_window),
        ("📋 View Students", view_students_window),
        ("🔍 Search Students", search_students_window),
        ("➕ Add Staff", add_staff_window),
        ("📋 View Staff", view_staff_window),
        ("➕ Add Course", add_course_window),
        ("📚 View Courses", view_courses_window),
        ("🖋 Edit Record", edit_record_window),
        ("❌ Delete Record", delete_record_window),
        ("📊 Export Students", lambda: export_to_excel("students")),
        ("📊 Export Staff", lambda: export_to_excel("staff")),
        ("📊 Export Courses", lambda: export_to_excel("courses")),
        ("❌ Exit", root.quit)
    ]

    # Add styling to each button (reduced size and font)
    for text, cmd in btns:
        tk.Button(
            root, 
            text=text, 
            font=("Arial", 10),  # Smaller font size
            bg="#4CAF50",  # Green background for the buttons
            fg="white",  # White text color
            width=25,  # Slightly smaller width
            height=1,  # Reduced height
            relief="solid",  # Solid border for the button
            bd=2,  # Border width
            command=cmd
        ).pack(pady=8)  # Reduced padding between buttons

    root.mainloop()

# ---------- STUDENT MANAGEMENT ----------

def add_student_window():
    win = tk.Toplevel(root)
    win.title("Add Student")
    labels = ["First Name", "Last Name", "DOB (YYYY-MM-DD)", "Gender", "Contact Info", "Guardian Name", "Guardian Contact", "Enrollment Date (YYYY-MM-DD)"]
    entries = []
    for i, text in enumerate(labels):
        tk.Label(win, text=text).grid(row=i, column=0, padx=10, pady=2)
        entry = tk.Entry(win)
        entry.grid(row=i, column=1, padx=10, pady=2)
        entries.append(entry)

    def submit():
        values = [e.get() for e in entries]
        conn = connect_db()
        if conn:
            try:
                cur = conn.cursor()
                cur.execute("""
                    INSERT INTO student 
                    (first_name, last_name, date_of_birth, gender, student_contact_info, guardian_name, guardian_contact, enrollment_date)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """, tuple(values))
                conn.commit()
                messagebox.showinfo("✅ Success", "Student added successfully!")
                win.destroy()
            except Exception as e:
                conn.rollback()
                messagebox.showerror("❌ Error", str(e))
            finally:
                conn.close()

    tk.Button(win, text="Submit", command=submit).grid(row=len(labels), columnspan=2, pady=10)

def view_students_window():
    win = tk.Toplevel(root)
    win.title("Student List")

    # Initialize Treeview with columns
    tree = ttk.Treeview(win, columns=("ID", "First Name", "Last Name", "DOB", "Gender", "Contact Info", "Guardian Name", "Guardian Contact", "Enrollment Date"), show="headings")
    
    # Style Treeview columns
    tree.heading("#1", text="ID")
    tree.heading("#2", text="First Name")
    tree.heading("#3", text="Last Name")
    tree.heading("#4", text="DOB")
    tree.heading("#5", text="Gender")
    tree.heading("#6", text="Contact Info")
    tree.heading("#7", text="Guardian Name")
    tree.heading("#8", text="Guardian Contact")
    tree.heading("#9", text="Enrollment Date")

    # Set column widths (optional but adds to styling)
    tree.column("#1", width=60)
    tree.column("#2", width=120)
    tree.column("#3", width=120)
    tree.column("#4", width=100)
    tree.column("#5", width=80)
    tree.column("#6", width=150)
    tree.column("#7", width=120)
    tree.column("#8", width=120)
    tree.column("#9", width=120)

    # Add styling for the Treeview widget
    tree.tag_configure("even", background="#f2f2f2")  # Light gray background for even rows
    tree.tag_configure("odd", background="white")    # White background for odd rows

    # Insert sample data (you may add actual data from the database here)
    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.execute("SELECT student_id, first_name, last_name, dob, gender, contact_info, guardian_name, guardian_contact, enrollment_date FROM student")
            rows = cur.fetchall()

            for index, row in enumerate(rows):
                if index % 2 == 0:
                    tree.insert("", tk.END, values=row, tags=("even",))  # Apply "even" tag for even rows
                else:
                    tree.insert("", tk.END, values=row, tags=("odd",))   # Apply "odd" tag for odd rows

        except Exception as e:
            messagebox.showerror("Error", str(e))
        finally:
            conn.close()

    # Pack Treeview widget into the window
    tree.pack(fill=tk.BOTH, expand=True)

    tk.Button(edit_win, text="Update", command=update).grid(row=len(fields), columnspan=2, pady=10)

    def delete_selected():
        selected = tree.focus()
        if not selected:
            messagebox.showwarning("Select", "Please select a record to delete.")
            return
        values = tree.item(selected, 'values')
        student_id = values[0]
        confirm = messagebox.askyesno("Confirm", f"Delete student ID {student_id}?")
        if confirm:
            conn = connect_db()
            if conn:
                try:
                    cur = conn.cursor()
                    cur.execute("DELETE FROM student WHERE student_id = %s", (student_id,))
                    conn.commit()
                    tree.delete(selected)
                    messagebox.showinfo("Deleted", "Student deleted.")
                except Exception as e:
                    conn.rollback()
                    messagebox.showerror("Error", str(e))
                finally:
                    conn.close()

    tk.Button(win, text="✏ Edit Selected", command=edit_selected).pack(pady=5)
    tk.Button(win, text="🗑 Delete Selected", command=delete_selected).pack(pady=5)

def search_students_window():
    win = tk.Toplevel(root)
    win.title("Search Students")
    
    tk.Label(win, text="Search by Name or Gender:").grid(row=0, column=0, padx=10, pady=10)
    search_entry = tk.Entry(win)
    search_entry.grid(row=0, column=1, padx=10, pady=10)

    tree = ttk.Treeview(win, columns=("ID", "Name", "DOB", "Gender"), show="headings")
    for col in tree["columns"]:
        tree.heading(col, text=col)
    tree.grid(row=1, columnspan=2, pady=10, padx=10, sticky="nsew")

    def search():
        query = search_entry.get()
        conn = connect_db()
        if conn:
            try:
                cur = conn.cursor()
                cur.execute("SELECT student_id, first_name || ' ' || last_name, date_of_birth, gender FROM student WHERE first_name ILIKE %s OR gender ILIKE %s", (f"%{query}%", f"%{query}%"))
                for row in cur.fetchall():
                    tree.insert("", tk.END, values=row)
            except Exception as e:
                messagebox.showerror("Error", str(e))
            finally:
                conn.close()

    tk.Button(win, text="Search", command=search).grid(row=0, column=2, padx=10)

# ---------- STAFF MANAGEMENT ----------

def add_staff_window():
    win = tk.Toplevel(root)
    win.title("Add Staff")
    labels = ["First Name", "Last Name", "Position", "Contact Info", "Role"]
    entries = []
    for i, text in enumerate(labels):
        tk.Label(win, text=text).grid(row=i, column=0, padx=10, pady=2)
        entry = tk.Entry(win)
        entry.grid(row=i, column=1, padx=10, pady=2)
        entries.append(entry)

    def submit():
        values = [e.get() for e in entries]
        conn = connect_db()
        if conn:
            try:
                cur = conn.cursor()
                cur.execute("""
                    INSERT INTO staff 
                    (first_name, last_name, position, contact_info, staff_role)
                    VALUES (%s, %s, %s, %s, %s)
                """, tuple(values))
                conn.commit()
                messagebox.showinfo("✅ Success", "Staff member added!")
                win.destroy()
            except Exception as e:
                conn.rollback()
                messagebox.showerror("❌ Error", str(e))
            finally:
                conn.close()

    tk.Button(win, text="Submit", command=submit).grid(row=len(labels), columnspan=2, pady=10)

def view_staff_window():
    win = tk.Toplevel(root)
    win.title("Staff List")
    tree = ttk.Treeview(win, columns=("ID", "Name", "Position", "Role"), show="headings")
    for col in tree["columns"]:
        tree.heading(col, text=col)
    tree.pack(fill=tk.BOTH, expand=True)

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.execute("SELECT staff_id, first_name || ' ' || last_name, position, staff_role FROM staff")
            for row in cur.fetchall():
                tree.insert("", tk.END, values=row)
        except Exception as e:
            messagebox.showerror("Error", str(e))
        finally:
            conn.close()

    def edit_selected():
        selected = tree.focus()
        if not selected:
            messagebox.showwarning("Select", "Please select a record to edit.")
            return
        values = tree.item(selected, 'values')
        staff_id = values[0]

        edit_win = tk.Toplevel(win)
        edit_win.title("Edit Staff")

        labels = ["First Name", "Last Name", "Position", "Contact Info", "Role"]
        entries = []
        for i, label in enumerate(labels):
            tk.Label(edit_win, text=label).grid(row=i, column=0, padx=5, pady=3)
            entry = tk.Entry(edit_win)
            entry.grid(row=i, column=1, padx=5, pady=3)
            entries.append(entry)

        def update():
            data = [e.get() for e in entries]
            conn = connect_db()
            if conn:
                try:
                    cur = conn.cursor()
                    cur.execute("""
                        UPDATE staff SET first_name=%s, last_name=%s, position=%s,
                        contact_info=%s, staff_role=%s WHERE staff_id=%s
                    """, (*data, staff_id))
                    conn.commit()
                    messagebox.showinfo("✅ Updated", "Staff updated successfully.")
                    edit_win.destroy()
                except Exception as e:
                    conn.rollback()
                    messagebox.showerror("Error", str(e))
                finally:
                    conn.close()

        tk.Button(edit_win, text="Update", command=update).grid(row=len(labels), columnspan=2, pady=10)

    def delete_selected():
        selected = tree.focus()
        if not selected:
            messagebox.showwarning("Select", "Please select a record to delete.")
            return
        values = tree.item(selected, 'values')
        staff_id = values[0]
        confirm = messagebox.askyesno("Confirm", f"Delete staff ID {staff_id}?")
        if confirm:
            conn = connect_db()
            if conn:
                try:
                    cur = conn.cursor()
                    cur.execute("DELETE FROM staff WHERE staff_id = %s", (staff_id,))
                    conn.commit()
                    tree.delete(selected)
                    messagebox.showinfo("Deleted", "Staff deleted.")
                except Exception as e:
                    conn.rollback()
                    messagebox.showerror("Error", str(e))
                finally:
                    conn.close()

    tk.Button(win, text="✏ Edit Selected", command=edit_selected).pack(pady=5)
    tk.Button(win, text="🗑 Delete Selected", command=delete_selected).pack(pady=5)

# ---------- COURSE MANAGEMENT ----------

def add_course_window():
    win = tk.Toplevel(root)
    win.title("Add Course")
    tk.Label(win, text="Course Name").grid(row=0, column=0, padx=10, pady=5)
    course_name_entry = tk.Entry(win)
    course_name_entry.grid(row=0, column=1, padx=10, pady=5)

    tk.Label(win, text="Teacher ID (optional)").grid(row=1, column=0, padx=10, pady=5)
    teacher_id_entry = tk.Entry(win)
    teacher_id_entry.grid(row=1, column=1, padx=10, pady=5)

    def submit():
        name = course_name_entry.get()
        teacher_id = teacher_id_entry.get() or None
        conn = connect_db()
        if conn:
            try:
                cur = conn.cursor()
                cur.execute("""
                    INSERT INTO course (course_name, teacher_id)
                    VALUES (%s, %s)
                """, (name, teacher_id))
                conn.commit()
                messagebox.showinfo("✅ Success", "Course added!")
                win.destroy()
            except Exception as e:
                conn.rollback()
                messagebox.showerror("❌ Error", str(e))
            finally:
                conn.close()

    tk.Button(win, text="Submit", command=submit).grid(row=2, columnspan=2, pady=10)

def view_courses_window():
    win = tk.Toplevel(root)
    win.title("Course List")
    tree = ttk.Treeview(win, columns=("ID", "Course", "Teacher ID"), show="headings")
    for col in tree["columns"]:
        tree.heading(col, text=col)
    tree.pack(fill=tk.BOTH, expand=True)

    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            cur.execute("SELECT course_id, course_name, teacher_id FROM course")
            for row in cur.fetchall():
                tree.insert("", tk.END, values=row)
        except Exception as e:
            messagebox.showerror("Error", str(e))
        finally:
            conn.close()

    def edit_selected():
        selected = tree.focus()
        if not selected:
            messagebox.showwarning("Select", "Please select a record to edit.")
            return
        values = tree.item(selected, 'values')
        course_id = values[0]

        edit_win = tk.Toplevel(win)
        edit_win.title("Edit Course")

        tk.Label(edit_win, text="Course Name").grid(row=0, column=0, padx=10, pady=5)
        name_entry = tk.Entry(edit_win)
        name_entry.grid(row=0, column=1, padx=10, pady=5)

        tk.Label(edit_win, text="Teacher ID").grid(row=1, column=0, padx=10, pady=5)
        teacher_entry = tk.Entry(edit_win)
        teacher_entry.grid(row=1, column=1, padx=10, pady=5)

        def update():
            name = name_entry.get()
            teacher = teacher_entry.get() or None
            conn = connect_db()
            if conn:
                try:
                    cur = conn.cursor()
                    cur.execute("UPDATE course SET course_name=%s, teacher_id=%s WHERE course_id=%s", (name, teacher, course_id))
                    conn.commit()
                    messagebox.showinfo("✅ Updated", "Course updated successfully.")
                    edit_win.destroy()
                except Exception as e:
                    conn.rollback()
                    messagebox.showerror("Error", str(e))
                finally:
                    conn.close()

        tk.Button(edit_win, text="Update", command=update).grid(row=2, columnspan=2, pady=10)

    def delete_selected():
        selected = tree.focus()
        if not selected:
            messagebox.showwarning("Select", "Please select a record to delete.")
            return
        values = tree.item(selected, 'values')
        course_id = values[0]
        confirm = messagebox.askyesno("Confirm", f"Delete course ID {course_id}?")
        if confirm:
            conn = connect_db()
            if conn:
                try:
                    cur = conn.cursor()
                    cur.execute("DELETE FROM course WHERE course_id = %s", (course_id,))
                    conn.commit()
                    tree.delete(selected)
                    messagebox.showinfo("Deleted", "Course deleted.")
                except Exception as e:
                    conn.rollback()
                    messagebox.showerror("Error", str(e))
                finally:
                    conn.close()

    tk.Button(win, text="✏ Edit Selected", command=edit_selected).pack(pady=5)
    tk.Button(win, text="🗑 Delete Selected", command=delete_selected).pack(pady=5)

# ---------- EDIT/DELETE RECORDS ----------

def edit_record_window():
    win = tk.Toplevel(root)
    win.title("🖋 Edit Record")
    win.configure(bg="#f9f9f9")

    tk.Label(win, text="Enter Student ID to Edit:", bg="#f9f9f9").grid(row=0, column=0, padx=10, pady=5)
    id_entry = tk.Entry(win)
    id_entry.grid(row=0, column=1, padx=10, pady=5)

    tk.Label(win, text="New Contact Info:", bg="#f9f9f9").grid(row=1, column=0, padx=10, pady=5)
    contact_entry = tk.Entry(win)
    contact_entry.grid(row=1, column=1, padx=10, pady=5)

    def update():
        student_id = id_entry.get()
        new_contact = contact_entry.get()
        conn = connect_db()
        if conn:
            try:
                cur = conn.cursor()
                cur.execute("UPDATE student SET student_contact_info = %s WHERE student_id = %s", (new_contact, student_id))
                conn.commit()
                messagebox.showinfo("✅ Success", "Student record updated successfully!")
                win.destroy()
            except Exception as e:
                conn.rollback()
                messagebox.showerror("❌ Error", str(e))
            finally:
                conn.close()

    tk.Button(win, text="Update", command=update).grid(row=2, columnspan=2, pady=10)

def delete_record_window():
    win = tk.Toplevel(root)
    win.title("❌ Delete Record")
    win.configure(bg="#f9f9f9")

    tk.Label(win, text="Enter Student ID to Delete:", bg="#f9f9f9").grid(row=0, column=0, padx=10, pady=10)
    id_entry = tk.Entry(win)
    id_entry.grid(row=0, column=1, padx=10, pady=10)

    def delete():
        student_id = id_entry.get()
        conn = connect_db()
        if conn:
            try:
                cur = conn.cursor()
                cur.execute("DELETE FROM student WHERE student_id = %s", (student_id,))
                conn.commit()
                messagebox.showinfo("✅ Success", "Student record deleted successfully!")
                win.destroy()
            except Exception as e:
                conn.rollback()
                messagebox.showerror("❌ Error", str(e))
            finally:
                conn.close()

    tk.Button(win, text="Delete", command=delete).grid(row=1, columnspan=2, pady=10)

# ---------- EXPORT TO EXCEL ----------
def export_to_excel(table):
    conn = connect_db()
    if conn:
        try:
            cur = conn.cursor()
            if table == "students":
                cur.execute("SELECT * FROM student")
            elif table == "staff":
                cur.execute("SELECT * FROM staff")
            elif table == "courses":
                cur.execute("SELECT * FROM course")
            rows = cur.fetchall()

            wb = Workbook()
            sheet = wb.active
            sheet.title = table.capitalize()

            if table == "students":
                sheet.append(["ID", "First Name", "Last Name", "DOB", "Gender", "Contact Info", "Guardian Name", "Guardian Contact", "Enrollment Date"])
            elif table == "staff":
                sheet.append(["ID", "First Name", "Last Name", "Position", "Role"])
            elif table == "courses":
                sheet.append(["ID", "Course Name", "Teacher ID"])

            for row in rows:
                sheet.append(row)

            file = filedialog.asksaveasfilename(defaultextension=".xlsx", filetypes=[("Excel files", "*.xlsx")])
            if file:
                wb.save(file)
                messagebox.showinfo("✅ Success", f"{table.capitalize()} data exported successfully!")
        except Exception as e:
            messagebox.showerror("❌ Error", str(e))
        finally:
            conn.close()

# ---------- START ----------

login_window()
