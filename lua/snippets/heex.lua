local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Basic HEEx structure
  s("heex", {
    t("<"),
    i(1, "div"),
    t(" class=\""),
    i(2),
    t("\">"),
    t({"", "  "}),
    i(3),
    t({"", "</"}),
    f(function(args) return args[1][1] end, {1}),
    t(">"),
  }),

  -- HEEx component
  s("comp", {
    t("<."),
    i(1, "component"),
    t(" "),
    i(2),
    t(" />"),
  }),

  -- HEEx component with content
  s("compc", {
    t("<."),
    i(1, "component"),
    t(" "),
    i(2),
    t(">"),
    t({"", "  "}),
    i(3),
    t({"", "</."}),
    f(function(args) return args[1][1] end, {1}),
    t(">"),
  }),

  -- Phoenix form
  s("form", {
    t("<.simple_form for={@"),
    i(1, "form"),
    t("} phx-submit=\""),
    i(2, "save"),
    t("\">"),
    t({"", "  "}),
    i(3),
    t({"", "</.simple_form>"}),
  }),

  -- Form input
  s("input", {
    t("<.input field={@"),
    i(1, "form"),
    t("[:"),
    i(2, "field"),
    t("]} type=\""),
    i(3, "text"),
    t("\" label=\""),
    i(4, "Label"),
    t("\" />"),
  }),

  -- Button
  s("btn", {
    t("<.button"),
    c(1, {
      t(""),
      t(" type=\"submit\""),
      t(" phx-click=\""),
    }),
    i(2),
    t("\">"),
    i(3, "Click me"),
    t("</.button>"),
  }),

  -- Link
  s("link", {
    t("<.link href=\""),
    i(1),
    t("\">"),
    i(2, "Link text"),
    t("</.link>"),
  }),

  -- Navigate link
  s("nav", {
    t("<.link navigate={~p\""),
    i(1, "/path"),
    t("\"}>"),
    i(2, "Link text"),
    t("</.link>"),
  }),

  -- Table
  s("table", {
    t("<.table rows={@"),
    i(1, "items"),
    t("} id=\""),
    i(2, "table_id"),
    t("\">"),
    t({"", "  <:col :let={item} label=\""}),
    i(3, "Column"),
    t("\">"),
    t({"", "    "}),
    i(4, "item.field"),
    t({"", "  </:col>"}),
    t({"", "</.table>"}),
  }),

  -- Modal
  s("modal", {
    t("<.modal id=\""),
    i(1, "modal_id"),
    t("\" show={@"),
    i(2, "show_modal"),
    t("}>"),
    t({"", "  "}),
    i(3),
    t({"", "</.modal>"}),
  }),

  -- Flash message
  s("flash", {
    t("<.flash kind={:"),
    i(1, "info"),
    t("} flash={@flash} />"),
  }),

  -- Header
  s("header", {
    t("<.header>"),
    t({"", "  "}),
    i(1, "Title"),
    t({"", "  <:subtitle>"}),
    i(2, "Subtitle"),
    t({"", "  </:subtitle>"}),
    t({"", "</.header>"}),
  }),

  -- List
  s("list", {
    t("<.list>"),
    t({"", "  <:item title=\""}),
    i(1, "Title"),
    t("\">"),
    i(2, "Content"),
    t({"", "  </:item>"}),
    t({"", "</.list>"}),
  }),

  -- If condition
  s("if", {
    t("<%= if "),
    i(1, "condition"),
    t(" do %>"),
    t({"", "  "}),
    i(2),
    t({"", "<% end %>"}),
  }),

  -- Unless condition
  s("unless", {
    t("<%= unless "),
    i(1, "condition"),
    t(" do %>"),
    t({"", "  "}),
    i(2),
    t({"", "<% end %>"}),
  }),

  -- For comprehension
  s("for", {
    t("<%= for "),
    i(1, "item"),
    t(" <- @"),
    i(2, "items"),
    t(" do %>"),
    t({"", "  "}),
    i(3),
    t({"", "<% end %>"}),
  }),

  -- Assign
  s("assign", {
    t("<% "),
    i(1, "variable"),
    t(" = "),
    i(2, "value"),
    t(" %>"),
  }),

  -- Phoenix.HTML escape
  s("escape", {
    t("<%= "),
    i(1),
    t(" %>"),
  }),

  -- Raw output
  s("raw", {
    t("<%=raw "),
    i(1),
    t(" %>"),
  }),

  -- Comment
  s("comment", {
    t("<%!-- "),
    i(1, "comment"),
    t(" -->"),
  }),

  -- LiveView socket assign
  s("socket", {
    t("socket"),
    t({"", "|> assign(:"}),
    i(1, "key"),
    t(", "),
    i(2, "value"),
    t(")"),
  }),

  -- Stream
  s("stream", {
    t("<div"),
    t(" id=\""),
    i(1, "stream_id"),
    t("\""),
    t(" phx-update=\"stream\">"),
    t({"", "  <%= for {id, "}),
    i(2, "item"),
    t("} <- @"),
    i(3, "stream"),
    t(" do %>"),
    t({"", "    <div id={id}>"}),
    t({"", "      "}),
    i(4),
    t({"", "    </div>"}),
    t({"", "  <% end %>"}),
    t({"", "</div>"}),
  }),
}