# Ollama Build Guide for Intel Arc GPU (Windows)

This guide provides a step-by-step process to build Ollama from source with hardware acceleration for **Intel Arc (Vulkan)** and **13th+ Gen Intel CPUs**.

## 1. Prerequisites

Install the following tools required for the build process:

- **Go (1.24+):** [Download Go](https://go.dev/dl/)
- **Git:** [Download Git](https://git-scm.com/downloads)
- **CMake:** [Download CMake](https://cmake.org/download/)
- **Visual Studio 2022:** [Download VS 2022](https://visualstudio.microsoft.com/downloads/) (Include the "Desktop development with C++" workload).
- **Vulkan SDK:** [Download Vulkan SDK](https://vulkan.lunarg.com/sdk/home) (Required for Intel Arc GPU acceleration).

## 2. Clone the Repository

Open PowerShell and run the following commands to get the source code:

```powershell
git clone https://github.com/ollama/ollama.git
cd ollama
```

## 3. Environment Setup

Ensure the Vulkan SDK path is recognized by your terminal (replace `<version>` with your installed version, e.g., `1.4.341.1`):

```powershell
$env:VULKAN_SDK = "C:\VulkanSDK\<version>"
```

## 4. Building Ollama

Run the following command in the project root to build the optimized binaries for your hardware:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build_windows.ps1 cpu vulkan ollama
```

This will generate a `dist\windows-amd64` folder containing the release files.

## 5. Final Installation

To run Ollama from anywhere and ensure it uses your GPU:

1.  **Add to Path:** Add `C:\ollama\dist\windows-amd64` to your System Environment Variables **Path**.
2.  **Configure Environment Variables:** Add these System Environment Variables:
    - `OLLAMA_VULKAN` = `1` (Enables GPU acceleration).
    - `OLLAMA_HOST` = `0.0.0.0:11434` (Allows connections from other devices on your network).

**Important:** The `lib` folder must stay in the same directory as `ollama.exe`. If you move `ollama.exe` to a new folder (like `C:\ollama\outfile\`), you must also move the `lib` folder there so it becomes `C:\ollama\outfile\lib\ollama`.

## 6. Remote Access & Firewall (Optional)

If you want to access Ollama from another PC or your phone (e.g., via your IP `192.168.0.x`), you must open the port in the Windows Firewall. Run this command as **Administrator**:

```powershell
New-NetFirewallRule -DisplayName "Ollama Port" -Direction Inbound -LocalPort 11434 -Protocol TCP -Action Allow
```

## 7. Usage

Open a new PowerShell window and run:

```powershell
ollama serve
```

**Verification:**
Look for these lines in the logs to confirm success:

- `library=Vulkan` -> GPU acceleration is active.
- `description="Intel(R) Arc(TM) Graphics"` -> Your A770 is detected.
- `Listening on [::]:11434` -> Server is reachable on your network.

## 8. Reference Links

- **Ollama Development Documentation:** [Library Detection](https://docs.ollama.com/development#library-detection)
- **Gemini Share:** [Build & Discussion Summary](https://gemini.google.com/share/1ffb6edb824a)
