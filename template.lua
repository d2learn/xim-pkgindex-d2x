

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

local projectdir = path.filename(package.repo)
local rundir = system.rundir()
local d2x_projectdir = path.join(rundir, package.name)

function installed()
    return os.isdir(d2x_projectdir)
end

function install()
    os.cp(projectdir, d2x_projectdir)
    os.tryrm(projectdir)
    os.cd(d2x_projectdir)
    system.exec("xlings install")
    return true
end

function uninstall()
    os.tryrm(d2x_projectdir)
    return true
end
