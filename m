Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F33D3CEE
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025466; cv=none; b=LyrtZ37cIWR9PJjCUD7UVgIX+egX7dEkcHe1++/sNEaq7H2ubyf9cSqjsCgBfYQhDsfa99j5YdYMhU2JEfe1YnQMhTfvsDt6jOpCQ1m4aRn1O6JNOtGvQh9iEHgCpfQav44Fq76USwKkwlQZWeVeEXY0ZbxxveAwU0W4AxPQ5rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025466; c=relaxed/simple;
	bh=ZAVJNOD+O2RrhCHJ3C2ukaqd7w+XoFEASIxr8w2qf4I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ghrrcqyj5bVfPl4C5APnZfc4oeGLcut/CIwFQ+OzRa4SksEO6RD6SwH5Yf2+Lw72M+tMHp+ydlEUQ/16sBnGc68bPLocqRCzUjtkIFITf9P0FDFNi2WAlY7tOgqlm2/lfgFLiCAX86cSwZSd/C55SWGYdPPP6lv+wEES5gYE5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbLf3OR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbLf3OR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E5A1F00A3E;
	Tue, 18 Aug 2026 03:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787025463;
	bh=xZPXhQxkAuXW1bLUkM4TcjhvLsLR6xjD6sF9qzQE5Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EbLf3OR48ZfPjgbX0WW0SRrTm5Pl61oywP29JjDOUmgnOjXz9ctRWEjJ7m1OFMUgg
	 ivxSGSUFMsjTiAJKCOjGXa0Jmt71Ji2axqXBhrcxpqkXZe1bjYl440V/3xMASyU3gd
	 Tm3ANCzoJAB/jO/AkUE6AjHdiwAusClGAGURynGGxJQC0bLjsoXrjVYaVGlgmQLNFE
	 rz/gvVhhyfxX1zbVDZOszKB+xoWy3ZCjCYm18LOG4V2mBt/44uBgO/rqyPAf0Ph2Sc
	 blPUSS+3A+6huMQLpPkQFPo4mLopfGMFC4rq8cGE1Qykc716yOJWcJFtYRUapEcN/u
	 Ccu/AkSKX5qmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core-kunit: test probe_hits handling at
 region split and merge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Angelov" <jasonangelov@ucla.edu>
Cc: damon@lists.linux.dev
In-Reply-To: <20260818034552.11975-2-jasonangelov@ucla.edu>
References: <20260818034552.11975-1-jasonangelov@ucla.edu>
 <20260818034552.11975-2-jasonangelov@ucla.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 03:57:42 +0000
Message-Id: <20260818035742.F0E5A1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is an inte=
ger overflow in damon_merge_two_regions() when calculating size-weighted av=
erages on 32-bit architectures.
--

--- Patch [1]: [PATCH 1/2] mm/damon/core-kunit: test probe_hits handling at=
 region split and merge ---
commit f275f8ec2d833d0e2eacc7a18ba7c56b04b7e599
Author: Jason Angelov <jasonangelov@ucla.edu>

mm/damon/core-kunit: test probe_hits handling at region split and merge

Extend damon_test_split_at() and damon_test_merge_two() tests to cover
handling of probe_hits and last_probe_hits arrays.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index 4a536d41cdb2d..2db94d49c9bae 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h
[ ... ]
> @@ -204,6 +210,7 @@ static void damon_test_merge_two(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
>  	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
>  	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
> +	KUNIT_EXPECT_EQ(test, r->probe_hits[0], 11);

[Severity: High]
This is a pre-existing issue, but does the size-weighted average logic
tested here overflow on 32-bit architectures?

Looking at mm/damon/core.c:damon_merge_two_regions(), the calculations
multiply values like nr_accesses and probe_hits by the region size in bytes:

mm/damon/core.c:damon_merge_two_regions() {
	...
	l->nr_accesses =3D (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
			(sz_l + sz_r);
	...
	for (i =3D 0; i < DAMON_MAX_PROBES; i++)
		l->probe_hits[i] =3D (l->probe_hits[i] * sz_l + r->probe_hits[i]
				* sz_r) / (sz_l + sz_r);
	...
}

On a 32-bit architecture, unsigned long is 32 bits (max ~4.29GB). If a
region is just 17MB and probe_hits is 255, the multiplication=20
255 * 17,000,000 evaluates to ~4.33GB, which would silently truncate.

Could this wrap-around cause merged regions to inherit drastically incorrect
statistics, potentially misidentifying hot memory as cold and triggering
aggressive paging out of actively used pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818034552.1197=
5-1-jasonangelov@ucla.edu?part=3D1
