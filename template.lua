

-- package = { ... }
-- common implement of d2x's package file

xpm_os_common = {
    ["latest"] = {
        url = package.repo .. ".git",
        sha256 = nil,
    },
}

package.type = "courses"
package.xpm = {
    windows = xpm_os_common,
    linux = xpm_os_common,
    macosx = xpm_os_common,
}

import("platform")
import("xim.base.runtime")

local rundir = platform.get_config_info().rundir
local d2x_projectdir = path.join(rundir, package.name)

function installed()
    return os.isdir(d2x_projectdir)
end

function install()
    -- TODO: fix make os.mv interface for windows cross-disk symbol
    --os.mv(package.name, rundir)
    os.cp(package.name, rundir)
    os.tryrm(package.name)
    os.cd(d2x_projectdir)
    -- install project dependencies
    os.exec("xim")
    return true
end

function uninstall()
    os.tryrm(d2x_projectdir)
    return true
end