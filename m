Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F32748C
	for <damon@lists.linux.dev>; Fri, 19 Aug 2022 21:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D9BC433D7;
	Fri, 19 Aug 2022 21:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1660943290;
	bh=6yIJjHS2JZBDcDI1TurkDjj2O3UtwWKh20HdULweR4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=diIKdZLzUlo2DYSfAH2kJuTr8tm9cdXOAq+DtCll6fsyBEXMv3Tne+eoICil/9SmT
	 zXpwvGvq6TITh8Oyt4fo3IIUcjyf6wAxIZf0El6D1GBFq/OdeZrSiN4usL/tC/Zguk
	 rfjHnGw4XKMtUloaM5zqtw02/H+K8N566lER4Ilc=
Date: Fri, 19 Aug 2022 14:08:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: badari.pulavarty@intel.com, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/dbgfs: avoid duplicate context directory
 creation
Message-Id: <20220819140809.1e3929fd8f50bfc32cae31d3@linux-foundation.org>
In-Reply-To: <20220819171930.16166-1-sj@kernel.org>
References: <20220819171930.16166-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Aug 2022 17:19:30 +0000 SeongJae Park <sj@kernel.org> wrote:

> From: Badari Pulavarty <badari.pulavarty@intel.com>
> 
> When user tries to create a DAMON context via the DAMON debugfs
> interface with a name of an already existing context, the context
> directory creation silently fails but the context is added in the
> internal data structure.  As a result, memory could leak and DAMON
> cannot be turned on.  An example test case is as below:
> 
>     # cd /sys/kernel/debug/damon/
>     # echo "off" >  monitor_on
>     # echo paddr > target_ids
>     # echo "abc" > mk_context
>     # echo "abc" > mk_context
>     # echo $$ > abc/target_ids
>     # echo "on" > monitor_on  <<< fails
> 
> This commit fixes the issue by checking if the name already exist and
> immediately returning '-EEXIST' in the case.
> 
> ...
>
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -795,7 +795,7 @@ static void dbgfs_destroy_ctx(struct damon_ctx *ctx)
>   */
>  static int dbgfs_mk_context(char *name)
>  {
> -	struct dentry *root, **new_dirs, *new_dir;
> +	struct dentry *root, **new_dirs, *new_dir, *dir;
>  	struct damon_ctx **new_ctxs, *new_ctx;
>  
>  	if (damon_nr_running_ctxs())
> @@ -817,6 +817,12 @@ static int dbgfs_mk_context(char *name)
>  	if (!root)
>  		return -ENOENT;
>  
> +	dir = debugfs_lookup(name, root);
> +	if (dir) {
> +		dput(dir);
> +		return -EEXIST;
> +	}
> +
>  	new_dir = debugfs_create_dir(name, root);
>  	dbgfs_dirs[dbgfs_nr_ctxs] = new_dir;

It would be simpler (and less racy) to check the debugfs_create_dir()
return value for IS_ERR()?

