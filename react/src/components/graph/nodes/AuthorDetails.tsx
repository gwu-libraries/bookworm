interface Props {
  name: string;
  orcid: string;
  openalexId: string;
  hIndex: number;
  i10Index: number;
  citedByCount: number;
  worksCount: number;
}

function AuthorDetails({
  orcid,
  openalexId,
  hIndex,
  i10Index,
  citedByCount,
  worksCount,
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
          <td>{openalexId}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>h-Index</td>
          <td>{hIndex}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>i10 Index</td>
          <td>{i10Index}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Cited By Count</td>
          <td>{citedByCount}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Works Count</td>
          <td>{worksCount}</td>
        </tr>
      </table>
    </>
  );
}

export default AuthorDetails;
