# KherveDB Library - XPS Database Application

A comprehensive X-ray Photoelectron Spectroscopy (XPS) binding energy database application that provides access to the NIST XPS database archived in 2019.

![Application Screenshot](screenshot.png) <!-- You can add a screenshot later -->

## Overview

The KherveDB Library is a desktop application that preserves and provides easy access to the NIST X-ray Photoelectron Spectroscopy binding energy database. This database was recorded in 2019 before it was shut down during the Trump administration and serves as an invaluable resource for scientists and researchers in materials science, chemistry, and physics fields.

## Features

### 🧪 Interactive Periodic Table
- Color-coded periodic table with element categories
- Click to select elements and view XPS data
- Displays atomic numbers, binding energies, and core levels
- Visual feedback for available/unavailable elements

### 📊 Comprehensive Data Access
- Complete NIST XPS binding energy database
- Searchable by element, XPS line, formula, and compound name
- Sortable results table with detailed information
- Statistical analysis of binding energy distributions

### 📈 Data Visualization
- Histogram plots of binding energy distributions
- Adjustable resolution for detailed analysis
- Statistical overlays and data summaries
- Export capabilities for further analysis

### 🔍 Advanced Search & Filtering
- Element-specific searches
- XPS line filtering (1s, 2p3/2, 3d5/2, etc.)
- Chemical formula pattern matching
- Compound name search functionality

### 📚 Integrated Resources
- **XPS Fitting Database**: Direct access to M. Biesinger's XPS fitting resources
- **Thermo Fisher Knowledge Base**: Embedded web browser for element-specific information
- **Literature References**: Direct links to original research papers
- **Google Scholar Integration**: One-click literature searches

### 💾 Data Management
- Copy references to clipboard
- Export data in multiple formats
- Right-click context menus for quick actions
- Persistent user preferences

## Installation

### Requirements
- Python 3.7 or higher
- Windows, macOS, or Linux

### Dependencies
wxPython>=4.1.0
pandas>=1.3.0
matplotlib>=3.3.0
numpy>=1.20.0
pyperclip>=1.8.0


### Install from Source
1. Clone the repository:
```bash
git clone https://github.com/gkerherve/KherveDB.git
cd KherveDB
```
2. Install dependencies:
```bash
pip install -r requirements.txt