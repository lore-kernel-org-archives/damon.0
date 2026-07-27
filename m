Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E587841A921
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164331; cv=none; b=eFhwc6R1s0jopww54GJBbrzdB5uXgsjV9r4u9C7WfbJUhQ6Z9t8wI8saIMHB+mFk1rydGXZjN1U4GlGtqq+xP9WRmexmW1bQgEd/NH6ugMju83kKyaAurKvYw3uY/wHXtAtrZnfkG1Ou5C2+InsbOiOPnsrS1bXqLuMriIpViEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164331; c=relaxed/simple;
	bh=C+vOqOloj1qSn1aVyuAUQMLOGJwSUNQBE1pXriMrwr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bT98NL7dES4LENKXDFx+aMeHp0pc2Aeba6lWf6hd489NVhS2YJGaD2Di1SQMOqbl2EUUG0SRPspLmCbAXYJdiOm3q2++3WwO+/XaOptFqoCL7X/3LwwklR+Do0XRtkmyNQrDSWwQ0wMVvGMO1CfIPE0OdPV5+YHVQscE/Mq7Ouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWlOwOAi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWlOwOAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF711F000E9;
	Mon, 27 Jul 2026 14:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785164329;
	bh=YP/j+RTp/pdgbTdojs3OGSGPcdPpExZaFBGnIFmT+aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWlOwOAipdY2fuJwpmt3ssCgbDjat7dRanuAwp7p0F28vTpBY1d4DFOAqZWfoYsO/
	 3dvqx3g7iKxPcb8WIehQKOTgobKeXZDq8OwYfn7PJiRzKpFgyL0glNGwNhIYnZdjAG
	 fgC4EtQ98KCrADJJSM5z1s4Rpvh+9xu/3nTFNZdBGvzHjwwmcAib+mYw2UwDebpq4j
	 VDXC2s44HTmELcpOSFTYEpl+JjjTmwoafhBD0gM/9iX0FWhZ84UyLuYnPi7cX2aSnu
	 yD0KzKRFv6/s8HRMmGUqnu5drtKDkZWWUWP7LuyE/5Qvz4sUrHvD+7B/B4FNQjarAT
	 g6L38/1ZUyS1A==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.1 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
Date: Mon, 27 Jul 2026 07:58:41 -0700
Message-ID: <20260727145842.86989-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727144714.7225F1F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 27 Jul 2026 14:47:13 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch introduces `DAMON_FILTER_TYPE_PGIDLE_UNSET` but fails to implement its matching logic or expose it via sysfs.
> --
> 
> --- Patch [1]: [RFC PATCH v2.1 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET ---
> commit 713d89253715d0f67d20248547ddafe132444f89
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
> 
> This commit introduces a new DAMON filter type, pgidle_unset. It is intended
> to match pages that have their PG_Idle flag unset or the page table accessed
> bit set.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 0c8b7ddef9abb..a8bb9ee6979e3 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -742,12 +742,14 @@ struct damon_intervals_goal {
> >  /**
> >   * enum damon_filter_type - Type of &struct damon_filter
> >   *
> > - * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
> > - * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
> > + * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
> > + * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
> > + * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
> >   */
> >  enum damon_filter_type {
> >  	DAMON_FILTER_TYPE_ANON,
> >  	DAMON_FILTER_TYPE_MEMCG,
> > +	DAMON_FILTER_TYPE_PGIDLE_UNSET,
> 
> [Severity: Medium]
> Are the corresponding implementation details for this new filter type missing
> from this patch?
> 
> The commit message states this will match pages that have their PG_Idle flag
> unset, but the new DAMON_FILTER_TYPE_PGIDLE_UNSET variant doesn't appear to
> be handled in the switch block evaluating filter types within
> damon_pa_filter_match() in mm/damon/paddr.c.
> 
> Additionally, should this be exposed to userspace? The new filter type is
> not mapped in damon_sysfs_filter_type_names in mm/damon/sysfs.c, which would
> prevent it from being configured via sysfs.

Later patches of this series do those.

> 
> >  };
> >  
> >  /**
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260727143829.86236-1-sj@kernel.org?part=1


Thanks,
SJ
