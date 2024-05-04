template=$1

for file in $(find . -name "*.md")
do
    dir=$(dirname "${file}")
    temp_file="${dir}/temp.md"
    sed 's/\\R/\\mathbb{R}/g; s/\\N/\\mathbb{N}/g' "${file}" > "${temp_file}"
    mkdir -p "./output/${dir}"
    pandoc "${temp_file}" --mathjax -s --template $template -o "${temp_file%.md}.html"
    chromium --headless --print-to-pdf="${file%.md}.pdf" --no-pdf-header-footer --run-all-compositor-stages-before-draw --virtual-time-budget=300 "${temp_file%.md}.html"
    mv "${file%.md}.pdf" "./output/${dir}"
    rm "${temp_file}"
    rm "${temp_file%.md}.html"
done