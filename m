Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57680282F3A
	for <damon@lists.linux.dev>; Fri, 10 Jul 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694109; cv=none; b=ZEsmxMQDvY89xldZFSBfoPx1ZI/KAnsJwt1KiY5rcqdl9CSo1mnX9Qo7rwwdiqUSsxQsSOVypdqeP50R/mEk6BzDiqJxU4+XFcyfv8eJ/cNjtaG+OoOnknYKkSgB3fzRuhs+ldnlKa0GU0mpYMenND3p3D8kTiU1/Ei6L8rTQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694109; c=relaxed/simple;
	bh=hDXc9IF/kMKeQKUXxflMdgtG2OSBi01D+GtyPqFzpps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SF9OOd8QGjXvYnZtXU7zX4vyTyLWspU4CtWeNoUTmtqWaloUj/MbW8iJe2FdJFlxNgKrDwtTZKnNLae9ouBu7c4qUTqilR84wx4HeHRtaQHjta+TQbvdwQBOBeCEd/3fg+C7K9q4ZmaOAXbDoxhhj2Bdb2lHWBhak6D5yvNyZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXolvcVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXolvcVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9671F000E9;
	Fri, 10 Jul 2026 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783694108;
	bh=nMdDdInD2I9X8H7qrYn/L3T6vGFTQhri0wJ4r6a+Edw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IXolvcVJ9JkctyPaOuA/xVpHvSmvTMXH1D53ldZorBJtzTbVn464qX8m5zlk7a4UI
	 Sug2yW3o++kyY5IhSI9kkzkzKC/6t8hbGqCA4JD+/TKKqPRJ58r3HVWv1AEuyVLFJf
	 vgwQkQRXOZzMZt631gG2kSBieEc5DxWUfT4iPRzSXobfuw7OUhXCRYm+v6KJR7+zXC
	 l5ay4qQxzRB5kPEDYpRxXKe8+beq+dKi4Wczlk1naXjfcwIo65E1Q6dolg79YrAwBy
	 vRQeHiW2D5pYgSsr9zxXWP+rkqpI79bAWCexbPkFRjcdLvIGnXT1iTkiXNWb2ed49d
	 wxCtCa/0NYixg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH 04/19] mm/damon/core: ask apply_probe() to return max probe hits weighted sum
Date: Fri, 10 Jul 2026 07:35:00 -0700
Message-ID: <20260710143501.26630-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710140119.C919F1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 14:01:19 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The apply_probes callback fails to calculate and return the maximum probe hits weighted sum, unconditionally returning 0.
> --
> 
> --- Patch [4]: [PATCH 04/19] mm/damon/core: ask apply_probe() to return max probe hits weighted sum ---
> commit bb862935a31b8d93d0e79b24c1d5bb92b5faf39a
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: ask apply_probe() to return max probe hits weighted sum
> 
> This commit updates the DAMON operations protocol to allow the apply_probes
> callback to calculate and return the maximum probe hits weighted sum. It
> modifies the function signature to take a return_max_wsum parameter and 
> updates the existing implementation in damon_pa_apply_probes() to return 
> an unsigned int.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index aee28b05acc6c..e7acd8e610a64 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -649,6 +649,8 @@ enum damon_ops_id {
> >   * @apply_probes should apply the data attribute probes to each region and
> >   * accordingly update the probe hits counter of the region.  It should also
> >   * set &damon_region->sampling_addr of each region if ``set_samples`` is true.
> > + * It should also return maximum probe hits weighted sum of regions if
> > + * ``return_max_wsum`` is true.
> >   * @get_scheme_score should return the priority score of a region for a scheme
> >   * as an integer in [0, &DAMOS_MAX_SCORE].
> >   * @apply_scheme is called from @kdamond when a region for user provided
> 
> [ ... ]
> 
> > diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> > index ff4fcca949660..3eba3564a31fc 100644
> > --- a/mm/damon/paddr.c
> > +++ b/mm/damon/paddr.c
> [ ... ]
> > @@ -166,7 +166,8 @@ static bool damon_pa_filter_pass(phys_addr_t pa, struct folio *folio,
> >  	return pass;
> >  }
> >  
> > -static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
> > +static unsigned int damon_pa_apply_probes(struct damon_ctx *ctx,
> > +		bool set_samples, bool return_max_wsum)
> >  {
> >  	struct damon_target *t;
> >  	struct damon_region *r;
> [ ... ]
> > @@ -194,6 +195,7 @@ static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
> >  				folio_put(folio);
> >  		}
> >  	}
> > +	return 0;
> >  }
> 
> [Severity: Medium]
> Will this unconditionally return 0 even when return_max_wsum is true?
> 
> The struct documentation states the callback should return the maximum probe
> hits weighted sum of regions if return_max_wsum is true. However, the
> implementation in damon_pa_apply_probes() simply returns 0 at the end
> without computing the weighted sum.
> 
> Should the maximum weighted sum calculation be implemented here to fulfill
> the updated protocol?

No issue.  No caller sets return_max_wsum true at this moment.

And a later patch in this series will make the argument be respected before
someone sets it true.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260710134651.18084-1-sj@kernel.org?part=4


Thanks,
SJ
