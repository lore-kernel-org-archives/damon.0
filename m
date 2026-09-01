Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01AE32937A
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223744; cv=none; b=V3IwF4BEUvONP2ToQyCrreLb4Fe0SvIJmVU9bvt7dBuRuaVAI1clttiCYikU1Nr5oe5fpPWqAJO8NnSuFUZ5E8d0XGzAY3eq2073WSAzY8toSIZIMvpultPFI95o8eNifRrVO4y5oKLXcNyH721TWjtWmRqtaHfTUTSwOfDjxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223744; c=relaxed/simple;
	bh=ZDMSnzcOOcIh3qu+KmiybFjWu9bQIoUm4Yf33VdZyHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ho2hYCvHh/g6uZXYYDG1Jf2uWnmfa4+av8WTiWuFvepSu6ghTqw4JQnuQdcwaCDJXINTUZ9jfkNzOvPcd7ShSbEW8d8wyzBU0SZCIk+4JuarcQvDraQVAIchHvJzP3DXWGqKczTREqCzxuQhRnx29WAHvnLvkmLKr9tfd6txsv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB6QBsuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB6QBsuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF671F000E9;
	Tue,  1 Sep 2026 00:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223742;
	bh=l0jCCsZa317VnZCNFTxHnmBES8mrwBjxj9hXdSkjFJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lB6QBsuyfy6HZ5NXrxroUxrUlat18VW8FGlA/jv7fq2CyJm7wsEscGzhfTx7qV/bq
	 HtzeIAHoGO/KyDFzI4fUFeC91CYfPinxxot38FcmXHJhkjPECIjDmqchI7Kx4lyKny
	 ZPbZ2QRKQAhuPLj0QfLYXvQWCXj4tnWqFmvPidjdl70SHvN/gB4Zk1nLkwnrn+BEdE
	 jBcDaa6Wf6JJrsGio2RfNC/++oTfK4YArnFvNSBfUKiTl6Yva+iKJWVCLbSMQ4XS/s
	 tCMocnCkfiLUIz1NUvlJphsEd/iL2p5TuzHlVz/536jcuhfHN6b3fXXtAWw7J3p+HF
	 4+j+BB6L6UqhQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v4 3/3] Docs/mm/damon/design: Document hugepage_mem_bp target metric
Date: Mon, 31 Aug 2026 17:48:54 -0700
Message-ID: <20260901004855.89809-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831183558.F0B4D1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 18:35:58 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Integer overflow in `mult_frac` on 32-bit systems for memory exceeding ~1.75 GB of huge pages, resulting in incorrect DAMOS quota auto-tuning.
> - [Medium] The newly introduced DAMOS quota goal metric 'hugepage_mem_bp' is not tested in the DAMON sysfs selftests.
> --
> 
> commit 59f2c739bce03363ce501965d6708d807908af18
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon: Introduce DAMOS_QUOTA_HUGEPAGE auto tuning
> 
> Introduce DAMOS_QUOTA_HUGEPAGE_MEM_BP auto tuning. Add a new DAMOS quota
> goal metric to measure the amount of huge page consumption to total
> memory consumption ratio.
> 
> Link: https://lore.kernel.org/all/20260715151615.99767-1-sj@kernel.org/
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a16560..9c0e42a1d2cfc 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -3007,6 +3007,22 @@ static unsigned int damos_get_in_active_mem_bp(bool active_ratio)
> >  	return mult_frac(inactive, 10000, total);
> >  }
> >  
> > +static unsigned int damos_hugepage_mem_bp(void)
> > +{
> > +	unsigned long thp, total_pages, free_pages;
> > +
> > +	total_pages = totalram_pages();
> > +	free_pages = global_zone_page_state(NR_FREE_PAGES);
> > +
> > +	if (total_pages <= free_pages)
> > +		return 10000;
> > +
> > +	thp = global_node_page_state(NR_ANON_THPS) +
> > +				global_node_page_state(NR_SHMEM_THPS) +
> > +				global_node_page_state(NR_FILE_THPS);
> > +	return mult_frac(thp, 10000, total_pages - free_pages);
> 
> [Severity: High]
> Does this calculation overflow on 32-bit systems?
> 
> Since thp is an unsigned long, on a 32-bit architecture it is a 32-bit
> integer. If the system has more than ~1.75 GB of huge pages (about 429,496
> pages), the internal multiplication thp * 10000 will exceed 4,294,967,295
> and wrap around.
> 
> This leads to an incorrect value being returned from mult_frac() and results
> in incorrect DAMOS auto-tuning.

Known low priority issue.

> 
> commit a2c5ad81dadcc820e74efd9d73c1f576bbe76457
> Author: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
> 
> mm/damon/sysfs: support hugepage_mem_bp quota goal metric
> 
> DAMOS has a new autotune policy metric: DAMOS_QUOTA_HUGEPAGE_MEM_BP.
> This patch exposes DAMOS_QUOTA_HUGEPAGE_MEM_BP through sysfs.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 32f495a96b17a..d9b81d7b5910e 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> [ ... ]
> > @@ -1269,6 +1269,10 @@ struct damos_sysfs_qgoal_metric_name damos_sysfs_qgoal_metric_names[] = {
> >  		.metric = DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP,
> >  		.name = "node_eligible_mem_bp",
> >  	},
> > +	{
> > +		.metric = DAMOS_QUOTA_HUGEPAGE_MEM_BP,
> > +		.name = "hugepage_mem_bp",
> > +	},
> >  };
> 
> [Severity: Medium]
> Should there be an accompanying update to the selftests for this new sysfs
> metric?
> 
> Currently, the hugepage_mem_bp metric is missing from the tests. For
> example, in tools/testing/selftests/damon/sysfs.sh:test_goal(), the new
> metric is not verified:
> 
> tools/testing/selftests/damon/sysfs.sh:test_goal() {
>     ...
>     ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
>     ensure_write_fail "$fpath" "foo" "invalid input"
>     ...
> }
> 
> Running the sysfs.sh selftest will silently skip testing the new metric
> because it wasn't added to the hardcoded list of valid inputs.

I'm working for it, separately.  No blocker.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260831144732.80910-1-sj@kernel.org?part=3


Thanks,
SJ
