{lib, ...}: {
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        component_separators = "";
        globalstatus = true;
        theme = "base16";
        section_separators = "";
      };
      sections = {
        lualine_a = ["mode"];
        lualine_b = [""];
        lualine_c = [
          "filetype"
          "filename"
        ];
        lualine_x = [
          {
            __unkeyed = lib.nixvim.mkRaw ''
              function()
                if vim.bo.filetype == "markdown" or vim.bo.filetype == "text" or vim.bo.filetype == "typst" or vim.bo.filetype == "" then
                  local char_count = vim.fn.wordcount().chars
                  local word_count = vim.fn.wordcount().words
                  if vim.fn.wordcount().visual_chars ~= nil then
                    char_count = vim.fn.wordcount().visual_chars
                    word_count = vim.fn.wordcount().visual_words
                  end

                  return tostring(char_count)
                    .. (char_count == 1 and " character" or " characters")
                    .. ", "
                    .. tostring(word_count)
                    .. (word_count == 1 and " word" or " words")
                else
                  return ""
                end
              end
            '';
          }
          "location"
        ];
        lualine_y = [""];
        lualine_z = [""];
      };
    };
  };
}