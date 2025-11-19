-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete without yank" })
vim.keymap.set({ "n", "v" }, "dd", '"_dd', { desc = "Delete line without yank" })
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "Delete char without yank" })
vim.keymap.set("x", "p", '"_dP', { desc = "Paste without overwriting" })
