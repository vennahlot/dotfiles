-- Started by nvim-jdtls on every Java buffer (see plugins/jdtls.lua).
local ok, jdtls = pcall(require, "jdtls")
if not ok then
    return
end

local mason = vim.fn.stdpath("data") .. "/mason/packages"
local launcher = mason .. "/jdtls/bin/jdtls"
if vim.fn.executable(launcher) == 0 then
    vim.notify("jdtls is not installed — run :MasonInstall jdtls", vim.log.levels.WARN)
    return
end

-- One workspace directory per project, keyed by project root name.
local root = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "build.gradle", "build.gradle.kts", ".git" })
    or vim.fn.getcwd()
local workspace = vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(root, ":p:h:t")

jdtls.start_or_attach({
    cmd = { launcher, "-data", workspace },
    root_dir = root,
    settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" }, -- decompile class files
            completion = {
                favoriteStaticMembers = {
                    "org.junit.Assert.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "org.mockito.Mockito.*",
                },
            },
            sources = {
                organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 },
            },
        },
    },
})

vim.keymap.set("n", "<leader>co", jdtls.organize_imports, { buffer = 0, desc = "[C]ode [O]rganize imports" })
vim.keymap.set("n", "<leader>cv", jdtls.extract_variable, { buffer = 0, desc = "[C]ode extract [V]ariable" })
vim.keymap.set("n", "<leader>cm", jdtls.extract_method, { buffer = 0, desc = "[C]ode extract [M]ethod" })
vim.keymap.set("v", "<leader>cv", function() jdtls.extract_variable(true) end, { buffer = 0, desc = "[C]ode extract [V]ariable" })
vim.keymap.set("v", "<leader>cm", function() jdtls.extract_method(true) end, { buffer = 0, desc = "[C]ode extract [M]ethod" })
