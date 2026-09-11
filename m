Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A8526F2BF
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090068; cv=none; b=lHA12FnVBcTeqqne4V/unEM/zxBILzqfmMHOitkWwmEOTBuGPtiXpn4YX2bHfrc9+8AviRg3NTA/gEWl1BDWq20f9mLlCuvDsL8zfetmJD+YsepT+0+qBOfijLvi5Mkq3ktMZJnr9eHnUUf+/TRxmU1Xya4BrZDVqt+N1lauBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090068; c=relaxed/simple;
	bh=FRBK20/vP1odeYcqKFlwSuc0/03UOPLqr+hdH/sC1ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saHixNndox2yFS2dIUwpg18rEWFBP6sN/bOMg8ly25OPMAwTSHejN09HOsfZCe3UjkZpaig1eXTg6pf1rFswV+u2BWrVOR7knn6tM8nF89mqJVO8p7LkQWrLvagqQBKOp0Hu9Ya7uFreKgppTRfoiHqL6h1W4WtNYK1t1XpC7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwNxk7mm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwNxk7mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9801F000FF;
	Fri, 11 Sep 2026 01:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789090067;
	bh=UXu+dIbQFcvER6hZ7r+LGSUj7qZxyDZZVFa2SYH00s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DwNxk7mmdKh+A18v2Hp7HOh0VRG8nfDoK7tTlwe6+bX7qEVe0CUXBTYR/aQPfJfXb
	 +4WdGBlxxYyKj0WhpDKWIUg1uCIssBmlwTl/cvkn5sjmXArlp13mQClFdOVyNlFH0Q
	 VJZ7wZ/+y1j7Ezl81k+EoGft6QKZEPYb8Sfrs6Z88fBChpJwsfYanu5mjFWN6aYkhN
	 pH3zdicMY7qsA0lsL5geSr2oIX5I8AD1gmABGW/UgfcUYqdWd+Eu7GinvubzAi6kA+
	 gp6CbHXhO1Oj+SueEykPT/IFhWJmdSIUYEDyxcdfjkbdAmkjBFmDE79lBpf6rZb8Tu
	 tvzybvPh849Uw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 1/7] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Thu, 10 Sep 2026 18:27:38 -0700
Message-ID: <20260911012740.94409-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911012007.0397B1F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 01:20:06 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The kernel-doc update for `enum damos_filter_type` creates ambiguity regarding the handling of `DAMOS_FILTER_TYPE_PROBE_HITS_WSUM`.
> --
> 
> commit 901df9c4ed650529dec43469f4e3c96f3bf07c6f
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
> 
> This commit updates the DAMON kernel API to introduce a new DAMOS core
> filter type, PROBE_HITS_WSUM. It allows API callers to describe the DAMOS
> action target regions based on their probe_hits weighted sum.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 871d26adf6ae5..ef99ff778ae10 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -399,14 +399,15 @@ struct damos_stat {
> >   * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
> >   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
> >   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
> > + * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
> >   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
> >   *
> > - * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
> > - * are handled by the underlying &struct damon_operations as a part of scheme
> > - * action trying, and therefore accounted as 'tried'.  In contrast,
> > - * &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET filters are handled
> > - * by the core layer before trying of the action, and therefore not accounted
> > - * as 'tried'.
> > + * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
> > + * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
> > + * damon_operations as a part of scheme action trying, and therefore accounted
> > + * as 'tried'.  In contrast, &DAMOS_FILTER_TYPE_ADDR and
> > + * &DAMOS_FILTER_TYPE_TARGET filters are handled by the core layer before
> > + * trying of the action, and therefore not accounted as 'tried'.
> 
> [Severity: Low]
> Does this documentation update leave the handling of
> DAMOS_FILTER_TYPE_PROBE_HITS_WSUM ambiguous?
> 
> The first sentence excludes DAMOS_FILTER_TYPE_PROBE_HITS_WSUM from being
> handled by damon_operations, but the second sentence does not add it to the
> list of filters handled by the core layer. 
> 
> Could the second sentence be updated to explicitly mention
> DAMOS_FILTER_TYPE_PROBE_HITS_WSUM so developers reading the kernel-doc for
> enum damos_filter_type know exactly when its evaluation phase occurs?

The documentation could be improved, but no blocker.  I will consider adding a
reference to the design document which is describing the detail in future.

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260911011330.93678-1-sj@kernel.org?part=1


Thanks,
SJ
