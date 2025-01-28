import { useParams } from "react-router";

interface Props {
  workOpenalexId: string;
  doi: string;
  title: string;
  displayName: string;
  publicationYear: number;
  publicationDate: number;
  workType: string;
  citedByCount: number;
  isRetracted: boolean;
  isParatext: boolean;
  language: string;
  isOa: boolean;
  oaStatus: string;
  oaUrl: string;
  volume: string;
  issue: string;
  firstPage: string;
  lastPage: string;
  pmid: string;
  pmcid: string;
  landingPageUrl: string;
  pdfUrl: string;
  license: string;
  version: string;
  anyRepositoryHasFulltext: boolean;
}

function WorkDetails({
  workOpenalexId,
  doi,
  title,
  displayName,
  publicationYear,
  publicationDate,
  workType,
  citedByCount,
  isRetracted,
  isParatext,
  language,
  isOa,
  oaStatus,
  oaUrl,
  volume,
  issue,
  firstPage,
  lastPage,
  pmid,
  pmcid,
  landingPageUrl,
  pdfUrl,
  license,
  version,
  anyRepositoryHasFulltext
}: Props) {

  return (
    <>
      <table
        className="border-collapse border border-slate-500"
        style={{
          backgroundColor: isOa
            ? "#FBD87F"
            : "#B5F8FE",
        }}
      >
      <tbody style={{textAlign:"left"}}>
        {workOpenalexId &&
          <tr className="border border-slate-700">
            <td>Openalex ID</td>
            <td>{workOpenalexId}</td>
          </tr>
        }
        {doi &&
          <tr className="border border-slate-700">
            <td>DOI</td>
            <td>{doi}</td>
          </tr>
        }
        {title &&
          <tr className="border border-slate-700">
            <td>Title</td>
            <td>{title}</td>
          </tr>
        }
        {displayName &&
          <tr className="border border-slate-700">
            <td>Display Name</td>
            <td>{displayName}</td>
          </tr>
        }
        {publicationYear &&
          <tr className="border border-slate-700">
            <td>Publication Year</td>
            <td>{publicationYear}</td>
          </tr>
        }
        {publicationDate &&
          <tr className="border border-slate-700">
            <td>Publication Date</td>
            <td>{publicationDate}</td>
          </tr>
        }
        {workType &&
          <tr className="border border-slate-700">
            <td>Work Type</td>
            <td>{workType}</td>
          </tr>
        }
        {citedByCount &&
          <tr className="border border-slate-700">
            <td>Cited By Count</td>
            <td>{citedByCount}</td>
          </tr>
        }
        {isRetracted &&
          <tr className="border border-slate-700">
            <td>Is Retracted?</td>
            <td>{isRetracted}</td>
          </tr>
        }
        {isParatext &&
          <tr className="border border-slate-700">
            <td>Is Paratext?</td>
            <td>{isParatext}</td>
          </tr>
        }
        {language && 
          <tr className="border border-slate-700">
            <td>Language</td>
            <td>{language}</td>
          </tr>
        }
        {isOa && 
          <tr className="border border-slate-700">
            <td>Is Open Access?</td>
            <td>{isOa}</td>
          </tr>
        }
        {oaStatus &&
          <tr className="border border-slate-700">
            <td>Open Access Status</td>
            <td>{oaStatus}</td>
          </tr>
        }
        {oaUrl &&
          <tr className="border border-slate-700">
            <td>OA URL</td>
            <td>{oaUrl}</td>
          </tr>
        }
        {volume &&
          <tr className="border border-slate-700">
            <td>Volume</td>
            <td>{volume}</td>
          </tr>
        }
        {issue &&
          <tr className="border border-slate-700">
            <td>Issue</td>
            <td>{issue}</td>
          </tr>
        }
        {firstPage &&
          <tr className="border border-slate-700">
            <td>First Page</td>
            <td>{firstPage}</td>
          </tr>
        }
        {lastPage &&
          <tr className="border border-slate-700">
            <td>Last Page</td>
            <td>{firstPage}</td>
          </tr>
        }
        {pmid &&
          <tr className="border border-slate-700">
            <td>PMID</td>
            <td>{pmid}</td>
          </tr>
        }
        {pmcid &&
          <tr className="border border-slate-700">
            <td>PMCID</td>
            <td>{pmcid}</td>
          </tr>
        }
        {landingPageUrl && 
          <tr className="border border-slate-700">
            <td>Landing Page URL</td>
            <td>{landingPageUrl}</td>
          </tr>
        }
        {pdfUrl &&
          <tr className="border border-slate-700">
            <td>PDF URL</td>
            <td>{pdfUrl}</td>
          </tr>
        }
        {license &&
          <tr className="border border-slate-700">
            <td>License</td>
            <td>{license}</td>
          </tr>
        }
        {version &&
          <tr className="border border-slate-700">
            <td>Version</td>
            <td>{version}</td>
          </tr>
        }
        {anyRepositoryHasFulltext &&
          <tr className="border border-slate-700">
            <td>Any Repository Has Full Text?</td>
            <td>{anyRepositoryHasFulltext}</td>
          </tr>
        }
        </tbody>
      </table>
    </>
  );
}

export default WorkDetails;
