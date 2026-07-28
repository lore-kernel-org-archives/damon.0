Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338124CEEA
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214454; cv=none; b=Aln7WjU41lR8WKgrl7d8YayyRapaSEymRuOvzxF/kaG+pKTBbMmdR7OLzNON9x3ppvcjFaCXVF+AdS6zpQAxkUL5MWwRc8B0A/4Ijgm8HV++TtwuYkTeVaHhhdgWEoHM15AYOT57BMiAy+xgaxplj2GUdIyfL3dOKgpvMmxtIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214454; c=relaxed/simple;
	bh=hSgJmRMa1HnUZ4ii1Zlv3KsCP7PyKIyCSPPo2QAX1zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4hzIYUWvkElebd+YpO4F1VVVGX2C0ls7Cly87ztevRApB6+ViHVplWh9SXEogUdFLepOYn1xFqRLDveahsSKlrzWMYqIJpYXU8VPKB1HRw0cmd8Mk0RimX+M/UlImESPgwRs5e84VneJEVXM7MnrPa02J8BuanpHsyAkQd54yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbxqHyw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbxqHyw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306651F00A3F;
	Tue, 28 Jul 2026 04:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785214453;
	bh=XLKCH1dDpFF9MJV5xKkEMKUtCb7vkSyxSXXBAvKR4cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WbxqHyw+AB7/bShndsHEGDdU7rn5KhGrSNpLPKnB3F8/02AXRjVHmWgP1v6qxFTVZ
	 o5u6BW5Fuu9s+6CGPcDOmz4R7cYYnyMOm1rmF/2v4SoTlqOyHot23eridD3tnS8s8O
	 105N9nK/i8vX/+8ek8osG0UcmZCcUqpz4dF0fY226GinfOz1j0MD1UUDgbKH7mYpBC
	 jGAvIu9VpRb/nhpRo8fDfxsn/o0mPqbTGaTmApzUxNVnA4NYQl8G6D5GMz3tAuHxO9
	 2ICPYxPyQ0bwXgpPOOGi7Xrsqt2xADRvtQk2/4HsFH99A0Ecy7ox4szl+2iLyp1cmu
	 oNb2pFd22WsVQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 05/17] mm/damon/core: introduce damon_prep struct
Date: Mon, 27 Jul 2026 21:54:04 -0700
Message-ID: <20260728045405.189681-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728042518.899B61F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 04:25:18 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The newly introduced `preps` list in `struct damon_probe` is not synchronized during `damon_commit_probes()`.
> - [Medium] Missing public API to remove or destroy individual `damon_prep` instances dynamically.
> --
> 
> --- Patch [5]: [RFC PATCH v2.2 05/17] mm/damon/core: introduce damon_prep struct ---
> commit d7a749334ed0e3303b955b00673d30f87ca5091c
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce damon_prep struct
> 
> Some DAMON probe filter types require preparatory actions to operate
> effectively, such as setting the PG_Idle flag at a specific time. This
> commit introduces a new data type called damon_prep to specify these
> preparation actions for each probe. DAMON will execute the action for
> each region per sampling interval.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index a8bb9ee6979e3..1a8de735f955b 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> 
> [ ... ]
> 
> > @@ -780,6 +801,8 @@ struct damon_filter {
> >  struct damon_probe {
> >  	unsigned int weight;
> >  /* private: */
> > +	/* Preparation actions to apply to each probing memory. */
> > +	struct list_head preps;
> >  	/* Filters for assessing if a given region is for this probe. */
> >  	struct list_head filters;
> >  	/* Siblings list. */
> 
> [Severity: Medium]
> Will this preps list be synchronized when a DAMON context is updated or
> cloned?
> 
> Looking at damon_commit_probes() in mm/damon/core.c, it only seems to copy
> the weight and filters from the source probe to the destination probe:
> 
> mm/damon/core.c:damon_commit_probes() {
>     ...
>     if (src_probe) {
>         dst_probe->weight = src_probe->weight;
>         err = damon_commit_filters(dst_probe, src_probe);
>         if (err)
>             return err;
>     } else {
>         damon_destroy_probe(dst_probe);
>     }
>     ...
> }
> 
> It appears there is no logic to copy the new preps list. Could this leave
> the running context's preparation actions out of sync and silently discard
> configurations when damon_commit_ctx() is called?

A later patch of this series does that.

> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a16560..0b396c2456d05 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> 
> [ ... ]
> 
> > @@ -111,6 +111,28 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
> >  	return err;
> >  }
> >  
> > +struct damon_prep *damon_new_prep(enum damon_prep_action action)
> > +{
> > +	struct damon_prep *prep;
> > +
> > +	prep = kmalloc_obj(*prep);
> > +	if (!prep)
> > +		return NULL;
> > +	prep->action = action;
> > +	INIT_LIST_HEAD(&prep->list);
> > +	return prep;
> > +}
> > +
> > +void damon_add_prep(struct damon_probe *p, struct damon_prep *prep)
> > +{
> > +	list_add_tail(&prep->list, &p->preps);
> > +}
> > +
> > +static void damon_free_prep(struct damon_prep *p)
> > +{
> > +	kfree(p);
> > +}
> 
> [Severity: Medium]
> Should there be a public API to remove or destroy individual damon_prep
> instances dynamically?
> 
> Since damon_add_prep() is provided to dynamically add preparation actions
> to a probe, it seems there might be a need for a corresponding
> damon_destroy_prep() or damon_del_prep(). Without exporting such functions
> and with damon_free_prep() restricted to static scope, is there a way for
> API consumers to dynamically remove or free a prep without destroying the
> entire probe?

Users will be able to do that via damon_destroy_ctx().

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260728041242.187380-1-sj@kernel.org?part=5


Thanks,
SJ
