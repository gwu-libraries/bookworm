import { useParams } from "react-router";

interface Props {
  title: string;
  doi: string;
  publicationYear: number;
  publicationDate: number;
  workType: string;
  citedByCount: number;
  isRetracted: boolean;
  isParatext: boolean;
  language: string;
  // isOpenAccess: boolean;
  workOpenalexId: string;
  // abstract: string;
}

function WorkDetails({
  title,
  doi,
  publicationYear,
  publicationDate,
  workType,
  citedByCount,
  isRetracted,
  isParatext,
  language
}: Props) {

  return (
    <>
      <table
        className="border-collapse border border-slate-500"
        style={{ backgroundColor: "rgb(229, 190, 190)" }}
      >
        <tr className="border border-slate-700">
          <td>Title</td>
          <td>{title}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>DOI</td>
          <td>{doi}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Publication Year</td>
          <td>{publicationYear}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Publication Date</td>
          <td>{publicationDate}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Work Type</td>
          <td>{workType}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Language</td>
          <td>{language}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Cited By Count</td>
          <td>{citedByCount}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Is Retracted?</td>
          <td>{isRetracted}</td>
        </tr>
        <tr className="border border-slate-700">
          <td>Is Paratext?</td>
          <td>{isParatext}</td>
        </tr>

      </table>
    </>
  );
}

export default WorkDetails;
