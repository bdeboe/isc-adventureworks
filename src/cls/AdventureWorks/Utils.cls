Class AdventureWorks.Utils
{

ClassMethod Setup(repoRoot As %String = "", verbose As %Boolean = 1) As %Status
{
	set sc = $$$OK
	try {
		set separator = $s($$$isWINDOWS:"\",1:"/")
		set:$e(repoRoot,*)'=separator repoRoot=repoRoot_separator

		set sc = ..Download(repoRoot_"data", verbose)
		quit:$$$ISERR(sc)

		do ..RunDDL(repoRoot_"src"_separator_"sql"_separator_"uninstall-dw.sql",, 1, 0)

		set sc = ..RunDDL(repoRoot_"src"_separator_"sql"_separator_"install-dw.sql",,, verbose)
		quit:$$$ISERR(sc)

		// TODO: move into .sql file
		do $system.SQL.Util.SetOption("IdentityInsert", 1)

		set variables("data_dir") = repoRoot_"data"_separator
		set sc = ..RunDDL(repoRoot_"src"_separator_"sql"_separator_"load-dw.sql", .variables,, verbose)
		quit:$$$ISERR(sc)

	} catch (ex) {
		set sc = ex.AsStatus()
        write:verbose !,"Unexpected error: ",$system.Status.GetOneErrorText(sc)
	}
	write:verbose !
	quit sc
}

/// For <var>dir</var>, try "$GH_REPO_ROOT/data"
ClassMethod Download(dir As %String = "/tmp/adventureworks/", verbose As %Boolean = 1) As %Status
{
	set sc = $$$OK
	try {
		
		w:verbose !,"Downloading AdventureWorks data from https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/adventure-works/data-warehouse-install-script/"
				
		set separator = $s($$$isWINDOWS:"\",1:"/")
		if dir="" {
			set dir = $s($$$isWINDOWS:"C:\tmp\adventureworks\", 1:"/tmp/adventureworks/")
		} elseif $e(dir,*)'=separator {
			set dir = dir_separator
		}
		do ##class(%File).CreateDirectoryChain(dir)
		
		set filePtr = ##class(%Stream.FileBinary).%New()
		for tFilename = "DatabaseLog.csv", "DimAccount.csv", "DimCurrency.csv", "DimCustomer.csv", "DimDate.csv", "DimDepartmentGroup.csv", "DimEmployee.csv", "DimGeography.csv", "DimOrganization.csv", "DimProduct.csv", "DimProductCategory.csv", "DimProductSubcategory.csv", "DimPromotion.csv", "DimReseller.csv", "DimSalesReason.csv", "DimSalesTerritory.csv", "DimScenario.csv", "FactAdditionalInternationalProductDescription.csv", "FactCallCenter.csv", "FactCurrencyRate.csv", "FactFinance.csv", "FactInternetSales.csv", "FactInternetSalesReason.csv", "FactProductInventory.csv", "FactResellerSales.csv", "FactSalesQuota.csv", "FactSurveyResponse.csv", "NewFactCurrencyRate.csv", "ProspectiveBuyer.csv" {

			set url = "/microsoft/sql-server-samples/blob/master/samples/databases/adventure-works/data-warehouse-install-script/"_tFilename
							
			set sc = filePtr.LinkToFile(dir_$piece(url,"/",*))
			quit:$$$ISERR(sc)

			if (filePtr.Size) {
				write:verbose !,"File '",$piece(url,"/",*),"' already exists, skipping"
				continue
			}

			set httpRequest = ##class(%Net.HttpRequest).%New()
			set httpRequest.Server = "github.com"
			set httpRequest.Https = 1
			set httpRequest.SSLConfiguration = "ISC.FeatureTracker.SSL.Config"

			w:verbose !,"Downloading ",url," ..."
			set sc = httpRequest.Get(url_"?raw=true")
			quit:$$$ISERR(sc)
			if httpRequest.HttpResponse.StatusCode'=200 {
				w !,"HTTP error code trying to fetch archive: ",httpRequest.HttpResponse.StatusCode
				continue
			}
			
			set sc = filePtr.CopyFromAndSave(httpRequest.HttpResponse.Data)
			quit:$$$ISERR(sc)
			
			w:verbose " (",$normalize(filePtr.FileBinarySize()/1024/1024,2),"MB)"
			
		}
		quit:$$$ISERR(sc)
		
		w:verbose !
		
	} catch (ex) {
		set sc = ex.AsStatus()
        write:verbose !,"Unexpected error: ",$system.Status.GetOneErrorText(sc)
	}
	write:verbose !
	quit sc
}

ClassMethod RunDDL(file As %String, ByRef replace As %String, ignoreErrors As %Boolean = 0, verbose As %Boolean = 1) As %Status
{
    set sc = $$$OK
    try {
        set sep = $s($$$isWINDOWS:"\",1:"/")
        
        write:verbose !,"Running DDL statements from file '",$piece(file,sep,*),"'",!

        set stream = ##class(%Stream.FileCharacter).%New()
        set sc = stream.LinkToFile(file)
        quit:$$$ISERR(sc)

		set sql = ""

        while 'stream.AtEnd {
            set line = $zstrip(stream.ReadLine(),">WC")
            continue:line=""
            continue:$e(line,1,2)="--" // skip comment lines

			// somewhat blunt comment section skipping
			if $zstrip(line,"<WC") = "/*" {
				while 'stream.AtEnd {
					set line = $zstrip(stream.ReadLine(),"<>WC")
					quit:line="*/"
				}
				continue
			}

			// somewhat blunt statement termination
			if $zstrip(line,"<WC") = ";" {

				// replace constants
				set str = ""
				for {
					set str = $order(replace(str),1,rep)
					quit:str=""
					set sql = $replace(sql,"${"_str_"}",rep)
				}

				set sql = $zstrip(sql,"<>WC"), ts = $zh

				write:verbose !!,"  Executing statement:",!,sql
				set rs = ##class(%SQL.Statement).%ExecDirect(,sql)
				set sql = ""
				if rs.%SQLCODE {
					write:verbose !,"    FAILED: ",rs.%Message
					if 'ignoreErrors {
						set sc = $$$ERROR($$$GeneralError, "Error running statement: "_rs.%Message)
						quit
					}
				} else {
					write:verbose !,"    SUCCESS (",$normalize($zh-ts,3),"s)"
					write:verbose&&rs.%ROWCOUNT " - ",rs.%ROWCOUNT," rows affected"
				}
			} else {
				set sql = sql_$c(13,10)_line
			}

        }

		if $zstrip(sql,"<>WC")'="" {
			write:verbose !!,"leftover statement not executed: ",!,sql
		}
        
    } catch (ex) {
        set sc = ex.AsStatus()
        write:verbose !,"Unexpected error: ",$system.Status.GetOneErrorText(sc)
    }
	write:verbose !
    quit sc
}

}
