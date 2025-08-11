Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9313E29B216
	for <damon@lists.linux.dev>; Mon, 11 Aug 2025 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754940416; cv=none; b=WRvygoUfi8DaeRDzNAHj2Zqb4lXg8rbTUoEVuzWznUxgOOwbL8l2MNE+9i4hILDcT+4NmakR+uVyCICFwjTU7FFAODPCA0fk0mfnufxSHoTXHy3tkHywjx/5Udidjaw4Z0NS4RDvFvbhdpYvJo/cN6fV836tB5RK8mZ5u2nHllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754940416; c=relaxed/simple;
	bh=aogyUJCssyBoprgBC3ZqkydD1BMLuNs8UotbaRnFx/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNz7MRQ3+3rR7FxB64MiUkLOW0sbnFTpZdrTPl7agK49IMXfEN4oAd8QxvgDvHEKiDqTI+JHZVE5KZQgOyf19qDJjVPLauQYlIb2aCpGzwevu772zcHpjTWNKyUD5o4/IunGT+b9ntJs0YIjTBZMEBF+AFoWNtBzNwZovs2JQ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8U2PnU0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8U2PnU0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF905C4CEED;
	Mon, 11 Aug 2025 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754940416;
	bh=aogyUJCssyBoprgBC3ZqkydD1BMLuNs8UotbaRnFx/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8U2PnU0aUHUufKpJ5zsxQBVQu4uHCsVIWIqtKJct+6TEfpOJ6nGktHdahNaOI+a+
	 1A/AkaEc2rblahwPTDFneNsEPpY4C8HPCN6Oiv0VBOEow0riOQnGOVisrjSpQUBSCg
	 c0dlsBGC2k1FtwFzPgKYAli2PNDGJQ3N/B9H21QOqLw4ITWu1Z8EXnVuT3C+Y4DBKj
	 qvZdbGQOzpim7lXd/xWmp+/cuYW4vGfm5ZVV1z+YN5N5kGil/i74tiDRNF8Db30gg/
	 mYqQe/Ry7R9cZJMKXB+QxdCAUNMvI9MASWiJmRXNLvKc9B+AXtaKrymC8E3QeqrCK8
	 qc3pEdaOuO/qw==
From: SeongJae Park <sj@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/core: do not merge regions when the number of regions is small
Date: Mon, 11 Aug 2025 12:26:52 -0700
Message-Id: <20250811192652.63780-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811074612.89804-1-akinobu.mita@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 11 Aug 2025 16:46:12 +0900 Akinobu Mita <akinobu.mita@gmail.com> wrote:

> This change prevents adaptive region merging when the total number of
> regions is less than the minimum number of regions setting.

I agree having the number of regions lower than min_nr_regions is not a good
user experience.  We actually made a fix of a case where the number be higher
than the max_nr_regions, namely commit 310d6c15e910 ("mm/damon/core: merge
regions aggressively when max_nr_regions is unmet").

But, could you please elaborate when the situation can happen, why it is bad,
and if you see this from a real world?

I can expect this situation can happen when the user increases min_nr_regions
to somewhat higher than current number of regions while DAMON is running, using
runtime commit feature.  And it is bad because anyway it is confusing and could
take time to real expected minimum accuracy until DAMON splits regions to keep
the min_nr_regions?  I have no idea for the last question, though.

Anyway, I think this kind of details would be good to be added to the
changelog of this patch, in the next version.

> 
> Even in such cases, the kdamond_merge_regions() function must proceed by
> setting the upper limit of the region size to zero to prevent any actual
> region merging, since it is responsible for updating the region ages rather
> than just merging regions.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  mm/damon/core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 52a48c9316bc..34f1844094cf 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2247,9 +2247,15 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
>  				  unsigned long sz_limit)
>  {
>  	struct damon_target *t;
> -	unsigned int nr_regions;
> +	unsigned int nr_regions = 0;
>  	unsigned int max_thres;
>  
> +	damon_for_each_target(t, c)
> +		nr_regions += damon_nr_regions(t);
> +
> +	if (nr_regions < c->attrs.min_nr_regions)
> +		sz_limit = 0;
> +

sz_limit is already set based on the current min_nr_regions.  Setting this
smaller may help avoiding a few corner case merges, but ain't really avoid
having number of regions lower than min_nr_regions?

Instead, what about making kdamond_split_regions() repeat splitting in the case
until min_nr_regions is met, like kdamond_merge_regions() does for
max_nr_regions?

>  	max_thres = c->attrs.aggr_interval /
>  		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
>  	do {
> -- 
> 2.43.0


Thanks,
SJ
