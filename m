Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8E63B8124;
	Mon,  7 Sep 2026 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808887; cv=none; b=W0KvU+GGtIxdthfYPu4DeDL9HDEFUw5sZA+wSRs58KNjEPjeTMqvmIZ1G52q4nQ/OeSYBS2QJAly7d8K/7FucDqSxbSRY7/dTCWdNnYaDnARTZyA679Q1+1KqNtl4mckI0NI58jxgzqUfADtDtXUp5NSsTtV2a2405bvM/NlDg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808887; c=relaxed/simple;
	bh=TfbnUxTVBTvUxC8opjtq3AleJUWFFIIQ/muzG8J/sx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRDiJatjE+KBXElv5cuFq7uuFCvPMMEMz89zw8ab8pcKqOByH6igW23ByvNJPItienK6MA5y06YwD5xlfc+pajZ3i1Ag8PLYBFAMqf0B0fiCUQTMRejTVXMuVMPCnP5ObaTV6XeGw+cg9LgFRbxS7zYj7PuvFPKQGdwOGCWZNmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clLvBAlf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clLvBAlf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AA11F00A3A;
	Mon,  7 Sep 2026 19:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788808886;
	bh=qWijxrLdQDsGgRgXmpcSlRR5URwkb33or6eeb1Anop0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=clLvBAlf81C989FzdCRjFL934EgS/wHJBNl+CtcseYiWtQgpMf++IL/wOF4+ku39P
	 vyUSvZfPYATgAjvB53XIv+hkM+V92ZugAuOdDpsvRBHYVTy76SGwPEzc+zHA10kS0J
	 D+XsTik6h6/nYenZDyZKlC0/5k+DZYYeK89sp0bFrAHr5o3M7xbFSQ8z5Gd3lAO7GX
	 Hp2ARovbdCnreU8pCmPR2xg3+8X5UFjARnMzqldN75dQxx2AqgQmLiuXSyC+cbMGoX
	 SmcbflxKJk6vSFvOnfKDBm99+pdqJGb7OBiZXMVE5Wdp6Y0qGcJbyFZ8B44RBADs0I
	 ltr1R/8cjX0zg==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 2/7] mm/damon/core: extend probe_hits_wsum() for moving sum based calculation
Date: Mon,  7 Sep 2026 12:21:18 -0700
Message-ID: <20260907192119.111740-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907171218.101430-3-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Sep 2026 10:12:11 -0700 SJ Park <sj@kernel.org> wrote:

> damon_probe_hits_wsum() is being called only in aggregation time.  In
> future, it could also be used by DAMOS.  In this case, since DAMOS uses
> its own apply_interval, it could be called in sampling time.  Then using
> the not yet fully aggregated probe_hits could result in suboptimum
> outcomes.  Extend damon_probe_hits_wsum() to get the weighted sum based
> on moving sum to prepare the DAMOS usage.
[...]
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -704,7 +704,7 @@ static unsigned int damon_va_apply_probes(struct damon_ctx *ctx,
>  			__damon_va_apply_probes(ctx, mm, r);
>  			if (return_max_wsum)
>  				max_wsum = max(damon_probe_hits_wsum(r, false,
> -							ctx), max_wsum);
> +							false, ctx), max_wsum);
>  		}
>  		if (mm)
>  			mmput(mm);

This cannot be applied on latest mm-new, because this relies on a
not-yet-merged patch series [1].  Hence Sashiko also failed [2] at reviewing
this series.  I will post another RFC after rebasing to latest mm-new.

[1] https://lore.kernel.org/20260906184417.96621-1-sj@kernel.org
[2] https://sashiko.dev/#/patchset/20260907171218.101430-1-sj%40kernel.org


Thanks,
SJ

[...]
