interface Props {
  id: number;
  name: string;
  created_at: string;
}

function InvestigationCard({ id, name, created_at }: Props) {
  return (
    <div className="md:flex-row flex-grow-1 basis-full md:basis-1/3">
      <a
        href={`/investigations/${id}`}
        className="h-[calc(100%-1rem)] flex flex-col m-2 items-center bg-white border border-black rounded-xl shadow lg:flex-row flex-grow-1 hover:bg-gray-100"
      >
        <img
          className="object-cover w-full m-4 rounded-t-lg h-96 md:h-auto md:w-48 md:rounded-xl"
          src="src/assets/right.png"
          alt=""
        ></img>
        <div className="flex flex-col justify-between p-4 leading-normal">
          <h5 className="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
            Investigation: {name}
          </h5>
          <p className="mb-3 font-normal text-gray-700 dark:text-gray-400">
            Hey this here is some investigation description text beep beep lorem
            ipsum nice
          </p>
          <p className="mb-3 font-normal text-gray-700 dark:text-gray-400">
            Created at: {created_at}
          </p>
        </div>
      </a>
    </div>
  );
}

export default InvestigationCard;
