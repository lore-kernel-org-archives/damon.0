Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F114F93A6
	for <damon@lists.linux.dev>; Mon, 19 Oct 2026 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417325; cv=none; b=dcd9FUMppkWEv9or+pMukfF6GahZFHV7QBqY1mpHrTtPm3X6z1ZqfZFNVN3kEKecyLVUfyqNCHj1gxbF/0Jv9G19H5SrjMmVkNeJXC3ipL26baev93kc9CmUcFZ3uPBUTsPYS/07ZwfN6AHqrdNa3mKgj37ANpIzCKsmisdKPpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417325; c=relaxed/simple;
	bh=DM3EsX13nPtfScUM6UQ/SC5JIx0WYvza0w3BjZivu8E=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=H9QCs3Mz2n5qSrtPKs0zzFpCORshw5e7I9ioMQF1JP3UsRs90GppG0BteRAFOzmpJvOk29IsCtUcUZDOnyBSowmbwytw/qAXAECz3Px9OUzGS5Gi7YUjVez9f1XYtzvMvZt3qoWoMWVKB4eUyHONJrAiUAreNyZpEbaJiEypb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDHfKalp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDHfKalp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5B21F000C4;
	Mon, 19 Oct 2026 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792417324;
	bh=/VDQm9uqPREk5uSHazeBU9qa81dt/blg2PAeeA3FgrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WDHfKalp/9iwJZZ6E2Er9iQBK5FpyKXjTPiZJzTxvdXLIJAonbTGSaMsNzm8RSNkI
	 /k9bc0XbnSXtZxFHN44Hmz/Cbrr3IPw4+1gENicuV0MBpRHdcwCDWWdOcjL6r1OjAn
	 qDIcasK+Wk1uskmY/bdgPRto1EmNzTQMeVoHo+78/o0z8tcGHucCR07CA3jslNJqi9
	 3u4XkGxS4osq+CDHzB/vdl9bURWWtQGmR4cFuQXWoyV3U9iw8zgKu1s/WRA0F6AaJ/
	 HXi3+vUSegYJMKz3l5bk6uYE/mvEiuIffmtHnyJWjFR3P4vwgUfj/d/Yx/TjH3JYbd
	 niLr++kKV20tw==
Message-ID: <sashiko-outbox-177189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2] mm/damon/core: filter out damos address
 filter-split failed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261019133856.86835-1-sj@kernel.org>
References: <20261019133856.86835-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 13:42:02 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When an address type DAMOS filter is configured, DAMOS tries to split
> the region for the filter range, and apply DAMOS action to the filter-in
> region.  The split operation (damon_split_region_at()) could fail from
> allocation failure under extreme memory pressure.  In the case, DAMOS
> action could be applied more or less than expected, ignoring the address
> filter.
>=20
> The issue only rarely happens under extreme memory pressure.  No crash
> or leak happens.  Occasionally not applying the action to a few regions
> shouldn't be a real problem.  But applying the action to a region that
> the user has excluded via address filter could be a surprise depending
> on the use case.  It is only theoretical.  No such real case is found
> yet.
>=20
> Filter out the entire region if the split is failed.  Update
> damos_filter_match() signature to receive the error from split.  Also
> update kunit tests for the updated signature.
>=20
> The issue was discovered [1] by sashiko.
>=20
> [1] https://lore.kernel.org/20260801203121.117449-1-sj@kernel.org
>=20
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos f=
ilter")
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019133856.8683=
5-1-sj@kernel.org?part=3D1

