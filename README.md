# Agurim on Docker

This package provides a dockerized [Agurim](https://github.com/necoma/agurim) service.

You need to prepare the agurim dataset (or datasets) before using this container. To prepare datasets, please refer the original document of Agurim.

The datasets should be located under the `datasets` directory.  The layout should be like below.

    ./datasets
      dataset1/
        yyyy.agr # yearly data with 24-hour resolution
        yyyymm/  # month dir
          yyyymm.agr # monthly data with 2-hour resolution
          yyyymmdd/  # day dir
            yyyymmdd.agr # daily data with 5-min resolution
            yyyymmdd.HHMMSS.agr # high resolution data
      dataset2/
        yyyy.agr # yearly data with 24-hour resolution
        yyyymm/  # month dir
          yyyymm.agr # monthly data with 2-hour resolution
          yyyymmdd/  # day dir
            yyyymmdd.agr # daily data with 5-min resolution
            yyyymmdd.HHMMSS.agr # high resolution data

If you use multiple datasets, you need to declare the dataset names and default dataset name as environment variables in `docker-compose.yml`.

If you didn't specify any of these environment variables, the default name of the dataset will be `dataset`.
