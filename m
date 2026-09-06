Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EFC215F42
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788729337; cv=none; b=KoHjNPaHBFsmbdwIdAOHizCdy/jf1nVEBQUz1qkqpjlPANJSgwAz+vHu9hcF60e8cOmfdZgAkWeH19OImHVjsRR7B4K9FQ7p9u5jdt1whZ07WnT77pCGTOQgLej9GcFWuXwBs4OUeYch0pFMkJVIvHkZvMFBIa5z2/MwLvZNoC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788729337; c=relaxed/simple;
	bh=D1uz6e7WJuVwjrVE0At4g6nIFgtk7nENevH5Wt04I9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o93Q/Czn5RngMHAQ7uzaAAvVkcuvu9bMVKs1e24l7OJlTS01Ggz4y8p+soKmMmgO0bx7e+TzAfreYJDMwR2mCarasbb6r8q244/MsR/fYZzN6C7MCRObEPfINfCyxEyHZT1M6UzAGv5yF/GAFnKHRxLG8bGmuteJwDV6saNVr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEtmC8Aw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEtmC8Aw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6F11F00A3A;
	Sun,  6 Sep 2026 21:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788729336;
	bh=SdXp/ktv+psq6pMV8d21Ui3vdktxWVl7C/pVGQU4p4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LEtmC8AwzlEIZuPmx50/GL/bNooeMCnZJJzRwKzUv1kWtLXZjf+G4jYDkKLcHwIex
	 hPfOKyHsrxBR1315oplZRiA2sz8oKz5/QxNxsXca9teGsZa2NaxOz2MgSc1A+rZwQ/
	 vtiRjZ3ff46+ZAr4Zwuv1JRB9NJkwBjmaTIpl60wQe3Gf6OLcCmoEqR88Q2sPZiTt9
	 /DNFIm3wlQDnjGzRpAyVCJQQfsmJpOq5NylmABoPiKXQWIwlrBl4sTjGVngwcL51SE
	 /yo9P3AFXrqnVnTd69W9zN8TEYM9AshLVd7lGWAySOeInFbi3mIRa1+/vUR/gN5fP8
	 kgFStdSNpl+zA==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 1/6] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Sun,  6 Sep 2026 14:15:26 -0700
Message-ID: <20260906211528.107629-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906211301.942AB1F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 06 Sep 2026 21:13:01 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Mismatch between kernel-doc comment and the actual struct field name for range_max.
> --
> 
> commit 7d0758e3c3054c52a080a43553753f124a5933b1
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
> 
> Update DAMON kernel API to introduce new DAMOS core filter type,
> PROBE_HITS_WSUM. It adds two type-dependent union fields to damos_filter
> for describing the filtering target weighted sum range.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 871d26adf6ae5..59d57131d8327 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> [ ... ]
> > @@ -434,6 +436,8 @@ enum damos_filter_type {
> >   *		&damon_ctx->adaptive_targets if @type is
> >   *		DAMOS_FILTER_TYPE_TARGET.
> >   * @sz_range:	Size range if @type is DAMOS_FILTER_TYPE_HUGEPAGE_SIZE.
> > + * @range_min:	Minimum value of range arguments.
> > + * @range_mx:	Maximum value of range arguments.
> 
> [Severity: Low]
> This isn't a bug, but there appears to be a typo in the kernel-doc comment
> compared to the actual struct field. Should this be @range_max instead of
> @range_mx to match the struct field defined below?

Good catch.  I will fix this in the next revision.

> 
> >   *
> >   * Before applying the &damos->action to a memory region, DAMOS checks if each
> >   * byte of the region matches to this given condition and avoid applying the
> > @@ -450,6 +454,10 @@ struct damos_filter {
> >  		struct damon_addr_range addr_range;
> >  		int target_idx;
> >  		struct damon_size_range sz_range;
> > +		struct {
> > +			unsigned long range_min;
> > +			unsigned long range_max;
> > +		};
> >  	};
> >  /* private: */
> >  	/* List head for siblings. */
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260906210513.106895-1-sj@kernel.org?part=1


Thanks,
SJ
