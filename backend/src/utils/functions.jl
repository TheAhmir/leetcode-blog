using MarkdownMetadata

function load_posts()
    posts = Dict()
    for i in read_docs(posts_dir)
        file_path = joinpath(posts_dir, i)
        metadata, content = extract_metadata(:markdown, file_path)
        posts[metadata["slug"]] = Dict(
            "metadata" => metadata,
            "content" => content
        )
    end
    return posts
end

