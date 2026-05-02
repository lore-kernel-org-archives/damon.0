Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CAE175A6B
	for <damon@lists.linux.dev>; Sat,  2 May 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777686611; cv=none; b=GkrmwfMwnHPlyw7VmdLtjNRz6Mn++3VUZN2CURCXrkGsNVSZkOJFjs74T9hOYe/eLIi/TKFMOSuvo62hUPJW1xCfbfu1JCW6w6Trsy/btTK1KBFfrCGAWHsQthDccvBCYhIUPQ1KmHgx1cAkXW7ImoqWZ/Wb5tWWPff+P58VVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777686611; c=relaxed/simple;
	bh=rPe6fjEB5Un+BHyB7IV4Cr2UiJ04K5ujbROZo62GEHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGEril/shUo6OTtFrvBaAZRI94H34fNtIXbGslnCBDk2kmjzu43UIRmP0yZMP4xHRoEVX50nl1tu0/P/y/0kcrsCDbZjCkG45hRznEi1FQmRMd6uzZK43PiagNyK3O9ytny8qe688tAeJQaBq83KY448+W0IadD++IZZHf2D1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfH8clWk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfH8clWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB57C2BCB4;
	Sat,  2 May 2026 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777686611;
	bh=rPe6fjEB5Un+BHyB7IV4Cr2UiJ04K5ujbROZo62GEHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfH8clWk5sklp2n2fpbs5b+yn7dmvlyza8+/UEv58ctruKGHqD/vI2HrW56ybZQHP
	 0lbgq9O//iPgTfsa/wkfVUx1FiDMfJBiIhn90wVFRRc/M2D4+EkWtZzQqOkFDInngl
	 AMdnnjaos2F4sz4d1mia0JlwYi20mH9raeDajHozzzi3XtOiNEiIAKR7ukzrbqgBik
	 5Ms0VpNViBO7axWccVIa1xA9fgJHdSg26kJS+p9mqJpkDO+TiFzXY5UrGTcfLc54ZV
	 PCeCcbULcyrfrwaBGwbPFW8tf4sh6DOVlEXKxB3PWNRtkujC+G+CNB4JwfRymMw1Ze
	 /g72dEKUXC7yA==
From: SeongJae Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	"Liew Rui Yan" <aethernet65535@gmail.com>,
	damon@lists.linux.dev
Subject: Re: [PATCH v5 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri,  1 May 2026 18:50:07 -0700
Message-ID: <20260502015008.78351-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501021643.9CBAFC2BCB3@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 01 May 2026 02:16:43 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] A Time-of-Check to Time-of-Use (TOCTOU) race condition exists between the validation of `damon_lru_sort_mon_attrs.sample_interval` and its subsequent use, leading to a division-by-zero kernel panic.
> --
> 
> commit 27c4642b5b420a4c1731c9385273b591e05b5b4c
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/lru_sort: validate min_region_size to be power of 2
> 
> This commit adds early validation for the min_region_sz parameter to ensure
> it is a power of 2. It prevents kdamond from incorrectly terminating with
> the maybe_corrupted flag when a user simply sets an invalid addr_unit.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 2eb559d913b62..eca88ed941b32 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -286,6 +286,11 @@ static int damon_lru_sort_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> >  
> > +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> >  	if (!damon_lru_sort_mon_attrs.sample_interval) {
> 
> This isn't a regression introduced by this patch,

So no blocker for this patch.

> but can a time-of-check
> to time-of-use (TOCTOU) race condition happen here?
> 
> Because damon_lru_sort_mon_attrs is exposed as a module parameter, it can
> be modified concurrently. If a user concurrently writes 0 to sample_interval
> immediately after this check passes, the local attrs struct would copy the
> new zero value:
> 
>     attrs = damon_lru_sort_mon_attrs;
> 
> Later in the function, damon_max_nr_accesses(&attrs) evaluates
> attrs.aggr_interval / attrs.sample_interval. Since sample_interval would
> be 0, could this trigger a divide-by-zero exception?

This cannot happen, as previously explained [1] to a similar question.

Seems Sashiko is not using mm-new as the baseline of DAMON patches, and
therefore does not know the fact we now doing this in synchronous manner.

[1] https://lore.kernel.org/20260429054135.91515-1-sj@kernel.org


Thanks,
SJ

[...]
