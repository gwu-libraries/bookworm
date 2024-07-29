# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenalexService do
  it 'returns details about a work by DOI', :vcr do
    doi = '10.1145/3174781.3174785'

    response = OpenalexService.get_paper_details(doi)

    expect(response).to be_a(Hash)
    expect(response.keys).to eq(
      %i[
        id
        doi
        title
        display_name
        publication_year
        publication_date
        ids
        language
        primary_location
        type
        type_crossref
        indexed_in
        open_access
        authorships
        countries_distinct_count
        institutions_distinct_count
        corresponding_author_ids
        corresponding_institution_ids
        apc_list
        apc_paid
        fwci
        has_fulltext
        fulltext_origin
        cited_by_count
        cited_by_percentile_year
        biblio
        is_retracted
        is_paratext
        primary_topic
        topics
        keywords
        concepts
        mesh
        locations_count
        locations
        best_oa_location
        sustainable_development_goals
        grants
        datasets
        versions
        referenced_works_count
        referenced_works
        related_works
        ngrams_url
        abstract_inverted_index
        cited_by_api_url
        counts_by_year
        updated_date
        created_date
      ]
    )
  end

  it 'returns array of responses with data on references of a work by OpenAlex ID',
     :vcr do
    openalex_id = 'W2785752813'

    response = OpenalexService.get_paper_references(openalex_id)

    expect(response).to be_a(Array)

    expect(response.first.keys).to eq(%i[meta results group_by])

    expect(response.first[:results].first.keys).to eq(
      %i[
        id
        doi
        title
        display_name
        publication_year
        publication_date
        ids
        language
        primary_location
        type
        type_crossref
        indexed_in
        open_access
        authorships
        countries_distinct_count
        institutions_distinct_count
        corresponding_author_ids
        corresponding_institution_ids
        apc_list
        apc_paid
        fwci
        has_fulltext
        fulltext_origin
        cited_by_count
        cited_by_percentile_year
        biblio
        is_retracted
        is_paratext
        primary_topic
        topics
        keywords
        concepts
        mesh
        locations_count
        locations
        best_oa_location
        sustainable_development_goals
        grants
        datasets
        versions
        referenced_works_count
        referenced_works
        related_works
        ngrams_url
        abstract_inverted_index
        cited_by_api_url
        counts_by_year
        updated_date
        created_date
      ]
    )
  end

  it 'returns array of responses with data on citations of a work by OpenAlex ID',
     :vcr do
    openalex_id = 'W2785752813'

    response = OpenalexService.get_paper_citations(openalex_id)

    expect(response).to be_a(Array)

    expect(response.first.keys).to eq(%i[meta results group_by])

    expect(response.first[:results].first.keys).to eq(
      %i[
        id
        doi
        title
        display_name
        publication_year
        publication_date
        ids
        language
        primary_location
        type
        type_crossref
        indexed_in
        open_access
        authorships
        countries_distinct_count
        institutions_distinct_count
        corresponding_author_ids
        corresponding_institution_ids
        apc_list
        apc_paid
        fwci
        has_fulltext
        fulltext_origin
        cited_by_count
        cited_by_percentile_year
        biblio
        is_retracted
        is_paratext
        primary_topic
        topics
        keywords
        concepts
        mesh
        locations_count
        locations
        best_oa_location
        sustainable_development_goals
        grants
        datasets
        versions
        referenced_works_count
        referenced_works
        related_works
        ngrams_url
        abstract_inverted_index
        cited_by_api_url
        counts_by_year
        updated_date
        created_date
      ]
    )
  end

  it 'returns author information by openalexID', :vcr do
    openalex_id = 'A5023888391'

    response = OpenalexService.get_author_details(openalex_id)

    expect(response).to be_a(Hash)

    expect(response.keys).to eq(
      %i[
        id
        orcid
        display_name
        display_name_alternatives
        works_count
        cited_by_count
        summary_stats
        ids
        affiliations
        last_known_institutions
        topics
        topic_share
        x_concepts
        counts_by_year
        works_api_url
        updated_date
        created_date
      ]
    )
  end

  it 'returns an authors works by openalexid', :vcr do
    openalex_id = 'A5023888391'

    response = OpenalexService.get_author_works(openalex_id)

    expect(response).to be_a(Array)
    expect(response.first).to be_a(Hash)
    expect(response.first.keys).to eq(%i[meta results group_by])

    expect(response.first[:results].first).to be_a(Hash)

    expect(response.first[:results].first.keys).to eq(
      %i[
        id
        doi
        title
        display_name
        publication_year
        publication_date
        ids
        language
        primary_location
        type
        type_crossref
        indexed_in
        open_access
        authorships
        countries_distinct_count
        institutions_distinct_count
        corresponding_author_ids
        corresponding_institution_ids
        apc_list
        apc_paid
        fwci
        has_fulltext
        fulltext_origin
        cited_by_count
        cited_by_percentile_year
        biblio
        is_retracted
        is_paratext
        primary_topic
        topics
        keywords
        concepts
        mesh
        locations_count
        locations
        best_oa_location
        sustainable_development_goals
        grants
        datasets
        versions
        referenced_works_count
        referenced_works
        related_works
        ngrams_url
        abstract_inverted_index
        cited_by_api_url
        counts_by_year
        updated_date
        created_date
      ]
    )
  end
end
