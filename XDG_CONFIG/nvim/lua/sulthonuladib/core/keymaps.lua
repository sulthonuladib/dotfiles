local add_keymap = vim.keymap.set

add_keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move the highlighted text down" })
add_keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move the highlighted text up" })
add_keymap("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
add_keymap("n", "<C-d>", "<C-d>zz", { desc = "Move down half screen and center cursor" })
add_keymap("n", "<C-u>", "<C-u>zz", { desc = "Move up half screen and center cursor" })
add_keymap("n", "n", "nzzzv", { desc = "Move to next search result and center cursor" })
add_keymap("n", "N", "Nzzzv", { desc = "Move to previous search result and center cursor" })
add_keymap("x", "<leader>p", [["_dP]], { desc = "Paste and keep word" })
add_keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
add_keymap("n", "<leader>Y", [["+Y]], { desc = "Copy to clipboard" })
add_keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Cut to clipboard" })
add_keymap("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })
add_keymap("n", "Q", "<nop>", { desc = "Disable Ex mode" })
add_keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Open Tmux Session" })
add_keymap(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "find and remap current word" }
)

-- window resizing
add_keymap("n", "<M-h>", "<c-w>5<")
add_keymap("n", "<M-l>", "<c-w>5>")
add_keymap("n", "<M-j>", "<C-W>+")
add_keymap("n", "<M-k>", "<C-W>-")

-- utilizing vim builtin terminal
add_keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
add_keymap("n", "<leader>tn", vim.cmd.tabnext, { desc = "Move to next tab" })
add_keymap("n", "<leader>tp", vim.cmd.tabprevious, { desc = "Move to previous tab" })
add_keymap("n", "<leader>ht", function()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.api.nvim_win_set_height(0, 12)
	vim.wo.winfixheight = true
	vim.cmd.term()
end, { desc = "half terminal " })
add_keymap("n", "<leader>tt", function()
	vim.cmd.tabnew()
	vim.cmd.term()
end, { desc = "Open a terminal in a new tab" })
