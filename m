Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323096;
	b=3sCAXYRLbHWFChk6lGsO4p5NQ+gvBrRsSBQN+rilttyn1t+Kj/ZTu3Q+Rbj+fXeMUrXW
	 hG+vwt9WgLJjRK1VBtt4sbCuyQuHVC12hJ200OM/iQAYe9/mWiAjqAe13uChTRzc91lUE
	 KqyLhtDpZa3jRK6VzWW9avAm4hYuoedVChY13+68AvkFkqRoW2G09xeQxOIN9PayuOAja
	 cH15LWh0Sdr+Ard2p5bkenYecP9TqYnGn7Meo+EWzMS3eZkzI+T7pDrr7cC4ykc1Sgta3
	 fUfgt3IpG2+g1lIctWTQm4bdDiZra/nXbc6H9Jb4AJ+q82dJp0wW/j5TCrk4x7LzuNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323096;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9dEweRwLlWQhzcLy7MeqaPr4Vy5b9M+n3HN4sPq35HA=;
	b=u4ys2eVuKhwWoSNytCniUt4WsRTTowRs+u/9Cx7YX7IppK91EWvqw2LeQhBTQOsWAjfx
	 +lVyMW3uH6m9jFLFEnCg853n2RERbfpFtLNY1JumcR6c+PAAAcp/KRX+9dJmyZQs/qeIy
	 phepXfWwkENJT/QLvPZWPdLk9aaAOV/LvCTejn1IDablf9vN4fYYQ6Z4rVEgcNBd6Vnzu
	 nQ5N05/of+KJI7orPXep38IV+rkvvxKYO4JGjkhjzd1W++HnimhfdpYW6fCpP9/zbYg8c
	 6KaTy3fkNx66mHyLv6kviZq6gsObUPKddfA8/wfCvJ+eZbtMFG39I+62LxFDwkSWB0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV72nbmi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C506960A2600
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV72nbmi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F4B1F0093D;
	Tue, 10 Nov 2026 15:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794323095;
	bh=9dEweRwLlWQhzcLy7MeqaPr4Vy5b9M+n3HN4sPq35HA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RV72nbmiwFo20Qz3z+Q949L45wHtDC7e4PcGVikzEY9WvzdcmxfibfyDsuCwfXqeP
	 Cw8UlNp/dP4ctO4f6wySC5XKaIp3/3o/UB1BH85tnlVzpEi/yATzgCTvBm9yvDNBjB
	 B3W5rDayxNzL2KoYDkQTs6kxfhc8rIcrpmcA/zvVEHwSbIkQy+KzgTmxayusUPR2Wv
	 XBuQ8Gqc7EckMdT9MyOU3WhGFajOUBgUw80+Cu83JyAbL8l29Nj/nTIy7BvHxi6NUj
	 M9mGTcEc4zvH4rub2Z1NkFKEA5uri08Whx7dWCxguQT+gdvzntYfUohjNvxHg8cP2Y
	 AEOqLySHibUtA==
Message-ID: <sashiko-outbox-207224@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y v2] mm/damon/core: move static variable
 last_nr_regions to damon_ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110150218.145605-1-sj@kernel.org>
References: <20261109200803-failed-6.12-26ae50a0901a@kernel.org>
 <20261110150218.145605-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 15:04:55 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> kdamond_split_regions() uses a static variable last_nr_regions, to infer
> if the region boundaries are too stable.  If it looks too stable, it
> does a more aggressive region split because it might be a fake stability
> coming from non-aggressive split.  Because the variable is static, the
> inference can be racy and wrong when multiple kdamonds are running in
> parallel.
>=20
> The user impact is not critical.  No crash, no leak.  DAMON's
> best-effort monitoring accuracy can be degraded when multiple kdamonds
> are used in parallel and the workload has certain access patterns. Still
> it is a bug that is better to fix.
>=20
> Move the variable into the damon_ctx struct to fix the problem.
>=20
> Link: https://lore.kernel.org/20261025164808.152048-3-sj@kernel.org
> Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Closes: https://sashiko.dev/#/bug/linux-eebfcdde-2881-48ef-8df1-e2019d2a4=
7f2
> Cc: Fernand Sieber <sieberf@amazon.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: <stable@vger.kernel.org> # 5.15.x
> (cherry picked from commit 26ae50a0901a44f7d50053f87dc38abd9f9a269c)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110150218.1456=
05-1-sj@kernel.org?part=3D1

