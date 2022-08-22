Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278764D
	for <damon@lists.linux.dev>; Mon, 22 Aug 2022 06:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C60FC433D6;
	Mon, 22 Aug 2022 06:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1661149487;
	bh=FjGBRomwEACT3kJZ1nqAWJj3vryOLMkbXOehoUiRIus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6KrLcKk0kHlmoTuYPxvLdUYBNtcoAhfAj8CpaWwIKHnKbImsUJ0biProtL+pJ972
	 OPzn7LkZjU2WNJJKBKo0yo3xib0/G5ZKxr+QLsJEBLqePM9Av9eY3w3aXK6JHhv6cU
	 D8xpM9DzFGfF17z8WdQoQFOLUjunWSt3HIvfOHjc=
Date: Mon, 22 Aug 2022 08:24:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, badari.pulavarty@intel.com,
	damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/damon/dbgfs: avoid duplicate context directory
 creation
Message-ID: <YwMhLHNfc7Fcdrd5@kroah.com>
References: <20220821180853.2400-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821180853.2400-1-sj@kernel.org>

On Sun, Aug 21, 2022 at 06:08:53PM +0000, SeongJae Park wrote:
> From: Badari Pulavarty <badari.pulavarty@intel.com>
> 
> From: Badari Pulavarty <badari.pulavarty@intel.com>

Twice?

> 
> When user tries to create a DAMON context via the DAMON debugfs
> interface with a name of an already existing context, the context
> directory creation fails but a new context is created and added in the
> internal data structure, due to absence of the directory creation
> success check.  As a result, memory could leak and DAMON cannot be
> turned on.  An example test case is as below:
> 
>     # cd /sys/kernel/debug/damon/
>     # echo "off" >  monitor_on
>     # echo paddr > target_ids
>     # echo "abc" > mk_context
>     # echo "abc" > mk_context
>     # echo $$ > abc/target_ids
>     # echo "on" > monitor_on  <<< fails
> 
> Return value of 'debugfs_create_dir()' is expected to be ignored in
> general, but this is an exceptional case as DAMON feature is depending
> on the debugfs functionality and it has the potential duplicate name
> issue.  This commit therefore fixes the issue by checking the directory
> creation failure and immediately return the error in the case.
> 
> Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Badari Pulavarty <badari.pulavarty@intel.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
> Changes from v2
> (https://lore.kernel.org/damon/20220819171930.16166-1-sj@kernel.org/)
> - Simply check the debugfs_create_dir() return value (Andrew Morton)
> - Put a comment for justifying check of the return value (Greg KH)
> 
> Changes from v1
> (https://lore.kernel.org/damon/DM6PR11MB3978994F75A4104D714437379C679@DM6PR11MB3978.namprd11.prod.outlook.com/)
> - Manually check duplicate entry instead of checking
>   'debugfs_create_dir()' return value
> - Reword commit message and the test case
> 
> Seems Badari have some email client issue, so I (SJ) am making this
> third version of the patch based on Badari's final proposal and
> reposting on behalf of Badari.
> 
>  mm/damon/dbgfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index 51d67c8050dd..3b55a1b219b5 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -818,6 +818,9 @@ static int dbgfs_mk_context(char *name)
>  		return -ENOENT;
>  
>  	new_dir = debugfs_create_dir(name, root);
> +	/* Below check is required for a potential duplicated name case */
> +	if (IS_ERR(new_dir))
> +		return PTR_ERR(new_dir);

Did you just leak the memory allocated above this check?  It's hard to
determine as you are setting global variables.

thanks,

greg k-h
