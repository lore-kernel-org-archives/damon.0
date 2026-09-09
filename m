Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698C30FF08
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788927264; cv=none; b=kieAUID+R1st9i8s0Bpe3eJGmyFmSfqDWSZI7BlLreGIR7pUwx9cIItItcmBTODTLhx3mvwGmCwTaSPFSyleXk13rz9DSRZZdffFN0+Y9uVfVTJ6fERBNTu4jzENwdsLbq7pME5PNvI4SDp9NQXFlwaEl3Sv3su+LRkBM2Tfp0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788927264; c=relaxed/simple;
	bh=uDsFVZ1KFcwJHW7ztFG3Dcax2Cr4wrGW2+TMTiVbh+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=coMRAVjb2AaYvIZvB3vhsgpFSpp5P3B0pF5nJC2poqFZzQgL8z8FZXL2JZr8zYqGIDw4pWhATvmjQZoT+1TOXbVQn/A8heg3JEo78+KpKUIicLM98MMhOyEyF4TJ6XPq7xGGPrYVy1LqWtXAmORwZ3BiDGtHpXF4yX13hCwnEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9Eouhp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9Eouhp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C50D1F00A3A;
	Wed,  9 Sep 2026 04:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788927263;
	bh=oQSufRuV/NcGKbHMM0LUApdK/YbYci1ursDhoNwAZXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G9Eouhp2J9wMzFDAc9CnhutByww+Zi/2u7si/wiH7Z+pZSYrP7FF5PmDZsLKWMST+
	 V/Ar3R4zlNtyDcL7w37NL7XYA013l6Oe3IwhbXSpMFBJ8rYMR8879T3C37MywATTME
	 7dGUXkJko0T9TeY0E8chcGqNmmuGiQ2lULCTSa+wWwdSc9S/7IZ/JLe0wss+alK1oL
	 Lj0iaXD6R749vYTOqt7KJc+1TXuerxGMqZcdXGU+AOXTW/3iimn8a68vAD/UypH+zF
	 AhSJCGx9NQZfFV/vfiWo+YRGtLua2zXiuHLv1h9igdffPIHRo+NyGAMzkJ/ezBQSIJ
	 q+QCdBE/9LFNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/core-kunit: handle region split failure
 in filter_out()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909040751.175004-1-sj@kernel.org>
References: <2026090831-operative-attribute-934e@gregkh>
 <20260909040751.175004-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:14:22 +0000
Message-Id: <20260909041423.2C50D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_test_filter_out() test checks if damos_filter_match() of an address
> filter splits the region as expected under a given condition.  But, the
> test continued regardless of the split successes.  As a result, the later
> part of the test could dereference invalid pointers that returned from
> damon_next_region().  Further, it could corrupt memory from
> damon_destroy_region().
>=20
> The consequent user impact (memory corruption) is quite bad.  The
> realistic user impact would be limited, though.  It would affect only test
> run setups.
>=20
> Fix it by exiting early for the number of regions test failure.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260718001442.87129-5-sj@kernel.org
> Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]
> Fixes: 26713c890875 ("mm/damon/core-test: add a unit test for __damos_fil=
ter_out()")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 3423fe70395210e2f0cd795270292f6a27cd57b5)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909040751.1750=
04-1-sj@kernel.org?part=3D1

