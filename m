Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520B52BE5F
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792073264; cv=none; b=R33ubkruz60TLyFxebZMXqD1malkjxiq4BWck24yu6UHm7WHybcXtMOnIMjJKalJ6LMPdHA/GM563m9vB/aKYxc5tC7+RhRWGZD00ZHIWQIF7Gz2p/aSZ7MnunZBZtmbIq++OtN9FgLAsd1PoWpuvAP+yEfQ139AXpiHqngyBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792073264; c=relaxed/simple;
	bh=5xnznWNXpp8pH0IOdYFPU41r/ao1pKFqd/ZPneF1nQw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Cm3aKmGkr/KyVXwJek+uLp7NUhi7GGBoQFTh2SC2bEvBuAyXUzU6C5hMB5yrOgKyEWRUsqQhlSzYbzNPdtU0+aVl45RXChwpHd0jlrMhPD1a5VH7W0h/4EKfro7usKb+4N0tbn8t3HgxiiTn9AQgT2OZMjv5lItsKL5w5BPJ/yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7LF4Tkx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7LF4Tkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6C91F000C4;
	Thu, 15 Oct 2026 14:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792073262;
	bh=5xnznWNXpp8pH0IOdYFPU41r/ao1pKFqd/ZPneF1nQw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7LF4Tkxn6AtET96lGWCf88OywA+wA3a/F3KtimWXKeqE0CSxdgzpS43dDCZ5QNon
	 04Y06dFi8hklQErWmJ6N0dMgEyjMBx/ku+PYroKyNyZBHzqPJJLczqhNQXTp43t6oh
	 YfV9m1Syk87GfASfV+5hhQ20wnRCwJaFEs19thVvQI7khc7XtDVJbq/qRdwHAfjKy9
	 S1c3DIzzcCNv4xAd7ora62x6U6mm/3cbxjBLVPi7E2jt69ebqeExTWpB63YOj7QNbz
	 jNe3ONGu2Rbm+Dr4ehl2WdEpg4N0i7LTJC5Ib09p+66r+aq9asWFb60B6psCmywRF1
	 FTNi7niIJj7pA==
Message-ID: <sashiko-outbox-172949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] mm/damon/core: Use only installed probe in
 damon_merge_two_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suhaas Joshi" <suhaas@s-joshi.in>
Cc: damon@lists.linux.dev
In-Reply-To: <20261015135801.19326-1-suhaas@s-joshi.in>
References: <20261015135533.18761-1-suhaas@s-joshi.in>
 <20261015135801.19326-1-suhaas@s-joshi.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:07:42 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> While merging 2 regions, we iterate over the entire probe_hits[] array,
> whose size is determined by the DAMON_MAX_PROBES macro. However, it is
> possible that we have fewer probes installed than DAMON_MAX_PROBES. In su=
ch
> cases, we end up making redundant iterations. Therefore, to remedy this,
> iterate over the list of installed probes instead of iterating over the
> entire array. For doing this, start accepting a struct damon_ctx in
> damon_merge_two_regions(), and update calling functions to pass this
> argument.
>=20
> Update the damon_test_merge_two() test to use this new signature for
> damon_merge_two_regions() as well.
>=20
> Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015135533.1876=
1-1-suhaas@s-joshi.in?part=3D1

