# -*- mode: python ; coding: utf-8 -*-

import os
from PyInstaller.utils.hooks import collect_all

block_cipher = None

# Collect wx components
wxwidgets = collect_all('wx')

a = Analysis(
    ['Main.py'],
    pathex=['.'],
    binaries=wxwidgets[1],
    datas=[
        ('NIST_BE.parquet', '.'),  # Bundle the parquet file in the root of the temp directory
    ] + wxwidgets[0],
    hiddenimports=[
        'wx', 'numpy', 'matplotlib', 'pandas', 'pyperclip',
        'matplotlib.backends._backend_agg',
        'matplotlib.backends.backend_wxagg',
        'pyarrow',
        'pyarrow.lib',
        'pyarrow.parquet',
        'fastparquet',  # Alternative parquet engine
    ] + wxwidgets[2],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=['PyQt5', 'PySide2', 'customtkinter', 'tkinter'],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='KherveDB',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=False,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,  # Set to False for windowed app
    disable_windowed_traceback=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='Icons/icon.ico'  # Add this line - path to your icon file
)