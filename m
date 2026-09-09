Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4C3451AA
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927000; cv=none; b=EaJFBHQ0uM6f56u52Dz1ESkeUpTR7Zr9l53YkBTIdapvEXwhVi3wAwvr2Xw1NKDIJEqSJluZVlY+4MXYf3Xklx/jU3zzMU7ejRQ8yFMLWmt2PvCguIkSoIshirRqfKgDt43uisek8lvUUXqgRRXt6xGMZZoJMAr9Kyx8ix1tgJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927000; c=relaxed/simple;
	bh=YWn65fBZ+v40a+z0LlP3AsGLqzQ5SMN4fdHuYNhn4WI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NTZ3TvFC5z+g8MNeai70+mbMExl8b+zzbeynn+b3cOhUxH+fmu3ZkVuGv9p5rulbIo3IMyCIePGStxQZmEK5ED3V7+CtwactKih4VqLDif/2gLFcXNcah5cSfUYl0PwUS1ZqnP4mV/R47fP0clO2GQorpLMgafuyjIsmD9P8scc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZhOJKmQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZhOJKmQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05501F00A3A;
	Wed,  9 Sep 2026 04:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926999;
	bh=wDSDreLmm/BTLu1icjO+gVvk/5Y4jgIFxI9E+fsO86E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bZhOJKmQlgZIXkXTzee8w050O8H2bgWFfT/+89BtQAuNisEvdH1CKsiETTQDQpdle
	 QId8yYUiF1ZegGXeg0KBeBjGMzXfdrZarzjAAeYck9uLGjqC1tlKzoWDl6OzUd168i
	 UXwALlEbmiFPKvVAqzQbXLj5XHBiatYsIRyBpNsxkoGPTnx40NsNFQ9IUX8c9NRHNX
	 +JAYm0dR7+HfEdU/0ZyW1PGolGO5zxYUb4tSy7WPblmFGYZSPZTyEnZ1DrIRERO+HT
	 SOzYv9TT9hg/CJVk7rBfu34TMynm86mbRX4R0Isb4tthNIgfCZC/OW9PYC3/7SQieY
	 YlfuREJmupQlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] mm/damon/core-kunit: check region count before
 testing in split_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909040237.169081-1-sj@kernel.org>
References: <2026090821-graded-oversold-80b2@gregkh>
 <20260909040237.169081-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:09:58 +0000
Message-Id: <20260909040958.D05501F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_test_split_at() test next region that is assumed to be created by
> damon_split_region_at() invocation.  But the split might fail.  In this
> case, the succeeding test may dereference invalid pointers returned by
> damon_next_region().
>=20
> The invalid pointer may not cause a really bad user impact, because of the
> implementation detail.  It would only read wrong contents in the belonging
> damon_target struct.  Depending on the future change of the offset from
> the link header to the accessing field, this could also be really
> dangerous, though.  Still, the realistic user impact would be limited.  It
> would affect only test run setups.
>=20
> Fix it by testing if the number of regions was also changed as expected
> and exit early for the failure.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260718001442.87129-3-sj@kernel.org
> Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]
> Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 9b18ef3c3aa1ce24176e340061caf15fa2742564)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909040237.1690=
81-1-sj@kernel.org?part=3D1

