Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493E1DE2A5
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782779248; cv=none; b=AuaxClQaLRX6k02GhARNwed3h1eX1VmJS1lC7Y/bhbhH+HSHEod26u+jwPn1B+yDHEyOaOB/vwotCrwRVwPGiccon5z7DvAg4tfZLgLgTr0i4db9WgSbcXLI8HiO1rPNWpMPCdx7gdRgJste0S5p4fB5NaVptweOg0uTAbJesSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782779248; c=relaxed/simple;
	bh=oA0r0HnPZWN0NHnf6824TNd6MXcWMQG5AgYPzk2uVuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGHPeOoMYdu3o1EzNjg2yoIKKhjEi6qWvtZ3ps429Oib7WAe1sTgJ3t9PFegTjWCZ+QcVkHacvbHIPfUFe0/PCbLJGijRXfzsrQCv3Xc9m89l24X7sTvcQ8GQl9rCInRr5KVVrEzs3OkA9UgVX8nGcnJ6pUsT56+gok3d7xVjV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbhTR1zV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbhTR1zV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D14B1F000E9;
	Tue, 30 Jun 2026 00:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782779246;
	bh=b+D1ba12mVzVuMX9LNsqq2tKyBThiVLjOogaVf+wEig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IbhTR1zVCzEDzsKy/F5NNa2p3G9Iwti+Sg4Aavg0VGi25tluOsEWumDU7Gu1zueEu
	 GygGfTgcO0hnzhQnucsizrD6o610tVUQezHzqpxRoCK5oBIySjxWGGLr58DjAF1pZf
	 +cgdfg9sc8TPMutzROxJOb0CavwQdXeBXAMaFGJEIe5QVBQslxyfndsPNlGpCTbrwP
	 YveQ8rLcUdqOpkAuVwgq4mIwmaS4WsZuIy25wlhODCJZxq4ABuqZ5XB9I430bpa6zX
	 vo1Bl3e8bzIGYdbSH/PS8BcWurx8To+iVwbIebc2oP/yAbJsD+pP8BeeViuHJ2mEaQ
	 I8PdvVZCknXlw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v3] samples/damon/mtier: fail early if address range parameters are invalid
Date: Mon, 29 Jun 2026 17:27:18 -0700
Message-ID: <20260630002719.141332-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629150116.1C6EE1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jun 2026 15:01:15 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The sysfs interface allows creating zero-sized regions, leading to a division by zero kernel panic in `damon_merge_two_regions()` when merging adjacent zero-sized regions.
> --
> 
> commit 049fc008d25fe73be336de6b00bf5512c8f6ec71
> Author: Zenghui Yu <yuzenghui@huawei.com>
> 
> samples/damon/mtier: fail early if address range parameters are invalid
> 
> This commit fixes an issue where invalid node address ranges could trigger a
> WARN_ONCE. It prevents zero-sized or negatively-sized regions by adding an
> early failure check if the start address is greater than or equal to the end
> address.
> 
> > diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> > index faaaaa12e6206..e567f4edd80ea 100644
> > --- a/samples/damon/mtier.c
> > +++ b/samples/damon/mtier.c
> [ ... ]
> > @@ -120,6 +120,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx(bool promote)
> >  		addr.end = promote ? node1_end_addr : node0_end_addr;
> >  	}
> >  
> > +	if (addr.start >= addr.end)
> > +		goto free_out;
> > +
> 
> [Severity: High]
> This is a pre-existing issue,

So no blocker of this patch.

> but while you are fixing zero-sized regions
> here, does the DAMON sysfs interface have a similar vulnerability that can
> cause a kernel panic?
> 
> Looking at damon_sysfs_set_regions() in mm/damon/sysfs.c, the bounds check
> only uses strictly greater than instead of greater than or equal to:
> 
>     if (sys_region->ar.start > sys_region->ar.end)
>             goto out;
> 
> If a user configures two identical zero-sized regions via sysfs (e.g.,
> start@96 and end@96), this check passes. Furthermore, the overlap
> check allows consecutive identical zero-sized regions because exact boundary
> matches evaluate to false.
> 
> When DAMON executes damon_merge_regions_of(), it identifies these as
> perfectly adjacent and attempts to merge them in damon_merge_two_regions():
> 
> mm/damon/core.c:damon_merge_two_regions() {
>     ...
>     l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
>             (sz_l + sz_r);
>     ...
> }
> 
> Since both regions are zero-sized, sz_l + sz_r evaluates to 0, which would
> cause a division by zero kernel panic. Should the sysfs interface also be
> updated to use >= to prevent this?

Correct.  And we are working [1] on the fix.

[1] https://lore.kernel.org/20260628165447.86217-1-sj@kernel.org


Thanks,
SJ

[...]
