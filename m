Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFBE4A1DF7
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358421; cv=none; b=mmsgKT85Tu5DwZsDInZkKzfhqrJY7OWDwGWS9Yjy5X8jKj/3jEeZKgSkeoNCRYyTIvuVxpbazJ/V9CwrSZq9I7QzyGEWHSDlxzI7nWMFot5Es9g6GLA+RhvdjiuhoRKnszwl4KDGN3Wa0kx04PC87fmHAQfXfjkkRzUWpmk8n+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358421; c=relaxed/simple;
	bh=WhUTmSbGEDzZCJKD7AXKkg17mFoFOatr93drlzvtPZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RD8ihperAFUztzvWd5k4NPS5OCyQgBKyR2+KRgYRFLZ97lk2eSeXk6A/sXI+U6jvYoBoHMxgpD/sDNkcvPM5fLyURpuSP+ahC1ER2SAV+GDqfyz/p7RvsQVOOqi/OgLVH546RwW6LBYyDYe2urTk0OIrggp3DkQAZ1nmMjLMUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDrnhWzl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDrnhWzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575081F00A3A;
	Wed,  2 Sep 2026 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358419;
	bh=WhUTmSbGEDzZCJKD7AXKkg17mFoFOatr93drlzvtPZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hDrnhWzltQTC+FU2NDFRCAoQXhhvw/Dxsz9V4FY9Qz7kJyU1Kh4hHwBU+qLs1geI4
	 ICdR59wlAW+4LBFvxXFB41Kjw8qJQWcFgG1fxnefHBEC1oEJPXGf7SLtyjy6qldee8
	 RLKTyghK3FiowhYT9+vCUy8sl1mKrqAJ/GewPypLvNWkTnx+QmqMe7TXp2AWzIcTyg
	 mi545JS/t8sFF1leNNt+MORj5ZQ2h6ClYYdukWRICesuolih6ghFMmtCE4fa7GzMhr
	 wFL3G5l3uTi4PN42A/CkHsX+sYEAHIMllrWFnqxWwu2elhUHNXXsS4BUE7Wy8LYUqX
	 IfI3c0RTPo/pg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] selftests/damon/sysfs.py: extend commit assertion
 function for probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902140313.85983-6-sj@kernel.org>
References: <20260902140313.85983-1-sj@kernel.org>
 <20260902140313.85983-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:13:38 +0000
Message-Id: <20260902141339.575081F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend DAMON sysfs testing commit assertion helper function to check
> probes too.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902140313.8598=
3-1-sj@kernel.org?part=3D5

