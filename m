Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AC6440647
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269382; cv=none; b=gqSfzD+5Stu5ZmLxCmCkHSGoVGQcYY+fT+7ujf+pXJShFXIwlB0I0ILKQvq9nIwi+IBZkklcwSv33I0D8EqzDtwE7LynO7rdmex+w3kZq8zMVGfCJX84cmBmMT8Mvx6f55D44ziyVbKc7YhBYlEST7SzmpYJXjCVfozjJ8jF34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269382; c=relaxed/simple;
	bh=9YSpV8JBddosT8Cv6FTKv08ThgtlS5ez1KfFtWuEU3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=APdYHsy/n8M9jzxAfFiqe/IolQ0VnYQ9ZyHkX0FMdoqUg5gwpVYtmZ6rqqTuHA+rDwNgJKSIQCYR529G6sRlUqVduRCB6+yFFHMrnFv0XtJ0ZLq3U65lbyWv0QkS/ifcUBEXh4EdwOraaBYBvXakYzuk17IyzlX52OR2pDNSQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hu0Ya6SP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hu0Ya6SP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8A91F000E9;
	Tue,  1 Sep 2026 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269380;
	bh=L7xGGpQdEiEE+TbW2bV+tBlFeNC1z2QImWIDxEHwweI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hu0Ya6SPwRW0jVpwCjg9fzFdgsczcBU46sl+4itQzXhnhmCCGdSms9dQa273IYmj/
	 pMBpVgkI9a9NJmg2uVT1wvg+0brmSziPS0+AOpMsnwOLru/C1yH0KWcY7orkHYDGWX
	 LvF7pu1rEVDSEltFvtdcjFzODRlKJNTRLjfJ1EzxaPVmu3gDgiA8HDNZm6RnA5pUMk
	 8OFA1HbS1AkZFAXm/+cDwra/5AMyGbNKNcaU9jnfBm3YA4GAFz2feybCo45GLCBwmV
	 PTojiq3lnbAVLFX6/tXauMtgg7ujQHBq5cpxnpNDWYruDbmLGh9i828Qtm5//yYZZ2
	 +h/sewFmQWsFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] mm/damon/vaddr: respect folio end for DAMOS_STAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131850.98037-5-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
 <20260901131850.98037-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:29:40 +0000
Message-Id: <20260901132940.7D8A91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> For applying DAMOS_STAT action to a region, DAMON virtual address space
> operation set (vaddr) calls walk_page_range[_vma]() for the region.  The
> pmd walk entry function, namely damon_va_stat_pmd_entry(), applies DAMOS
> filters to folios of addresses of the region in the pmd.  It starts from
> the walking address and advances the address by the size of the folio of
> the address until it goes out of the pmd or the region.
>=20
> Let's suppose it is for the first pmd of the region, and the region
> start address is in the middle of a large folio.  Also, the next folios
> are small.  Then, some of the next folios could be skipped.  Fix the
> issue by advancing the address to exactly the start address of the next
> folio.
>=20
> The user impact is that the DAMOS_STAT-based page level monitoring
> results become inaccurate.  Since the page level monitoring is supposed
> to provide relatively high precision, this is definitely a problem.  It
> is arguably not critical since it is only monitoring quality
> degradation.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260514015053.149396-1-sj@kernel.org
>=20
> Fixes: 63f39737d1e3 ("mm/damon/vaddr: support stat-purpose DAMOS filters")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131850.9803=
7-1-sj@kernel.org?part=3D4

