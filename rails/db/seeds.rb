include FactoryBot::Syntax::Methods

# create authors
authors = create_list(:author, 20)

# create works
works = create_list(:work, 50)

# create institutions
institutions = create_list(:institution, 20)

# create sources
sources = create_list(:source, 20)

# create publishers
publishers = create_list(:publisher, 20)

# create topics
topics = create_list(:topic, 20)

# associate works
works.each_with_index do |work, index|
  works
    .excluding(works[index])
    .sample(rand(2..6))
    .each do |w|
      WorksReferencedWorks.create(
        work_openalex_id: work.work_openalex_id,
        referenced_work_openalex_id: w.work_openalex_id
      )
    end
end

# associate authors, works, institutions
works.each do |work|
  authors
    .sample(rand(3..5))
    .each do |author|
      WorksAuthorship.create(
        work_openalex_id: work.work_openalex_id,
        author_openalex_id: author.author_openalex_id,
        institution_openalex_id: (institutions.sample).institution_openalex_id,
        author_position: %w[first middle last].sample,
        raw_affiliation_string: 'beepbeep'
      )
    end
end

# associate institutions with each other
institutions[1..]
  .sample(rand(5..10))
  .each do |i|
    InstitutionsAssociatedInstitutions.create(
      institution_openalex_id: institutions[0].institution_openalex_id,
      associated_institution_openalex_id: i.institution_openalex_id,
      relationship: %w[funder parent/child].sample
    )
  end

# associate works with topics
works.each do |work|
  topics.each do |topic|
    WorksTopic.create(
      work_openalex_id: work.work_openalex_id,
      topic_openalex_id: topic.topic_openalex_id
    )
  end
end
