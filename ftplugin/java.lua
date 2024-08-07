local workspaceDir = vim.fn.stdpath('data') ..
    '/jdtls' .. vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1])

local config = {
    cmd = {
        'java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. vim.fn.stdpath('data') .. '/mason/packages/jdtls/lombok.jar',

        '-jar', vim.fn.stdpath('data') ..
    '/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',

        '-configuration', vim.fn.stdpath('data') .. '/mason/packages/jdtls/config_linux',

        -- See `data directory configuration` section in the README
        '-data', workspaceDir
    },

    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    settings = {
        java = {
            project = {
                sourcePaths = { "target/generated-sources/annotations" }
            },
            format = {
                settings = {
                    url = "./eclipse-formatter.xml",
                    profile = "Aprenia"
                }
            },
            maven = {
                downloadSources = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            extendedClientCapabilities = require('jdtls').extendedClientCapabilities,
        },
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {}
    },
}

require('jdtls').start_or_attach(config)
