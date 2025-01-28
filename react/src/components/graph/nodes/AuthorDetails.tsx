interface Props {
  authorOpenalexId: string;
  orcid: string;
  displayName: string;
  worksCount: number;
  citedByCount: number;
  lastKnownInstitution: string;
  scopus: string;
  wikipedia: string;
  mag: string;
}

function AuthorDetails({
  authorOpenalexId,
  orcid,
  displayName,
  worksCount,
  citedByCount,
  lastKnownInstitution,
  scopus,
  wikipedia,
  mag
}: Props) {
  return (
    <>
      <table
        className="border-collapse border border-slate-500"
        style={{ backgroundColor: "rgb(229, 190, 190)" }}
      >
        <tbody>
          {authorOpenalexId &&
            <tr className="border border-slate-700">
              <td>OpenAlexId</td>
              <td>{authorOpenalexId}</td>
            </tr>
          }
          {orcid &&
            <tr className="border border-slate-700">
              <td>ORCID</td>
              <td>{orcid}</td>
            </tr>
          }
          {displayName &&
            <tr className="border border-slate-700">
              <td>Cited By Count</td>
              <td>{citedByCount}</td>
            </tr>
          }
          {worksCount &&
            <tr className="border border-slate-700">
              <td>Works Count</td>
              <td>{worksCount}</td>
            </tr>
          }
          {citedByCount &&
            <tr className="border border-slate-700">
              <td>Cited By Count</td>
              <td>{citedByCount}</td>
            </tr>
          }
          {lastKnownInstitution &&
            <tr className="border border-slate-700">
              <td>Last Known Institution</td>
              <td>{lastKnownInstitution}</td>
            </tr>
          }
          {scopus &&
            <tr className="border border-slate-700">
              <td>SCOPUS</td>
              <td>{scopus}</td>
            </tr>
          }
          {wikipedia &&
            <tr className="border border-slate-700">
              <td>Wikipedia</td>
              <td>{wikipedia}</td>
            </tr>
          }
          {mag &&
            <tr className="border border-slate-700">
              <td>MAG</td>
              <td>{mag}</td>
            </tr>
          }
        </tbody>
      </table>
    </>
  );
}

export default AuthorDetails;
