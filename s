[38;2;131;148;150m───────┬─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────[0m
       [38;2;131;148;150m│ [0mFile: [1m/nix/store/9wdi7655m7p8rm6iprrsrvh1diwlfcbq-ghidra-11.3.2/lib/ghidra/support/launch.properties[0m
[38;2;131;148;150m───────┼─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────[0m
[38;2;131;148;150m   1[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Force Ghidra's Java home instead of trying to figure it out automatically.[0m
[38;2;131;148;150m   2[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m If the provided path does not point to a supported Java home that Ghidra[0m
[38;2;131;148;150m   3[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m supports, this property is ignored.[0m
[38;2;131;148;150m   4[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m NOTE: Ghidra requires a JDK to launch.[0m
[38;2;131;148;150m   5[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mJAVA_HOME_OVERRIDE[0m[38;2;248;248;242m=[0m
[38;2;131;148;150m   6[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m   7[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Required Ghidra class loader[0m
[38;2;131;148;150m   8[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Djava.system.class.loader=ghidra.GhidraClassLoader[0m
[38;2;131;148;150m   9[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  10[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Set default encoding to UTF8[0m
[38;2;131;148;150m  11[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dfile.encoding=UTF8[0m
[38;2;131;148;150m  12[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  13[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Set locale (only en_US is supported)[0m
[38;2;131;148;150m  14[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Duser.country=US[0m
[38;2;131;148;150m  15[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Duser.language=en[0m
[38;2;131;148;150m  16[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Duser.variant=[0m
[38;2;131;148;150m  17[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  18[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m The following options affect rendering on different platforms.  It may be necessary to play[0m
[38;2;131;148;150m  19[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m with these settings to get Ghidra to display and perform optimally on HiDPI monitors or in VM's.[0m
[38;2;131;148;150m  20[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dsun.java2d.opengl=false[0m
[38;2;131;148;150m  21[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS_LINUX[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dsun.java2d.pmoffscreen=false[0m
[38;2;131;148;150m  22[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS_LINUX[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dsun.java2d.xrender=true[0m
[38;2;131;148;150m  23[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS_LINUX[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dsun.java2d.uiScale=1[0m
[38;2;131;148;150m  24[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS_LINUX[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dawt.useSystemAAFontSettings=on[0m
[38;2;131;148;150m  25[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS_WINDOWS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dsun.java2d.d3d=false[0m
[38;2;131;148;150m  26[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  27[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m The Ghidra application establishes the default SSLContext for all[0m
[38;2;131;148;150m  28[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m secure client connections based upon Java's default TLS protocol enablement.  [0m
[38;2;131;148;150m  29[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Setting this property will restrict the enabled TLS protocol versions for [0m
[38;2;131;148;150m  30[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m all secure network connections.  Specifying multiple protocols must be[0m
[38;2;131;148;150m  31[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m comma-separated (e.g., TLSv1.2,TLSv1.3).  See https://java.com/en/configure_crypto.html [0m
[38;2;131;148;150m  32[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m for details on configuring Java's cryptographic algorithms.[0m
[38;2;131;148;150m  33[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Djdk.tls.client.protocols=TLSv1.2,TLSv1.3[0m
[38;2;131;148;150m  34[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  35[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Force PKI server authentication of all HTTPS and Ghidra Server connections by[0m
[38;2;131;148;150m  36[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m specifying path to installed CA certificates file.[0m
[38;2;131;148;150m  37[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m VMARGS=-Dghidra.cacerts=[0m
[38;2;131;148;150m  38[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  39[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Enable verbose logging for network SSL/TLS negotiations.[0m
[38;2;131;148;150m  40[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m This can be very useful when troubleshooting SSLHandshakeException failures which can [0m
[38;2;131;148;150m  41[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m manifest with very cryptic messages.  All Ghidra Server communications rely on secure[0m
[38;2;131;148;150m  42[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m SSL/TLS connections.  This VMARG should only be uncommented while actively troubleshooting[0m
[38;2;131;148;150m  43[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m since it will log a significant amount of data.[0m
[38;2;131;148;150m  44[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m
[38;2;131;148;150m  45[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m See the "Troubleshoting JSSE" section of the following internet hosted document:[0m
[38;2;131;148;150m  46[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m   https://docs.oracle.com/en/java/javase/17/security/java-secure-socket-extension-jsse-reference-guide.html[0m
[38;2;131;148;150m  47[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m  [0m
[38;2;131;148;150m  48[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Djavax.net.debug=ssl[0m
[38;2;131;148;150m  49[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  50[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m The following property will limit the number of processor cores that Ghidra[0m
[38;2;131;148;150m  51[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m will use for thread pools. If not specified, it will use the default number [0m
[38;2;131;148;150m  52[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m of processors returned from Runtime.getRuntime().getAvailableProcessors(). [0m
[38;2;131;148;150m  53[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Otherwise, it will use the min of the value returned from Runtime and the [0m
[38;2;131;148;150m  54[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m value specified by the following property.[0m
[38;2;131;148;150m  55[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dcpu.core.limit=[0m
[38;2;131;148;150m  56[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  57[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m The following property is a way to exactly specify the number of processor [0m
[38;2;131;148;150m  58[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m cores that Ghidra will use for thread pools.  Note: this will supersede the [0m
[38;2;131;148;150m  59[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m above 'cpu.core.limit' value if it is set.[0m
[38;2;131;148;150m  60[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dcpu.core.override=[0m
[38;2;131;148;150m  61[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  62[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Default font size for many java swing elements.[0m
[38;2;131;148;150m  63[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dfont.size.override=[0m
[38;2;131;148;150m  64[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  65[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Set Jython console encoding (prevents a console error)[0m
[38;2;131;148;150m  66[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dpython.console.encoding=UTF-8[0m
[38;2;131;148;150m  67[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  68[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Eclipse on macOS can have file locking issues if the user home directory is networked.  Therefore,[0m
[38;2;131;148;150m  69[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m we will disable file locking by default for macOS. Comment the following line out if Eclipse file [0m
[38;2;131;148;150m  70[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m locking is needed and known to work.[0m
[38;2;131;148;150m  71[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS_MACOS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Declipse.filelock.disable=true[0m
[38;2;131;148;150m  72[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  73[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Where the menu bar is displayed on macOS[0m
[38;2;131;148;150m  74[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS_MACOS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dapple.laf.useScreenMenuBar=false[0m
[38;2;131;148;150m  75[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  76[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Make the title bar adaptable to macOS theme[0m
[38;2;131;148;150m  77[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS_MACOS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dapple.awt.application.appearance=system[0m
[38;2;131;148;150m  78[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  79[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Prevent log4j from using the Jansi DLL on Windows.[0m
[38;2;131;148;150m  80[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS_WINDOWS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Dlog4j.skipJansi=true[0m
[38;2;131;148;150m  81[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  82[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Custom class loader usage forces class data sharing to be disabled which produces a warning.  [0m
[38;2;131;148;150m  83[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Ghidra does not use class data sharing, so explicitly turn it off to avoid the warning.[0m
[38;2;131;148;150m  84[0m   [38;2;131;148;150m│[0m [38;2;166;226;46mVMARGS[0m[38;2;248;248;242m=[0m[38;2;230;219;116m-Xshare:off[0m
[38;2;131;148;150m  85[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  86[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Settings directory used by the application to store application settings and data that persist[0m
[38;2;131;148;150m  87[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m between application sessions, system reboots, and periodic system cleanup. Overridden values[0m
[38;2;131;148;150m  88[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m are required to be absolute paths. The current user name may be incorporated into the settings[0m
[38;2;131;148;150m  89[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m directory's name if the settings directory lives outside of the user's home directory.  The[0m
[38;2;131;148;150m  90[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m settings directory will be selected based on the following rules, in order of precedence:[0m
[38;2;131;148;150m  91[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m 1. System.getProperty("application.settingsdir")/[user-]<application>/<application>_<version>[0m
[38;2;131;148;150m  92[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m 2. System.getenv("XDG_CONFIG_HOME")/[user-]<application>/<application>_<version>[0m
[38;2;131;148;150m  93[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m 3. A platform specific default location:[0m
[38;2;131;148;150m  94[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m  - Windows: %APPDATA%\<application>\<application>_<version>[0m
[38;2;131;148;150m  95[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m  - Linux: $HOME/.config/<application>/<application>_<version>[0m
[38;2;131;148;150m  96[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m  - macOS: $HOME/Library/<application>/<application>_<version>[0m
[38;2;131;148;150m  97[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Dapplication.settingsdir=[0m
[38;2;131;148;150m  98[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m  99[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Cache directory used by the application to store cached application data that ideally will persist[0m
[38;2;131;148;150m 100[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m between application sessions and system reboots, but is not required to do so. Files stored in[0m
[38;2;131;148;150m 101[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m the cache directory may be numerous and/or large. Overridden values are required to be absolute[0m
[38;2;131;148;150m 102[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m paths. The current user name may be incorporated into the cache directory's name if the cache[0m
[38;2;131;148;150m 103[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m directory lives outside of the user's home directory. The cache directory will be selected based[0m
[38;2;131;148;150m 104[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m on the following rules, in order of precedence[0m
[38;2;131;148;150m 105[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m 1. System.getProperty("application.cachedir")/[user-]<application>[0m
[38;2;131;148;150m 106[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m 2. System.getenv("XDG_CACHE_HOME")/[user-]<application>[0m
[38;2;131;148;150m 107[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m 3. A platform specific default location:[0m
[38;2;131;148;150m 108[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m  - Windows: %LOCALAPPDATA%\<application>[0m
[38;2;131;148;150m 109[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m  - Linux: /var/tmp/<user>-<application>[0m
[38;2;131;148;150m 110[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m  - macOS: /var/tmp/<user>-<application>[0m
[38;2;131;148;150m 111[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Dapplication.cachedir=[0m
[38;2;131;148;150m 112[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m 113[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Temporary directory used by the application to store short-lived files that are not required to[0m
[38;2;131;148;150m 114[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m persist between application sessions. Overridden values are required to be absolute paths. The [0m
[38;2;131;148;150m 115[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m current user name may be incorporated into the temporary directory's name if the temporary [0m
[38;2;131;148;150m 116[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m directory lives outside of the user's home directory.  The temporary directory will be selected [0m
[38;2;131;148;150m 117[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m based on the following rules, in order of precedence:[0m
[38;2;131;148;150m 118[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m 1. System.getProperty("application.tempdir")/[user-]<application>[0m
[38;2;131;148;150m 119[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m 2. System.getProperty("java.io.tmpdir")/[user-]<application>[0m
[38;2;131;148;150m 120[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Unless overridden below, the "java.io.tmpdir" system property typically defaults to the following[0m
[38;2;131;148;150m 121[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m platform specific locations:[0m
[38;2;131;148;150m 122[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m  - Windows: %TEMP%[0m
[38;2;131;148;150m 123[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m  - Linux: /tmp[0m
[38;2;131;148;150m 124[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m  - macOS: $TMPDIR[0m
[38;2;131;148;150m 125[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Dapplication.tempdir=[0m
[38;2;131;148;150m 126[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Djava.io.tmpdir=[0m
[38;2;131;148;150m 127[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m 128[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Disable alternating row colors in tables[0m
[38;2;131;148;150m 129[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Ddisable.alternating.row.colors=true[0m
[38;2;131;148;150m 130[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m 131[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Limit on XML parsing. See https://docs.oracle.com/javase/tutorial/jaxp/limits/limits.html[0m
[38;2;131;148;150m 132[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Djdk.xml.totalEntitySizeLimit=50000000[0m
[38;2;131;148;150m 133[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m 134[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Restrict extensions to their own 'lib' directory for loading non-Ghidra jars.  This may be used[0m
[38;2;131;148;150m 135[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m to fix class resolution if multiple extensions include different versions of the same named class. [0m
[38;2;131;148;150m 136[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Dghidra.extensions.classpath.restricted=true[0m
[38;2;131;148;150m 137[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m 138[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Enables PDB debug logging during import and analysis to .ghidra/.ghidra_ver/pdb.analyzer.log[0m
[38;2;131;148;150m 139[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Dghidra.pdb.logging=true[0m
[38;2;131;148;150m 140[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m 141[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Enables PDB developer mode[0m
[38;2;131;148;150m 142[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Dghidra.pdb.developerMode=true[0m
[38;2;131;148;150m 143[0m   [38;2;131;148;150m│[0m 
[38;2;131;148;150m 144[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94m Disables the loaders echoing their message log to the application.log file[0m
[38;2;131;148;150m 145[0m   [38;2;131;148;150m│[0m [38;2;117;113;94m#[0m[38;2;117;113;94mVMARGS=-Ddisable.loader.logging=true[0m
[38;2;131;148;150m───────┴─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────[0m
