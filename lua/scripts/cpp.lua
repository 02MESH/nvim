-- NOTE: C++ compile script

local M = {}

-- Ensure the temporary directory exists
vim.fn.mkdir("/tmp/c++", "p")

-- Get the full path of the current file
local function get_paths()
  local file_path = vim.fn.expand("%:p")
  local file_name = vim.fn.expand("%:t:r")
  local output = "/tmp/c++/" .. file_name
  return file_path, output
end

local function compile_and_run()
  local file_path, output = get_paths()

  -- Compile command with C++17 standard
  local compile_cmd = "clang++ -std=c++20 " .. file_path .. " -o " .. output

  -- Notify the user about the compilation
  print("Compiling " .. file_path .. " with C++17 standard...")

  -- Execute the compile command and capture the output
  local compile_result = vim.fn.systemlist(compile_cmd)

  -- Check if compilation was successful
  if vim.v.shell_error == 0 then
    -- Compilation succeeded, run the program in a new terminal split
    print("Running " .. output .. " in a new pane...")
    -- Open a new terminal split and run the program
    vim.cmd("belowright split | terminal " .. output)
    -- Switch to terminal mode to allow input
    vim.cmd("startinsert")
  else
    -- Compilation failed, open a new buffer to show the errors
    vim.cmd("belowright split")
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, compile_result)
    vim.api.nvim_set_current_buf(bufnr)
    print("Compilation failed. See the split window for details.")
  end
end

local function compile_debug()
  local file_path, output = get_paths()

  -- Debug command with C++17 standard
  local debug_cmd = "clang++ -g -std=c++17 " .. file_path .. " -o " .. output

  print("Compiling " .. file_path .. " with C++17 standard and debug symbols...")

  local compile_result = vim.fn.systemlist(debug_cmd)

  if vim.v.shell_error == 0 then
    print("Compiled " .. output .. " for debugging.")
  else
    vim.cmd("belowright split")
    local bufnr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, compile_result)
    vim.api.nvim_set_current_buf(bufnr)
    print("Compilation failed. See the split window for details.")
  end
end

M.compile_and_run = compile_and_run
M.compile_debug = compile_debug

-- Create keymaps for compile_and_run and compile_debug
vim.keymap.set("n", "<leader>cpp", M.compile_and_run, { desc = "Compile and Run C++ Program" })
vim.keymap.set("n", "<leader>cpd", M.compile_debug, { desc = "Compile C++ Program with Debug Symbols" })

return M
