Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07F28851F
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 04:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785214207; cv=none; b=A2dpqydtwo0xcnidMSUDWLPyofWIR/1m25MGp6mnLswtItyAaY9fKqLmbGnY+0sycntH02w/7mOTL+DN4+P9kf/oKCWQxFedtLM+uuoMUiV0y3toeiu4W2nisfGaKYEsjiAZQhh4s7vgyEufyP9ERMUanzRXp4dF7/TT0KaEejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785214207; c=relaxed/simple;
	bh=fM5/F5XYUfodMGZNFHsNVXLRp8zf0+TVx8qWfCsxcgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zi2YEhvO+kPF+wTRG3TamwJJ0RmvO/Wnw3Xxa0e7/+H3LzKSUqwUoyQIvk2pJhFhZcsUjXOc4owAAkmj6W3HHpGQq15COgL1/xCRJbQ7pFQSDHofNm1bOYmR6ZPV4HDB/UNtztW9TySkBaS6soHPoTcMJ8B9ztPfdmPqFoJN5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VftHM5b4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VftHM5b4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB61F000E9;
	Tue, 28 Jul 2026 04:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785214206;
	bh=ACsh22lpg0K6AyBQ8BXx8thGZa/1FlSDAGNmuoU2IlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VftHM5b4ALMc6aPoTUrXN3AkCi8+2qftBdawLDqU7G25BULIwtWLVf1VS+91lI6/J
	 Amn5bKrlD0i7H6ZRV1DAfdL/llM5Osdhk49g7DfRjw37t1wY/cQp7qtEbp/JLkPwGv
	 zlozuQaWp/xDpyHX7yZg08dzJK4NgDCYMOH9m8Bc9jVpOES+NSQY2AstUIsm+hr5WW
	 j11bcpYOkPVXTkg1eLXsp/A6faLLAbkaFHGV68W8cyHk/Kxj5SvW88dr7AMjC88z7p
	 7x6vl9hKBN8fEb7I96Hj46/hCPUgHSqpZUF07ClVp529hgNIehXp/HcY5Ij91ErpAd
	 nD6XAv8uFs/qg==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
Date: Mon, 27 Jul 2026 21:49:58 -0700
Message-ID: <20260728044959.189419-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728042325.68FB51F000E9@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 28 Jul 2026 04:23:24 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly introduced DAMON_FILTER_TYPE_PGIDLE_UNSET enum is unhandled in the filter matching logic and sysfs interface, leaving the promised functionality completely missing.
> --
> 
> --- Patch [1]: [RFC PATCH v2.2 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET ---
> commit 1ede3c3f87a9caeeb7ad80090cbb84d20b477505
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
>     
> Introduce a new DAMON filter type, pgidle_unset. It will match pages
> that have their PG_Idle flag unset, or the page table accessed bit set.
> 
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 0c8b7ddef9abb..a8bb9ee6979e3 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -742,12 +742,14 @@ struct damon_intervals_goal {
> >  /**
> >   * enum damon_filter_type - Type of &struct damon_filter
> >   *
> > - * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
> > - * @DAMON_FILTER_TYPE_MEMCG:	Specific memcg's pages.
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
> Is the implementation for this new filter type missing from this patch?
> 
> Looking at damon_pa_filter_match() in mm/damon/paddr.c, the switch
> statement evaluating filter types does not appear to handle
> DAMON_FILTER_TYPE_PGIDLE_UNSET. This means it will fall through to the
> default case and fail to implement the promised page matching logic:
> 
> mm/damon/paddr.c:damon_pa_filter_match() {
>     ...
>     switch (filter->type) {
>     case DAMON_FILTER_TYPE_ANON:
>     ...
>     }
> }
> 
> Additionally, it looks like this new filter type is missing from the sysfs 
> name mapping array, damon_sysfs_filter_type_names, in mm/damon/sysfs.c:
> 
> mm/damon/sysfs.c:damon_sysfs_filter_type_names {
>     {
>         .type = DAMON_FILTER_TYPE_ANON,
>         .name = "anon",
>     },
>     ...
> }
> 
> Without this mapping, type_store() will fail with -EINVAL, making it 
> impossible for userspace to configure.
> 
> Will a follow-up patch add the handling logic and sysfs bindings, or should 
> they be included directly in this commit?

A later patch if this series does that.

> 
> >  };
> >  
> >  /**
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260728041242.187380-1-sj@kernel.org?part=1


Thanks,
SJ
