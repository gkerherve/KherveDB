# -*- mode: python ; coding: utf-8 -*-
# KherveDB one-folder (onedir) build spec - produces dist/KherveDB_4.0/
# Packaging convention matches KherveFitting (folder + zip + NSIS installer).

import os
from PyInstaller.utils.hooks import collect_all

block_cipher = None

APP_NAME = "KherveDB_4.0"

# Collect wx components
wxwidgets = collect_all('wx')

a = Analysis(
    ['Main.py'],
    pathex=['.'],
    binaries=wxwidgets[1],
    datas=[
        ('NIST_BE.parquet', '.'),
        ('Icons', 'Icons'),
    ] + wxwidgets[0],
    hiddenimports=[
        'wx', 'numpy', 'matplotlib', 'pandas', 'pyperclip', 'scipy',
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
    excludes=['PyQt5', 'PySide2', 'PyQt6', 'PySide6', 'customtkinter', 'tkinter'],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name=APP_NAME,
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=False,
    console=False,  # windowed app
    disable_windowed_traceback=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='Icons/Icon.ico',
)

coll = COLLECT(
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    strip=False,
    upx=False,
    upx_exclude=[],
    name=APP_NAME,
)
