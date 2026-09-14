Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC4143F8BE
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399077; cv=none; b=qny214Sh4V0U5ksOzCl42LnrXJdiWjso61HL/gRp4H7JFdxpWQjpA8gREjDseCQNGK2viBxz/524vjxOOIaCdM+/p39KU7AC+1W0dIGqckaL6KTFRgQnAF6Z8FaEOrKabs4Pt5xwKZPUfm2Q+VK5HYhOqP+R4kc6RdCKWzJD/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399077; c=relaxed/simple;
	bh=HaPSP3FhN0ENJ8x8ENCifgtqNw1nENwRLJotknI94qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APiih0e0fvPa2lofZPlIOevJG/ydzY50g03dBMqsTFpJDODIc7ARJrViuVXjYlosZNoCYGXu/DiXduGz2GNVtG4RlwvjUHKdATggdTsz/f8JNgpJjVi62TPDsgQxnMwAL65g2Wrq3WVjxbipIO8pWpR/p9vWCw149ctrPZ1rIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8GWTSat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8GWTSat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA79D1F000FF;
	Mon, 14 Sep 2026 15:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789399073;
	bh=D5lz4bKYcHR4mqD3mvDDOKrMSIMWO2qKvJDbMlPyQEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8GWTSatr1MRDQ6OjVitAJLooyCjEs5T3xIBcUWQUnLtqcMt6cvDbpLcaDCUBsOWi
	 Kdun5Lmldz3sI8iYau+28ZdAGfbOWMYMgkgbXplHpf11ymcmydh7qRmBSP5iktzi48
	 poR5iLA4H0F74FkwIF7llFpxVa3e3oZD1DW8LS9ZHWV9ArPp5sBruuFQB8y2pVStKZ
	 4Q2SfvaEvTh8C+Ex/WvmV50AV1tMeBm7+7rEgC/mg2lGX+WgFRSkTBHbRrNrjKs8pU
	 65v/Od10B0CIclA1o5Ph6Vn5unSZWKgd65d0T8yIYPiyfscPndUBPhxAgbbnwt18wu
	 soI1pxyFTSHOQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/8] mm/damon/ops-common: support hugepage_size damon filter matching
Date: Mon, 14 Sep 2026 08:17:44 -0700
Message-ID: <20260914151746.98049-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914145936.B4E2F1F008A2@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 14:59:36 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Memory leak of newly allocated filter when HUGEPAGE_SIZE range is invalid.
> --
> 
> commit 5ea2818b5d3def212dc5a08d79877c1ebf66bd6e
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/ops-common: support hugepage_size damon filter matching
> 
> Update ops-common data attribute filter matching logic to support
> hugepage_size filter type.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 0c98f7e267d07..ecfe99450e5f0 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1838,6 +1848,12 @@ static int damon_commit_filters(struct damon_probe *dst,
> >  		case DAMON_FILTER_TYPE_MEMCG:
> >  			new_filter->memcg_id = src_filter->memcg_id;
> >  			break;
> > +		case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
> > +			if (src_filter->range_max < src_filter->range_min)
> > +				return -EINVAL;
> 
> [Severity: Medium]
> Does this return path leak new_filter?
> 
> When src_filter->range_max < src_filter->range_min evaluates to true
> in damon_commit_filters(), the function returns -EINVAL immediately.
> 
> Since new_filter was already allocated earlier in the loop:
> 
>         new_filter = damon_new_filter(src_filter->type,
>                         src_filter->matching, src_filter->allow);
>         if (!new_filter)
>                 return -ENOMEM;
> 
> and has not yet been added to the probe's filter list or freed before
> this return, does this drop the only reference to it?

Will fix in the next spin.

> 
> > +			new_filter->range_min = src_filter->range_min;
> > +			new_filter->range_max = src_filter->range_max;
> > +			break;
> >  		default:
> >  			break;
> >  		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260914144448.93732-1-sj@kernel.org?part=3
> 


Thanks,
SJ
