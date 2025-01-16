interface Props {
  displayName: string;
  orcid: string;
  authorOpenalexId: string;
  worksCount: number;
  citedByCount: number;
  lastKnownInstitution: string;
}

function AuthorDetails({
  displayName,
  orcid,
  authorOpenalexId,
  worksCount,
  citedByCount,
  lastKnownInstitution,
}: Props) {
  return (
    <>
      <table
        className="border-collapse border border-slate-500"
        style={{ backgroundColor: "rgb(229, 190, 190)" }}
      >
        <tr className="border border-slate-700">
          <td>ORCID</td>
          <td>{orcid}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>OpenAlexId</td>
          <td>{authorOpenalexId}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Cited By Count</td>
          <td>{citedByCount}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Works Count</td>
          <td>{worksCount}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Last Known Institution</td>
          <td>{lastKnownInstitution}</td>
        </tr>

      </table>
    </>
  );
}

export default AuthorDetails;
