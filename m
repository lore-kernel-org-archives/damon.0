Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465E3090F5;
	Thu,  2 Apr 2026 15:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143397; cv=none; b=rWuPzByNYfczvlMiSFPo9Kx0U5QOI2+dkOMLFel2x24j9QnEvlJHg1nd6UteI4fcXU9x1VvoKaN8g/6ZTbvzYhXgGPSdrFmM2lIHz7yIuvj7ZsWAQHbWWNjU5G9mzMwq8T/NNWEs93qlq4CYkH2VJ4DfWZz3sSzse6KS0LvKAds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143397; c=relaxed/simple;
	bh=9oVYR4IRaxvDvL0h28oK6fCNi0c0M7sx6EhNv06jmrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5Zb8m9gcjd3Wh8bROtRT8XcH9YfM4ca1t6wPJJrjh/8pAqlEu0klZTE5C41UgjtD9Ru+XN51daGAvvGc/SvPqzuWSrM/cKyYXlvCoWbhTekpFnRgH7cB7rpV5Iv6lBiMnybTDjlb+/6gTW5ogukhzY9jZ2fhYFfN35jMjCDxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeY7Uf2q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeY7Uf2q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729BCC116C6;
	Thu,  2 Apr 2026 15:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775143396;
	bh=9oVYR4IRaxvDvL0h28oK6fCNi0c0M7sx6EhNv06jmrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TeY7Uf2qx87lhQUZWJD1cFm6cVZ0Ib0DKRAsgjQwIUnU82ILe5LlRQN6zj/SGbSTL
	 kOvMfMyIb5u8XnAq8BeVutIpbxMBRPoUzv+aMPpv6n8D0i1U43Oc0Uv01O3qSv8CWo
	 HrJfFo5I2DPalWNuqpGYWgigbw4iGRHQ5K5Uftk8rhxhnvl5BC7aa7+/KrjSZl173q
	 H3AQkVY80Cv08X7DuxmutmA1u1ly1VY1syoQU9SlhnR7j2+wp4qijNSXGMToxNUqRR
	 1pm0VcYUiL0Yf86qDtaHPEec1cUm4sAKz7ebvqPPsyFAXtVhwFnO8yKc4CcNVkLcLi
	 imiqijvjmHCwQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH v2] mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
Date: Thu,  2 Apr 2026 08:23:14 -0700
Message-ID: <20260402152315.75009-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260402134418.74121-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- stable@, as it seems this is not really need to be shared there.

TL; DR: sashiko didn't find any real issue.

Forwarding Sashiko review in a reply form with my inline comments, for doing
detailed discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260402134418.74121-1-sj@kernel.org
> # start of sashiko.dev inline review
> commit f956e734cbf12d26893e0ce6fe09667b1ba0ca51
> Author: SeongJae Park <sj@kernel.org>
> 
> mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
> 
> This commit attempts to fix a memory leak and avoid a use-after-free
> by deferring the deallocation of the damon_ctx object when damon_call()
> fails, cleaning it up on the next invocation instead.
> 
> Link: https://lore.kernel.org/20260401012428.86694-1-sj@kernel.org
> 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > index 30aeb2c207ec3..b1011a7a2f291 100644
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> > @@ -245,6 +245,12 @@ static int damon_stat_start(void)
> >  {
> >  	int err;
> >  
> > +	if (damon_stat_context) {
> > +		if (damon_is_running(damon_stat_context))
> > +			return -EAGAIN;
> > +		damon_destroy_ctx(damon_stat_context);
> > +	}
> > +
> >  	damon_stat_context = damon_stat_build_ctx();
> 
> [ ... ]
> 
> The commit message notes that deallocating damon_stat_context immediately 
> after a damon_call() failure leads to a use-after-free if kdamond is still 
> running. 
> 
> However, it appears the immediate deallocation in the error path was 
> left intact at the end of damon_stat_start():
> 
> 	err = damon_call(damon_stat_context, &call_control);
> 	if (err) {
> 		damon_destroy_ctx(damon_stat_context);
> 		damon_stat_context = NULL;
> 	}
> 	return err;
> 
> Since damon_stat_context is still immediately destroyed and set to NULL 
> when damon_call() fails, does this leave the use-after-free issue 
> unresolved?
> 
> Additionally, because it is set to NULL, the new deferred cleanup logic 
> added at the top of the function will evaluate to false on the next 
> invocation. Should the immediate deallocation block be removed to allow
> the new cleanup logic to handle it?

Seems sashiko is saying so because sashiko applied the patch on one of mm.git
trees that having the v1 of this patch.  I asked Andrew to drop the v1, so
sashiko's claim shouldn't be a real issue.

> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260402134418.74121-1-sj@kernel.org


Thanks,
SJ

[...]
