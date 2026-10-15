Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957C5304C3;
	Thu, 15 Oct 2026 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074360; cv=none; b=AqvYRsrg6lDLwgzmAusGNe4kbH33s/faol1lPjpysuJnpEZZ+L+iYWYk3CKxFlmSpNcIFm27NBJXT+EF00KNVXgIyfHUrf0jxrcGfPY1BMPIlDFJAr6hyaoAguIiKO8tHT6dYNodZFwZJE2ytp7cVfi6Tvq4Hc99RpbtbwGsHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074360; c=relaxed/simple;
	bh=TCnKJL/cmfCg3+qnk6+F/sWRoG4MSvzL+K6GXfYYyBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oa009iiVDA34G8q9SBNEunhEKGD3Mmz8/uxpIuRNNI0m/X6b0/8qLFyBvws+Xd25nqnxDbSCRHtW88550vXV6NX08m8HcqMMi9GL1CpqaVeKjLQ08Ns0pi10nS69wu1V/6WLJ+7I3x5GHvdmze8SZStJUcT+WbEFDhYYnEOoNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifOWUm4c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifOWUm4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58421F000C4;
	Thu, 15 Oct 2026 14:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792074359;
	bh=MK9QpizG4Ez/xmCFB+Kev+kIplhhTdrrGQvFvPcmbYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ifOWUm4c/UtZ6cHt8h+s0NRcM/TO90Uv4HYt4iBWL8yiHHGfbev3In/FHJWhhIyu9
	 HFS8IzLjMm45YjEPU8xUgFseEBAG2L0VWaKnTzuUlzoav3LC4sMZiD7vVGtfiFuSKJ
	 U8r+YNN07yPz5jZKhKrVujrhGEudOIyL7SCCEw2lgl5oCL1MLqCVwR1mDbA2Il6oVX
	 G3KV21ojGD1QYI1f+34SGmQITmpfZNU8dhTZISmkmdkr0TippmeK13a80f/6EwFAYa
	 c2af4nUA2ctsH24L2uPZsus5bqfF2EHejdEnGNZMfCWo3NJ22CPeG+9cGfRaNekvWL
	 RSzMKEk/LBvAg==
From: SJ Park <sj@kernel.org>
To: Suhaas Joshi <suhaas@s-joshi.in>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm/damon/core: Copy only installed probe in damon_split_region_at()
Date: Thu, 15 Oct 2026 07:25:51 -0700
Message-ID: <20261015142552.104856-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261015135801.19326-2-suhaas@s-joshi.in>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 15 Oct 2026 19:27:54 +0530 Suhaas Joshi <suhaas@s-joshi.in> wrote:

> In damon_split_region_at(), we copy the entire probe_hits[] and
> last_probe_hits[] arrays of DAMON_MAX_PROBES size. However it is possible
> that the number of probes installed is less than DAMON_MAX_PROBES, in which
> case one or more iterations is/are redundant. To remedy this, iterate over
> only as many times as the number of installed probes. To do so, accept a
> struct damon_ctx pointer in damon_split_region_at(), and update all
> invocations of the function to pass the new argument.
> 
> Also update damon_test_split_at() and damos_test_filter_out() in
> core-kunit.h to supply a context to function paths that call
> damon_split_region_at().

Looks good to me.  Thank you for this patch.

> 
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
