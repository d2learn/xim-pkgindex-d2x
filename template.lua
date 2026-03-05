

-- d2x common template (appended by pkgindex-build.lua)

package.type = "courses"
package.xpm = {
    windows = { ["latest"] = { url = package.repo .. ".git" } },
    linux = { ["latest"] = { url = package.repo .. ".git" } },
    macosx = { ["latest"] = { url = package.repo .. ".git" } },
}

import("xim.libxpkg.pkginfo")
import("xim.libxpkg.system")
import("xim.libxpkg.log")

-- NOTE: system.rundir() depends on _RUNTIME which is only available
-- inside hook functions (injected before each hook call), so we must
-- NOT call it at top-level / module-load time.

local projectdir = path.filename(package.repo)

local function d2x_projectdir()
    return path.join(system.rundir(), package.name)
end

function installed()
    return os.isdir(d2x_projectdir())
end

function install()
    local dest = d2x_projectdir()
    os.cp(projectdir, dest)
    os.tryrm(projectdir)
    os.cd(dest)
    system.exec("xlings install")
    return true
end

function uninstall()
    os.tryrm(d2x_projectdir())
    return true
end
