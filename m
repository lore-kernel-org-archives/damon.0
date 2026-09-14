Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D1451071
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397646; cv=none; b=Cgq3tbpCLAL7Y2uo15JyiMUp3J8ILK0bgXhU4gkX3ODJ+h2KN4+P+Wc+xd7IiGEpdqUGKadj38zpRTtG0Eyo/6KKAzyC/rqROq3z9/wc54biLsHusWIokB5sWfPeXjaQBJAgke3XwHJNMVNZ3dnO7RlAtND/HAL9K8SbccMBStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397646; c=relaxed/simple;
	bh=9YBxVcXJIFKPUJ8B+ojNAXIfRhNZLZSyxWlj3NkDTJE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m1aakoBWC/VAB08rskqIhtUovQlcZ2gRFhLBKIBmhAuSSWgodXykPGMZ7o72SRqgC0UQpJpBMdql4L+IPuICJIE7n63TYE9ltD3BryHHkrmEkLpOaqUVmD5GZ5qKsBNLnMu1sbKyMtJZ4XLqu+Hu8f+mtS6dlX8aV3ans8prdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkwnTyMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkwnTyMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC851F000FF;
	Mon, 14 Sep 2026 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397644;
	bh=x9rYk9hKU+jdKeFYzD07Z6imq62TQGbMdq8zx0JFLd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MkwnTyMArfxsDR8lvTVK5GCvMdGvdocCs522P9gXXDQfAYK7N+l4heNdtA4AeVf96
	 +A/3B9112WWR4nuumaJC/MK9ghzFMrN26yvmK/WTQr5l65562PtPDbi1QaHy5JntfX
	 iTaADykXF3CEG11EUL/HRLUFcnVGrKqfTYFTJvTb+ialkftVsudQZjBTH8DcmQxgvQ
	 uDK3fHQv8BGRM+DDDE2vf5jlrHv4kpfRXOWIPgx2xGe8uQTB58+BwefA5UaWr0msBk
	 daCOL3TR35lQuau1br6BegvYI3FYSl7YW9vhBuD4GK6Ja6t7Mz77S1GTUE+Te4yXqf
	 XQT3Hft6+Y1hw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 5/8] mm/damon/sysfs: support hugepage_size probe
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914144448.93732-6-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
 <20260914144448.93732-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:54:03 +0000
Message-Id: <20260914145404.2BC851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing range validation for hugepage_size filters in sysfs allows=
 triggering a memory leak in the DAMON core.
--

commit 2e8e2509774f21f3f602056d79fd21880b487fde
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: support hugepage_size probe filter

Extend DAMON sysfs interface to support hugepage_size probe filter. Allows
hugepage_size user string input to the filter type file and passes the size
range argument via min/max files to the DAMON core.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 8e8d89b8ed981..43519afb9eb7f 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
[ ... ]
> @@ -2273,6 +2277,9 @@ static int damon_sysfs_set_filters(struct damon_pro=
be *probe,
>  				damon_destroy_filter(filter);
>  				return err;
>  			}
> +		} else if (filter->type =3D=3D DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
> +			filter->range_min =3D sys_filter->range_min;
> +			filter->range_max =3D sys_filter->range_max;
>  		}
>  		damon_add_filter(probe, filter);
>  	}

[Severity: High]
Does this code need validation to ensure sys_filter->range_min <=3D
sys_filter->range_max before passing the values to the DAMON core?

If a local user configures a filter with a minimum value greater than the
maximum value, this unvalidated input will reach damon_commit_filters() in
mm/damon/core.c.

In damon_commit_filters(), the core detects the invalid range but returns
-EINVAL directly:

mm/damon/core.c:damon_commit_filters() {
	...
	case DAMON_FILTER_TYPE_HUGEPAGE_SIZE:
		if (src_filter->range_max < src_filter->range_min)
			return -EINVAL;
		new_filter->range_min =3D src_filter->range_min;
		new_filter->range_max =3D src_filter->range_max;
		break;
	...
}

Returning directly bypasses damon_destroy_filter(), which leaves the newly
allocated new_filter orphaned. Because a local user with sysfs access can
repeatedly trigger this by writing invalid ranges and committing the state,
could this lead to a memory leak and potential memory exhaustion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914144448.9373=
2-1-sj@kernel.org?part=3D5
