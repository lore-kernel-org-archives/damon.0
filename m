Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F141D213
	for <damon@lists.linux.dev>; Thu, 23 Jul 2026 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814393; cv=none; b=Ltjl60+0++QWsAsBgir4QOekuZ+XvuOuevOBr8rZfHopkSmb5u42zdTMT3gxSbt6/lkEuOn0UTxdw1We3sN/47k+A41eIywlvmn8cqZAPE42oZ5bMnXIz/5P8yZJN/R3pwoHesVaIJS2y1MuBjY/PWMDKoAPx94aNk5uZbxzz7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814393; c=relaxed/simple;
	bh=YNbgrUXB7WUJvlPOQgGN/MU/mCBw4Olj1E229PLFo7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQFKfFq6Sj810nrLEZkVIJYU6WLUEiQU0T8NdFF0zWbNhpLuK/E1oUeBdahuwi7Zx09NggulJXBCPU5NLcDBf2A9eeIz4p4M53BYeGqjH+/4EgCcoqxwKC9jSy7KUmwAKnSJ84fFTqT6ZRvY99TAd9BMCDwGCzNZqQzah7Srczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmyNMb/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmyNMb/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD17A1F000E9;
	Thu, 23 Jul 2026 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784814392;
	bh=x7H/TJYYWWEa9V3Dq0eNNlN8nZK9tYC/VAA9ZWXag/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmyNMb/eCyZiCXMZ1nQCO5n6UcDZ2cEwOZa54Kze0f0lQhPKAuDt93cVZV6q98Swn
	 DrxYr7v2SyG1tUG9BcOxeggBzG8yM5nOPp5HeNmQ8yijjZLWuDH127m9rWx9mpwXbL
	 KxY8tPX/x4ft7tlMTwtUAD5R6rN9xhqvMf1Ykk0fIxx3vJ5490hkhfMjh/Vvbb5Ezt
	 veh4Tx1UFBtn2NyHGfCYW+/GbttI1kyM222n3GMvUaQDuUN3L3J9fxnRgsedMWrJ8/
	 j67RpjKzZHOu97xPzX771eOb8LBsIbTKqfK2ZyGCJQf0CbX1de5ZYJIqturKNnZ6Mb
	 /BjVeshePhsbA==
From: SJ Park <sj@kernel.org>
To: dayou5941@163.com
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	liyouhong <liyouhong@kylinos.cn>
Subject: Re: [PATCH] mm/damon/ops-common: putback folios on invalid migrate nid
Date: Thu, 23 Jul 2026 06:46:22 -0700
Message-ID: <20260723134622.86926-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260723061246.1878435-1-dayou5941@163.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 23 Jul 2026 14:12:46 +0800 dayou5941@163.com wrote:

> From: liyouhong <liyouhong@kylinos.cn>
> 
> damon_pa_migrate() and damos_va_migrate() isolate folios into a local list
> and then call damon_migrate_pages().  When target_nid is invalid (including
> the scheme default NUMA_NO_NODE / -1), damon_migrate_pages() returns early
> without putting the folios back to the LRU.
> 
> Callers then discard the list head while those folios remain isolated with
> an extra reference taken by folio_isolate_lru().  The pages stay off the
> LRU for as long as the mapping exists (anon active+inactive counts drop
> while RSS does not), and the leftover references can pin the pages after
> the mapping is gone.

Nice catch!

Sounds like this is a very bad bug.  Users can trigger it (though it is
arguably weird or poor setup at least) and the consequence is quote bad:
visible but silent memory exhaustion that cannot be restored without reboot.  I
believe this deserves the hot fixes fast track.  Let me know if I'm missing
something.

> 
> Factor the existing putback loop into damon_putback_folio_list() and use it
> on the invalid-nid path as well, so ignored migration requests still return
> folios to the LRU.

As this is a hotfix, I'd prefer skipping putback loop facotring out part, for
simplicity of backporting.

> 
> Fixes: 7e6c3130690a ("mm/damon/ops-common: ignore migration request to invalid nodes")

Let's Cc: stable@.

> Signed-off-by: liyouhong <liyouhong@kylinos.cn>
> ---
>  mm/damon/ops-common.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index d1842e2b00ef..9a1e8aec5444 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -331,12 +331,22 @@ static unsigned int __damon_migrate_folio_list(
>  	return nr_succeeded;
>  }
>  
> +static void damon_putback_folio_list(struct list_head *folio_list)
> +{
> +	struct folio *folio;
> +
> +	while (!list_empty(folio_list)) {
> +		folio = lru_to_folio(folio_list);
> +		list_del(&folio->lru);
> +		folio_putback_lru(folio);
> +	}
> +}
> +
>  static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
>  						struct pglist_data *pgdat,
>  						int target_nid)
>  {
>  	unsigned int nr_migrated = 0;
> -	struct folio *folio;
>  	LIST_HEAD(ret_folios);
>  	LIST_HEAD(migrate_folios);
>  
> @@ -374,11 +384,7 @@ static unsigned int damon_migrate_folio_list(struct list_head *folio_list,
>  
>  	list_splice(&ret_folios, folio_list);
>  
> -	while (!list_empty(folio_list)) {
> -		folio = lru_to_folio(folio_list);
> -		list_del(&folio->lru);
> -		folio_putback_lru(folio);
> -	}
> +	damon_putback_folio_list(folio_list);

I agree this is good cleanup.  For simple porting to stable@ series, however,
let's not touch this function.

>  
>  	return nr_migrated;
>  }
> @@ -394,8 +400,10 @@ unsigned long damon_migrate_pages(struct list_head *folio_list, int target_nid)
>  		return nr_migrated;
>  
>  	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
> -			!node_state(target_nid, N_MEMORY))
> +	    !node_state(target_nid, N_MEMORY)) {

Please keep the original indentation.

> +		damon_putback_folio_list(folio_list);
>  		return nr_migrated;
> +	}

Let's open-code the putback here.  We could factor out that later.


Thanks,
SJ

[...]
