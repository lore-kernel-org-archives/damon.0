Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09140D598
	for <damon@lists.linux.dev>; Tue, 30 Jun 2026 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782794023; cv=none; b=PpUxJfBJ+BzXN/xanNKIuSEbNBpGG5lWkxYiLK1dreIBYqMP+V/PSPGf9Te5ljXhmTYoV/M4MxYNk6VLmsPx/Z6N7mh39xk7UWDAUXjQNez5oO+dipi+UpWeCuAe7cN62IxC23fUVeGA9tj8p/ZYhhL/4Pbe5zTr2JiImPsh2MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782794023; c=relaxed/simple;
	bh=pJu2EGYyp5g+gAK0UlP8XVo92JSPfXGgbyTMauDFCRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urdSQU/fALbyTc/jJWWhrZvYml+FU6d6BxJTRpigjBWLqX0h0R2H5p/ZqhfG0M/AgMRxVJp2BSQD2ORWx73fHK4vTpL5vnULasaR85wVHn2s90a70EO5fcZirTyURYUz1aZjkgQXAKIUPT+VcrUFxKzDRb9Fl8B8schEtAHrsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5Gzbg0/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5Gzbg0/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D2B1F00A3F;
	Tue, 30 Jun 2026 04:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782794022;
	bh=58WCqWLvgRrFPnA1rWGlugx4tTwj9cHgvpN4LoDSSRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z5Gzbg0/mpJ1EOB3k9A+ZzbzMnGv62SLDMVrBBx1QhVd5RUMegq+4aInYFPHHDk6V
	 lw+kc+kpNzaWO30inaQTSGcQKkuN1MJCTSQ/IDTq/A9fX7BeCN4Q3yQarB8uktbWvQ
	 flOboNCyyIl3CVpaQeNHKVuV5+jwTYpMm3BZ0B99GCdSzt5M3yBAU4G+XmNFsrzeBr
	 vwz9Xst38pqUmPac7xvmsJQSEMjDKK9L1NSkV2Km7L5A39AqvNSlUios9NWESHbajZ
	 RRoCvTyG1BLn7JkTg66hnLM6145MTAHI8Ofgh/S/QiMmMD26FHGSRKMOHeLYS80MGm
	 X9UTGMER020zQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 04/18] mm/damon/core: handle unreset nr_accesses in damon_nr_accesses_mvsum()
Date: Mon, 29 Jun 2026 21:33:32 -0700
Message-ID: <20260630043333.151777-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630042337.2F8CE1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jun 2026 04:23:36 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] damon_nr_accesses_mvsum() incorrectly returns stale data (r->last_nr_accesses) when damon_set_attrs() is called exactly at the end of an aggregation window.
> --
> 
> commit ebe6cc65ba2de465cab83d7ffe913bb9f8304f66
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: handle unreset nr_accesses in damon_nr_accesses_mvsum()
> 
> This commit adds logic to damon_nr_accesses_mvsum() to return
> last_nr_accesses when the remaining window is full. It aims to avoid
> unnecessarily counting unreset nr_accesses when damon_set_attrs() is
> called at the end of an aggregation window.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 94dd425ee4353..df79f4d10bdc3 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -266,6 +266,9 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
> >  			ctx->passed_sample_intervals;
> >  	left_window_bp = mult_frac(left_window, 10000, window_len);
> >  
> > +	if (left_window_bp == 10000)
> > +		return r->last_nr_accesses;
> > +
> 
> [Severity: Medium]
> Will this early return cause the function to return stale data from the 
> previous window instead of freshly accumulated data?
> 
> If damon_set_attrs() is called at the end of an aggregation window,
> damon_update_monitoring_result() processes this with aggregating = false. 
> This intentionally preserves the fully accumulated r->nr_accesses for the
> newly completed window. 
> 
> After damon_set_attrs() pushes ctx->next_aggregation_sis forward, a
> subsequent call to damon_nr_accesses_mvsum() will calculate left_window_bp
> as 10000. 
> 
> Because of this early return, won't it discard the freshly accumulated 
> r->nr_accesses and incorrectly return the older r->last_nr_accesses instead?

Too minor issue to block this series, as I also previously replied [1].  I will
further work on improving this when I get a bandwidth.

[1] https://lore.kernel.org/20260623002313.35582-1-sj@kernel.org


Thanks,
SJ

[...]
