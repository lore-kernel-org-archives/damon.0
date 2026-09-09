Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3803B440E
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936459; cv=none; b=Tf7pVtwTWQZGJDJBXaXHX8tQjiI7gpDbvU0DRU+syQ29UnsTjOzK55Qjl2Oz3FjMv5u7sRoT1woSSLBwqaB4tHais7/C8ZW84Mgm2hTerbzGnraztVQaLG/FsxsooIeUxgjhBjUmlFe3mr+McGAEcfhTC84xT7bhIlvfNFZJBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936459; c=relaxed/simple;
	bh=xRA3lnSIREPjSDQ3ps8RGGKz7b90M+HgPgGbNP3mrF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=msTaImy4dRp58NFrMzXo2y02fiex4YHnkFXW3z4l7nFdH+IT4is66f4YcNGu9xLyv8SNzuffj1yl+h3pM37nPQRfTQLeWPrJRG2oe46sNwTn7/YrTNB3C8Fh2CR97KHXXPWBWvL08hWCRswiN2ZwCDLIBIfN/GfvQ2hhbvBPc5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ght1BLmn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ght1BLmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930A71F00A3A;
	Wed,  9 Sep 2026 06:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936455;
	bh=EO1rQd0R0HmIfNqQh7dtmtYijQmWkaP/JTEVauxOVg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ght1BLmnJn7LfW3tJ2VvSBaDKUGKj30jKzj/rwOKnyVl7T5fm6hGdJNTPbGi/s7Dx
	 XtaC5gzCwbGeG725dwpC7mkPTfMGb5faDnww+n5orLo3U8FP+S8DU9yNVQRm/dJflm
	 CvdE+WEw7kQrSd3HHjTBqGmwKy9FU9iJGkVlN+fGF9vWOdfA8rDEZSxBUMu1Y8Nbxl
	 kb055PbKAehIinw5q7oR+uFNPl4S2JTtQy4W3k4IgsvcO5H4bd/9ZcVLf5UIwIpzY7
	 w7Ld9Y3RBXEF8aJI+Q7I1ME5vU4lZcSeUyAL7fzI5qwoEfFo0FYqaKu5R4qca3iMCe
	 3vy0k6jrpSxoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/core-kunit: check region count before
 testing in split_at()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909063631.101832-1-sj@kernel.org>
References: <2026090820-envoy-endanger-c99b@gregkh>
 <20260909063631.101832-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:47:35 +0000
Message-Id: <20260909064735.930A71F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909063631.1018=
32-1-sj@kernel.org?part=3D1

