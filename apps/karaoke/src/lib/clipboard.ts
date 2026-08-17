const RICH_TEXT_BLOCKS = "p,li,pre,blockquote,h1,h2,h3,h4,h5,h6";

export function normalizedClipboardText(plainText: string, htmlText = ""): string {
  const plain = normalizeNewlines(plainText);
  const rich = htmlText ? textFromRichHtml(htmlText) : "";
  return blankLineCount(rich) > blankLineCount(plain) ? rich : plain;
}

function textFromRichHtml(html: string): string {
  if (typeof DOMParser === "undefined") return "";
  const document = new DOMParser().parseFromString(html, "text/html");
  const blocks = [...document.body.querySelectorAll(RICH_TEXT_BLOCKS)]
    .filter((block) => !block.querySelector(RICH_TEXT_BLOCKS));
  if (!blocks.length) return "";

  return tidyPastedText(blocks
    .map((block) => textWithBreaks(block).trim())
    .filter(Boolean)
    .join("\n\n"));
}

function textWithBreaks(node: Node): string {
  return [...node.childNodes].map((child) => {
    if (child.nodeType === 3) return child.nodeValue ?? "";
    if (child instanceof HTMLBRElement) return "\n";
    return textWithBreaks(child);
  }).join("");
}

function normalizeNewlines(value: string) {
  return value
    .replace(/\r\n?/g, "\n")
    .replace(/\u2028/g, "\n")
    .replace(/\u2029/g, "\n\n")
    .replaceAll("\u00a0", " ");
}

function tidyPastedText(value: string) {
  return normalizeNewlines(value)
    .replace(/[\t ]+\n/g, "\n")
    .replace(/\n[\t ]+/g, "\n")
    .replace(/\n{3,}/g, "\n\n")
    .trim();
}

function blankLineCount(value: string) {
  return value.match(/\n\n/g)?.length ?? 0;
}
