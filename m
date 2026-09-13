Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F34B21D00A
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320910; cv=none; b=u6AMzYOR5XQsUWrQRQSMTxNFRi4PJUOHaW3jJuaYn6pxjad6wCmaoM5HSacCrQaso5u0pSNmvaDubbhuhazqVzQoQDkqrFCNMlqalj8jOsdRcGCCx1DIpfJjHKZJkkVJIR7sXdJRL8YHU9EsJE3p5w4E0wWwiZwIKSp9JS93CqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320910; c=relaxed/simple;
	bh=j0WSq3IrLbcqhjMXR8QSqQ7QHEmLvSO5rqKhbIkfdmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+ukVmEQwi6rtn7BECII9/4K1WwvEzXAuboJUM+CwkOrQjXwdvQNKhlz/TV5slb9+YfefxtDrcW85iTPy2XkcQdIm0ht9ASM0xLvZhhSixnLuxP37XKyDQABaABBRaT/qNOlqaCv06HgVKvpuPzK01HZqytgyH9uRihmrCyf/cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBc7onGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBc7onGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9C41F000FF;
	Sun, 13 Sep 2026 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320908;
	bh=bUE7DjexKoJlaKHBQ12XIunif0w99x3iteiTg4SFf0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nBc7onGMTN9IHw/Nt0RJTNYRp8wTG1kF4Eu61FuFj5icyWw9AgRUfpo1ZWNdHCGAg
	 j5DxW/vCXZfl8DW+WNBISuXgJrW6mfnTsZZwOxBp06zuEHCR81MRGVkEhaaHT72dPF
	 j/Cx1GhqHbF4HunQTI4DPulLjwrHTCSj07UO6DcaperWPaPbQKorVyp/ku6Ii1xmCS
	 pxP60Arzz5ENgpf58trtiD7AEycV/CT4dgX5fmoUqHksOBRjSaGAy+Xf2XeQAxjd1V
	 aAlKw0G1Py3cb38Nm+7wp10cGsAnnKJO9hD6xsMRY/iPCY1/qVOH2QEXO2cs3HMdfv
	 h0tZ4h3V+vdaw==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 3/8] mm/damon/ops-common: support hugepage_size damon filter matching
Date: Sun, 13 Sep 2026 10:35:00 -0700
Message-ID: <20260913173502.104385-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913172442.EBF911F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 17:24:42 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] damon_commit_filters() leaves range_min and range_max uninitialized for appended hugepage_size filters.
> --
> 
> commit 377608c283881250a794879309e80b931825b0d3
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/ops-common: support hugepage_size damon filter matching
> 
> Update ops-common data attribute filter matching logic to support
> hugepage_size filter type.
> 
> > diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> > index c36cc39cd2c70..77366f42b3e5b 100644
> > --- a/mm/damon/ops-common.c
> > +++ b/mm/damon/ops-common.c
> 
> [ ... ]
> 
> > @@ -558,6 +559,15 @@ bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio)
> >  			matched = filter->memcg_id == mem_cgroup_id(memcg);
> >  		rcu_read_unlock();
> >  		break;
> > +	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> > +		if (!folio) {
> > +			matched = false;
> > +			break;
> > +		}
> > +		folio_sz = folio_size(folio);
> > +		matched = filter->range_min <= folio_sz &&
> > +			folio_sz <= filter->range_max;
> > +		break;
> 
> [Severity: High]
> Does this new filter type need to be explicitly copied when a newly appended
> filter is committed?
> 
> When userspace adds a new filter to an existing DAMON probe via sysfs,
> damon_commit_filters() in mm/damon/core.c invokes damon_new_filter() which
> allocates memory without zeroing it. The attributes are then copied in a
> switch block:
> 
> mm/damon/core.c:damon_commit_filters() {
> 	...
> 	new_filter = damon_new_filter(src_filter->type,
> 			src_filter->matching, src_filter->allow);
> 	if (!new_filter)
> 		return -ENOMEM;
> 	switch (src_filter->type) {
> 	case DAMON_FILTER_TYPE_MEMCG:
> 		new_filter->memcg_id = src_filter->memcg_id;
> 		break;
> 	default:
> 		break;
> 	}
> 	damon_add_filter(dst, new_filter);
> 	...
> }
> 
> Because DAMON_FILTER_TYPE_HUGEPAGE_SIZE is missing from this switch block,
> range_min and range_max will be left uninitialized for appended filters. This
> could result in the filtering logic using garbage memory values.
> 
> Should DAMON_FILTER_TYPE_HUGEPAGE_SIZE be added to this switch statement
> so the range boundaries are properly copied to the new filter?

No issue.  DAMON sysfs is not allowing hugepage_size probe filter at this
moment.  Later, it will add the support with proper range setup.

> 
> >  	default:
> >  		break;
> >  	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260913171133.102366-1-sj@kernel.org?part=3


Thanks,
SJ
