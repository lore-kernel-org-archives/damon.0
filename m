Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B09219D065
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788730252; cv=none; b=Bjf9VfhA7nCmQqU+aGbsywelsJrRG8Y4K0xJX6Wpb5yRDOGw4yY2PmLRguGFhLl/3hMO+v4DKPKWNy7zLLio95E40L0wBimPtI7B0OtHHE71nXgvkP9IpMTM01u9iLhJRy9ckv++DvBioNKn/ymWluvX8T05hQ0Ehh34ygrimhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788730252; c=relaxed/simple;
	bh=HE2QAdTAwYsCy74yFml9iVdcvLHT33ZOnvtpahGKWCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hkrq4yRQwQUWwrENZxP9hArSwsRmMhF98GUenaUpDC4FwTU2tDYSHMh9isDJuWLTbPy7uxrBi8AT6qOh4hU6JyKsQv+eQu/96gdNAEnK2z4x17yyG/JBJuRG/w6FBEcHbkUFjUO+EjRhoVCO8tFJ6+taSToon/FGKmO24B78kBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvMzlwoz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvMzlwoz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9131F00A3A;
	Sun,  6 Sep 2026 21:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788730250;
	bh=ypI98dhpcpC0z7kFbzLcLBCAbBFwiJnsOn5zME5v8dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VvMzlwozJ3/1IspqrELtls2j5u+w6E1w8d50TqSNOVbf3eajSkUs4jdEwsqSMXS+R
	 JpgJ15L1mGxHHLU/oLfVwQ9Xmyd06SxcjwMIe1cQ7L8fQPVat8rGYI2EQEAunUqmqT
	 VOR8izU3ygxFcG8lDEzwmkh+XXLS51PZDpdtcpA9+pb5ckHGK45iBLOe8xT+7gU1RR
	 eKlDoQc5m3sdUDhCWNETZBA108fgu1hp3HZs1il2knHYkgTMHkqAfa7dslukwOdfZ5
	 oUiIfcqSWS4I/zBcEzQI+LxZ9JxcjPAhkRlN/d4H0nvcXLgfCtKm1qLex8OKObrUSf
	 pOEiu9Ssug1ww==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [RFC PATCH 4/6] mm/damon/sysfs-schemes: setup range_{min,max} for probe_hits_wsum filter
Date: Sun,  6 Sep 2026 14:30:37 -0700
Message-ID: <20260906213038.108731-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260906211617.9ED221F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 06 Sep 2026 21:16:17 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Incorrect union member assignment for PROBE_HITS_WSUM filter type risks silent corruption if struct layout changes.
> --
> 
> commit 67e5bf0750883cfdf7b8857b78d72c17c2de406e
> Author: SJ Park <sj@kernel.org>
> 
> mm/damon/sysfs-schemes: setup range_{min,max} for probe_hits_wsum filter
> 
> This commit extends the DAMON sysfs interface to support probe_hits_wsum
> input. It updates the sysfs input based scheme build logic to set up the
> min/max probe hits weighted sum range provided by the user.
> 
> > diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> > index 4d9147d2a269e..e297a20c0af03 100644
> > --- a/mm/damon/sysfs-schemes.c
> > +++ b/mm/damon/sysfs-schemes.c
> 
> [ ... ]
> 
> > @@ -2844,6 +2847,14 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
> >  			}
> >  			filter->sz_range.min = sysfs_filter->range_min;
> >  			filter->sz_range.max = sysfs_filter->range_max;
> > +		} else if (filter->type = DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
> > +			if (sysfs_filter->range_min >
> > +					sysfs_filter->range_max) {
> > +				damos_destroy_filter(filter);
> > +				return -EINVAL;
> > +			}
> > +			filter->sz_range.min = sysfs_filter->range_min;
> > +			filter->sz_range.max = sysfs_filter->range_max;
> 
> [Severity: Low]
> Is this assigning to the wrong union member? Since the filter type is
> DAMOS_FILTER_TYPE_PROBE_HITS_WSUM, should this be assigning directly to
> filter->range_min and filter->range_max instead of filter->sz_range?
> 
> While struct damon_size_range and the anonymous { unsigned long range_min;
> unsigned long range_max; } struct currently share the exact same memory layout
> in the struct damos_filter union, using sz_range here appears to be a
> copy-paste error from the DAMOS_FILTER_TYPE_HUGEPAGE_SIZE block.
> 
> This seems to bypass the earlier refactoring that explicitly introduced
> the anonymous struct to avoid reusing sz_range for non-size fields. If
> struct damon_size_range is modified in the future, assigning via sz_range
> while the core logic consumes range_min could lead to silent data corruption
> when building a PROBE_HITS_WSUM scheme filter.

Good catch.  I will fix this in the next revision

> 
> >  		}
> >  
> >  		damos_add_filter(scheme, filter);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260906210513.106895-1-sj@kernel.org?part=4
> 


Thanks,
SJ
