Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5154045D5D5
	for <damon@lists.linux.dev>; Mon, 28 Sep 2026 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585631; cv=none; b=f1deC6vY/aXmcTTJeUwgB+BfAbqUik+AQYOMCsLYoB7nhMvWN6eYrXfx4zFKCjYaByEDcAlRoeh9T0I8v+zJskgvbJNLq5so6FQAQ4MR1+NnqTvt/0NuOGq2MOQm+uVziZ+2MvbrkiM2lWvpd9OthQfGTvaeHDQ0a/8uyzsaeCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585631; c=relaxed/simple;
	bh=uH/RkO2eR0c4LGVxfTivT2BQdZ51ZCOwMIXVI7sgMf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e4TLchnmHHRCholCBJNn4YUgZQK2of1fn27mt9S2L6nLPFbl42NyG80CQHl47C12ktNiC2BQ0vYy5y16iX1VPpVh7GE8xFLzncafbLrbuMZsdUCbPw785gclBb4JzcgXr3QGkCf5vzI5eBK7JtF0hbXM++e/OriBNE2sDEww3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYs/0k63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYs/0k63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AA71F000FF;
	Mon, 28 Sep 2026 08:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585629;
	bh=Nr9QcGuOB0nSR23SJAl1k3FLR8djz8s51SqMdQ56DIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SYs/0k63bt40W3MSpM33McXOZdLToLxULDGd/iU4oDnXodjEr4JE+ybYI9bwjbk5h
	 DDuMGY8B6nM48bvK1RrF6DVDC6w2ua2ZOkwKL6eOKvwLD1dLkRLXygUlelggy2nRxq
	 Wa96ur6JkOHpy2zi6fIHiZxrQ/mrz3ZONMUXyanfYH9v4XgcMYTSTBkqMe9vKZb/yY
	 xKkZhHJMnz+RoVd+G5gSXK3CEjmxU3+DKHi20a1jk/Vuc+jRopgZZr6NTMxgbL4yrj
	 nPUODNB0sfWyhEHhDazBAzAZxveR9S3Kau89AFOjNHtlkme4AbT70LJZXWtC9Kl3r4
	 /lTUpziDt2N4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] mm/damon/tests/core-kunit: test the temporal
 tuner's size quota conversion
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260928084816.5575-3-sj@kernel.org>
References: <20260928084816.5575-1-sj@kernel.org>
 <20260928084816.5575-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 08:53:48 +0000
Message-Id: <20260928085349.57AA71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
>=20
> damos_goal_tune_esz_bp_temporal() encodes the size quota in basis
> points, so the conversion is exact only up to ULONG_MAX / 10000.  Pin
> the three sizes around that boundary: the largest one that fits, the
> first one that does not, and ULONG_MAX.
>=20
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928084816.5575=
-1-sj@kernel.org?part=3D2

