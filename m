Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14C42D052;
	Fri, 25 Jul 2025 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472200; cv=none; b=WqsjQsh/POXILJ5jfmpDwx3N2RvEKBzqPvCzZLO0uwDwQj9aoDGIduMXoAuY4WDKLvDDN9ODQi6X7oCxWXDKvPqnRL3QZCcOPTRCjvCJBFQt0AL3CJ8oQUzYYT4Q/ofFinBxJioeveGzB+4fPSTtIHEm9GjMckJXg1/41dSyKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472200; c=relaxed/simple;
	bh=VSgxj2goV+n6GGKzIUMd/swrr83Kq69rPHQxxeyypAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGa2IVxQNPVIKeMGi1jw/7eTj7ByhfB953S2I/ATUioj/iObWD9EtDrGX618N7lCgGXg+Ub3vvrwlez99LWGhCP3ppkGVkIer4uBTmosw8dzCQkrEKdXtZuK3tDGPp/4Uf/pcugCp5YLmZrn5J46CGp4DNaK5dG0IC6MUbj03MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HidX9jYW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HidX9jYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB68CC4CEE7;
	Fri, 25 Jul 2025 19:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753472200;
	bh=VSgxj2goV+n6GGKzIUMd/swrr83Kq69rPHQxxeyypAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HidX9jYW+avyV7QJUSPLcMwX+nCkBSnajdFU9hEHohCxtRVLA3a7JKQh0TBeTnEBD
	 0yBFuQmYzyCxPkpNlp4avKEj3O2XduO6GIvXMT9bGO1pT10wY1DaoBD22NqyQZZ8P0
	 sd7W/laphrp6u7LBDoWV3/JE3Sa9MUPub4WYrNAD5RoNs3ScGt1EWFtMcRvbQzZk26
	 cs9KaJcLIUNSUPqd24wHNAbHltfDOn9nssy122au6D3CaVDzwDkexdpGAju8/ygA/s
	 QUDrAD1gu/yl4OwrCoCFh7vDZEN07IGUdK7/FaAqfd0OTjQHT8LM+LiBPVyx3v5fVj
	 isomO0jzjD/vg==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	akpm@linux-foundation.org,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: Re: [PATCH] mm/damon/vaddr: Skip isolating folios already in destination nid
Date: Fri, 25 Jul 2025 12:36:37 -0700
Message-Id: <20250725193637.49389-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250725163300.4602-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 25 Jul 2025 11:33:00 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> damos_va_migrate_dests_add() determines the node a folio should be in
> based on the struct damos_migrate_dests associated with the migration
> scheme and adds the folio to the linked list corresponding to that node
> so it can be migrated later. Currently, folios are isolated and added to
> the list even if they are already in the node they should be in.
> 
> In using damon weighted interleave more, I've found that the overhead of
> needlessly adding these folios to the migration lists can be quite
> high. The overhead comes from isolating folios and placing them in the
> migration lists inside of damos_va_migrate_dests_add(), as well as the
> cost of handling those folios in damon_migrate_pages(). This patch
> eliminates that overhead by simply avoiding the addition of folios that
> are already in their intended location to the migration list.
[...]
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> Sorry I missed this in the original patchset!

No worry!

Andrew, could we squash this into commit 19c1dc15c859 ("mm/damon/vaddr: use
damos->migrate_dests in migrate_{hot,cold}") on mm-stable?  I think this is
just a simple fixup.

> 
>  mm/damon/vaddr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 7f5dc9c221a0..4404c2ab0583 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -711,6 +711,10 @@ static void damos_va_migrate_dests_add(struct folio *folio,
>  		target -= dests->weight_arr[i];
>  	}
>  
> +	/* If the folio is already in the right node, don't do anything */
> +	if (folio_nid(folio) == dests->node_id_arr[i])
> +		return;
> +
>  isolate:
>  	if (!folio_isolate_lru(folio))
>  		return;
> -- 
> 2.43.5


Thanks,
SJ
