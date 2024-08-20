local workspaceDir = vim.fn.stdpath('data') ..
    '/jdtls' .. vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1])


local java_debug_path = require('mason-registry')
    .get_package('java-debug-adapter')
    :get_install_path()

local jdtls_path = require('mason-registry')
    .get_package('jdtls')
    :get_install_path()

local java_debug_bundle = vim.split(
    vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'),
    '\n'
)

local bundles = {}

if java_debug_bundle[1] ~= '' then
    vim.list_extend(bundles, java_debug_bundle)
end

local function enable_debugger(bufnr)
    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
end

local function jdtls_on_attach(client, bufnr)
    enable_debugger(bufnr)

    -- The following mappings are based on the suggested usage of nvim-jdtls
    -- https://github.com/mfussenegger/nvim-jdtls#usage

    --  local opts = {buffer = bufnr}
    --  vim.keymap.set('n', '<A-o>', "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
    --  vim.keymap.set('n', 'crv', "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
    --  vim.keymap.set('x', 'crv', "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
    --  vim.keymap.set('n', 'crc', "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
    --  vim.keymap.set('x', 'crc', "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
    --  vim.keymap.set('x', 'crm', "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)
end

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
        '-javaagent:' .. jdtls_path .. '/lombok.jar',

        '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),

        '-configuration', jdtls_path .. '/config_linux',

        -- See `data directory configuration` section in the README
        '-data', workspaceDir
    },
    on_attach = jdtls_on_attach,
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
        bundles = bundles
    },
    capabilities = {
        workspace = {
            configuration = true,
        },
        --       textDocument = {
        --          completion = {
        --              completionItem = {
        --                  snippentSupport = true,
        --              },
        --          },
        --      },
    },
}

--config.capabilities = require("cmp_nvim_lsp").default_capabilities(
config.capabilities = vim.lsp.protocol.make_client_capabilities()
require('jdtls').start_or_attach(config)
