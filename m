Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166826F2BF
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090131; cv=none; b=doHa/viENfEZ3G6L6rnfwgurPteic91pWXUbb5IwL9v/hQpM0JKr5WIIoO60CGp4vFQC7zZz22vN0nY6b6aNBA4AgxjCrkgcP6SxqioKkN0l3a0e+tVtKNNbVEEUvFNhQX9owR93v7p8vQO8WVo20L9iqRwABIbT33TcPmEkKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090131; c=relaxed/simple;
	bh=HPbQmWYmrZO9JX+Gn0KIutDDF31ehI746Zx83g5oEZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOu4FBHEYmd/pfn86u1Pu7mlc1o/bokzr6CTqpcqRcbXkY4fsIWjvbBqZhAa0f7GHX07/xJTR1lxo+RAS28tx+FEBgl2VBY92bU0G5AcY7O+6zMNYpZirVQJmmKju2pPoZLMR4tAkpp9cLT6aS58sgEdi3EsGP4YMqhob3ZycE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fx7clXa7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fx7clXa7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569DA1F000FF;
	Fri, 11 Sep 2026 01:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789090130;
	bh=a9pDlunYhr2P9Uez5b7Ifx75CMO0t3zB84qxP199bTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fx7clXa7/zL8qE8Vwp50K7ZLGn8DZtD9Z6l9LG+h2l/d1slPj+gJX6MXa5Oi50Ecj
	 IjFxoqKhw+2Dh0dPHGo1J0MTD6ltj/mzd1DN9mnet1/V6za5UCFBwdgaohu5jMVhd1
	 UnDIeQYiS4V+EenodXVp3b5FwXL5UqN7k5D4L8VNDbh5zQiyJl1k9SV+xEPXqsEnNK
	 i3m4q4BXkjm+UX095SXJc3lpEsyaXbCtLBy9lnzMZRFMkeOFIC/hOMQYpX2Ts45z2A
	 EguyO1ns1HMed1I7u05GFygLL1/7/hit8rrWrvZZvRM82pqSgOo523hirSv686YHAn
	 61eAdKiWOioVQ==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH v2.2 3/7] mm/damon/core: support probe_hits_wsum damos core filter
Date: Thu, 10 Sep 2026 18:28:42 -0700
Message-ID: <20260911012843.94560-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911012249.541D21F000FF@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 01:22:48 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing test coverage for new DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filter type.
> --
> 
> commit 6772f4f420525d4fa844eff78fb5f202b6550013
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/core: support probe_hits_wsum damos core filter
> 
> Implement probe_hits_wsum DAMOS core filter support in the core layer
> by updating filter operations, argument commits, and match handlers.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index e9630f41e51fe..d9d56f4be1a97 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> [ ... ]
> > @@ -1332,6 +1333,10 @@ static void damos_commit_filter_arg(
> >  	case DAMOS_FILTER_TYPE_HUGEPAGE_SIZE:
> >  		dst->sz_range = src->sz_range;
> >  		break;
> > +	case DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:
> > +		dst->range_min = src->range_min;
> > +		dst->range_max = src->range_max;
> > +		break;
> 
> [Severity: Medium]
> Should this new filter type also be added to the kunit tests in
> mm/damon/tests/core-kunit.h?
> 
> Looking at mm/damon/tests/core-kunit.h, damos_test_commit_filter_for() has a
> switch statement verifying that filter arguments are copied, but it lacks a
> case to verify range_min and range_max for DAMOS_FILTER_TYPE_PROBE_HITS_WSUM.
> 
> Similarly, damos_test_commit_filter() invokes tests for all other filter types
> but seems to omit the newly added DAMOS_FILTER_TYPE_PROBE_HITS_WSUM.
> 
> Could test coverage be added for this new filter type to prevent future
> regressions?

We could improve the test coverage, but it is not a blocker of this patch.  I
will consider adding the test in future.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260911011330.93678-1-sj@kernel.org?part=3


Thanks,
SJ
