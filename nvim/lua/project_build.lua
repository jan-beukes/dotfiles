-- allow custom build function in build.lua file

-- find the nearest `build.lua` in the current or parent directories
local function find_build_file()
  local dir = vim.fn.getcwd()
  while dir ~= '/' do
    local build_file = dir .. '/build.lua'
    if vim.fn.filereadable(build_file) == 1 then
      return build_file, dir
    end
    dir = vim.fn.fnamemodify(dir, ':h') -- Move to the parent directory
  end
  return nil, nil -- No file found
end

-- Function to load project-specific build command
return {
  load_project_build = function()
    local build_file, build_dir = find_build_file()
    if build_file then
      local _, build_and_run = pcall(dofile, build_file) -- build_and_run function

      -- Map <leader>b to the function returned by `build.lua`
      if build_and_run then
        vim.keymap.set('n', '<leader>b', function()
          -- cd to build dir
          local cwd = vim.fn.getcwd()
          vim.cmd('cd ' .. build_dir)
          build_and_run()
          vim.cmd('cd ' .. cwd) -- restore cwd
        end, { silent = true, noremap = true, desc = 'execute build.lua' })
      else
        vim.notify('function not defined in ' .. build_file, vim.log.levels.WARN)
      end
    end
  end,
}
