Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC32DC783
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788933939; cv=none; b=CU1oWQQ9V3L8JyNyFXugXRp38IIEFqQVgw7fsXXDnd4A3cUxVW60boRRs2bLXlHK2czaynLY5uMOHpnw2H0hlRxijCmR6Hji+k9y9RcOq00i/+2eJa1/O46A6DfVcCtMRURIV5jQAI5P94U14caRiZf2QEDD6SK6PVig5OKp4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788933939; c=relaxed/simple;
	bh=hpY1RodClVTebYO9SJoIjMx7NzWCIBuEozRlMabXVAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ivzk+z757XeIiJjkjJEIMV+gsGJCC1voo3VykWqHOzQ/+e1r4mlENRb1XZwwuHt9uV8Ey8TVzbGtcflidsVX+sotOY6V2o0nNbANGlBBuIO90kpqIZ1TVOyfOBROPIzB6PTKDzjb9/77v0IIfE5Bz/O5nurv/eGieC/qO5nUqnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/a8xGfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/a8xGfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA2B1F00A3D;
	Wed,  9 Sep 2026 06:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788933938;
	bh=rxuDkJJ0dEDV7zcWV/rcsfuJErl8nI4SyUdUjsQ9rls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G/a8xGfMakt8cI21VOC4D2eBPnH8d7vo8y86rjWVYFeNb25Rp6FMIJqMt58J9Ja1l
	 3aIwPV9Aqr4Ocwlwn3osg/BTfgNeIY0s6OD8piy+apmIW8cYwdGwTgCMGDTXni5q6F
	 54nh4rUZtv1Aag7TVmvOtWySanZm8fFqg0ZrERY+BREhjsw3+K0q2u3o9vzHhGVPso
	 fGqpGZARn0ApWiv+iddOwJCSkFb0LXRNyOANxstWrsFp1Wh2E2Y2atzZAOY0GCfr4G
	 37B/KVXU3benx3QO+A4DD94rvg9E5+x3zLNCVSiGv1IDpXjOb5uRxCd792q+Z4GdL+
	 uFI/eL9PnBhlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/vaddr: drop last same folio access check
 optimization
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909055857.266952-1-sj@kernel.org>
References: <2026090858-excusable-alkaline-da79@gregkh>
 <20260909055857.266952-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:05:38 +0000
Message-Id: <20260909060538.7CA2B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> The optimization can race when multiple kdamonds are running.  Meanwhile,
> the impact of the optimization is quite doubtful.  Just remove it.
>=20
> The user impact of the issue should be quite trivial.  After all, the race
> can happen only when the user intentionally setup DAMON in the way.  Even
> if it happens, it would be rare and only degrade the best-effort
> monitoring results.  No critical consequences like kernel panic or memory
> corruption happen.
>=20
> The race possibility was discovered [1] by Sashiko.
>=20
> Link: https://lore.kernel.org/20260715031002.108504-4-sj@kernel.org
> Link: https://lore.kernel.org/20260621204050.10993-1-sj@kernel.org [1]
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memo=
ry address spaces")
> Signed-off-by: SJ Park <sj@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 831846078caa14b7d00b2ccca8b8fe522afe3204)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909055857.2669=
52-1-sj@kernel.org?part=3D1

