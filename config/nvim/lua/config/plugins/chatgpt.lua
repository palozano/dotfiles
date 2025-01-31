return {
  enabled = false,
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    local home = vim.fn.expand("$HOME")
    require("chatgpt").setup({
      api_key_cmd = "gpg --decrypt " .. home .. "/secret.txt.gpg",
      openai_params = {
        model = "chatgpt-4o-latest",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
      }
    })
    vim.keymap.set("n", "<leader>oo", function() require("chatgpt").openChat() end, { desc = "open chat" })
    vim.keymap.set("v", "<leader>oe", function() require("chatgpt").edit_with_instructions() end,
      { desc = "open chat with instructions" })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  }
}
