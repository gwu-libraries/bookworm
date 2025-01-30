interface Props {
  institutionOpenalexId: string;
  ror: string;
  countryCode: string;
  institutionType: string;
  homepageUrl: string;
  imageUrl: string;
  imageThumbnailUrl: string;
  worksCount: number;
  citedByCount: number;
  wikidata: string;
  wikipedia: string;
  mag: string;
  grid: string;
  city: string;
  region: string;
  country: string;
  latitude: number;
  longitude: number;
}

function InstitutionDetails({
  institutionOpenalexId,
  ror,
  countryCode,
  institutionType,
  homepageUrl,
  imageUrl,
  imageThumbnailUrl,
  worksCount,
  citedByCount,
  wikidata,
  wikipedia,
  mag,
  grid,
  city,
  region,
  country,
  latitude,
  longitude
}: Props) {
  return (
    <>
    <table>
      <tbody
          className="border-collapse border border-slate-500"
          style={{ backgroundColor: "rgb(229, 190, 190)" }}
          >
            {institutionOpenalexId && 
              <tr className="border border-slate-700">
                <td>OpenAlex ID</td>
                <td>{institutionOpenalexId}</td>
              </tr>}

            {ror && 
              <tr className="border border-slate-700">
                <td>ROR</td>
                <td>{ror}</td>
              </tr>}

            {countryCode && 
              <tr className="border border-slate-700">
                <td>Country Code</td>
                <td>{countryCode}</td>
              </tr>}

            {institutionType && 
              <tr className="border border-slate-700">
                <td>Institution Type</td>
                <td>{institutionType}</td>
              </tr>}

            {homepageUrl && 
              <tr className="border border-slate-700">
                <td>Homepage URL</td>
                <td>{homepageUrl}</td>
              </tr>}

            {imageUrl && 
              <tr className="border border-slate-700">
                <td>Image URL</td>
                <td>{imageUrl}</td>
              </tr>}

            {imageThumbnailUrl && 
              <tr className="border border-slate-700">
                <td>Image Thumbnail URL</td>
                <td>{imageThumbnailUrl}</td>
              </tr>}

            {worksCount && 
              <tr className="border border-slate-700">
                <td>Works Count</td>
                <td>{worksCount}</td>
              </tr>}

            {citedByCount && 
              <tr className="border border-slate-700">
                <td>Cited By Count</td>
                <td>{citedByCount}</td>
              </tr>}

            {wikidata && 
              <tr className="border border-slate-700">
                <td>Wikidata</td>
                <td>{wikidata}</td>
              </tr>}

            {wikipedia && 
              <tr className="border border-slate-700">
                <td>Wikipedia</td>
                <td>{wikidata}</td>
              </tr>}

            {mag && 
              <tr className="border border-slate-700">
                <td>MAG</td>
                <td>{mag}</td>
              </tr>}

            {grid && 
              <tr className="border border-slate-700">
                <td>GRID</td>
                <td>{grid}</td>
              </tr>}

            {city && 
              <tr className="border border-slate-700">
                <td>City</td>
                <td>{city}</td>
              </tr>}

            {region && 
              <tr className="border border-slate-700">
                <td>Region</td>
                <td>{region}</td>
              </tr>}

            {country && 
              <tr className="border border-slate-700">
                <td>Country</td>
                <td>{country}</td>
              </tr>}

            {latitude && 
              <tr className="border border-slate-700">
                <td>Latitude</td>
                <td>{latitude}</td>
              </tr>}

            {longitude && 
              <tr className="border border-slate-700">
                <td>Longitude</td>
                <td>{longitude}</td>
              </tr>}
    
      </tbody>

    </table>
    </>
  )
}

export default InstitutionDetails;