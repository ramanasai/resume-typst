# Data-Driven Resume with Typst

 A modern, clean resume template built with [Typst](https://typst.app/), designed to separate content from styling. This project allows you to maintain your resume data in a simple JSON file while generating a professionally styled PDF.

## 🚀 Features

- **Data-Driven**: All resume content is stored in `src/input/data.json`. No need to touch the layout code for content updates.
- **Clean Design**: Minimalist and professional layout using modern fonts (Instrument Sans, Inter).
- **Automated Formatting**: Automatic handling of dates, lists, and layout structure.
- **Icon Support**: Built-in SVG icons for contact details and social links.

## 🛠️ Prerequisites

You need to have **Typst** installed on your system.

- **macOS (Homebrew)**:
  ```bash
  brew install typst
  ```
- **Other OS**: check the [official installation guide](https://github.com/typst/typst#installation).

## 📖 Usage

1.  **Clone the repository**:
    ```bash
    git clone <repository-url>
    cd resume-typst
    ```

2.  **Edit your data**:
    Open `src/input/data.json` and fill in your details.
    
    ```json
    {
      "personal": {
        "name": "Sairamana",
        "title": "Software Engineer",
        ...
      },
      ...
    }
    ```

3.  **Compile the resume**:
    Run the following command to generate the PDF:
    ```bash
    typst compile src/main.typ
    ```
    This will create `src/main.pdf`.

4.  **Watch for changes (Optional)**:
    To automatically recompile whenever you save a file:
    ```bash
    typst watch src/main.typ
    ```

## 📂 Project Structure

```
resume-typst/
├── README.md               # Project documentation
└── src/
    ├── main.typ            # Entry point for compilation
    ├── input/
    │   └── data.json       # Your resume content (EDIT THIS)
    └── template/
        └── resume_temp.typ # Styling and layout logic
```

## 🎨 Customizing the Design

If you want to change the layout, fonts, or colors:
- Navigate to `src/template/resume_temp.typ`.
- You can modify:
    - **Fonts**: `set text(font: ...)`
    - **Colors**: `let accent-color = ...`
    - **Icons**: SVG paths in the variables `icon-mail`, `icon-phone`, etc.
    - **Order**: Re-arrange the function calls at the bottom of the `resume` function.