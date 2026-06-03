Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3D397E66
	for <damon@lists.linux.dev>; Wed,  3 Jun 2026 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452386; cv=none; b=vAWGtFzyjK2Tt1FNuClrOlxcsyQHWTeSWCRPrm6/QU3nqj0Np3X1GDcFagvLTPnXjPj3UnJEyjrU1xwOsxp6KZQyFyk7eGukvoI+lPtikxgK1VdyO+obsDgZEjmwtq1ngO9hTdTIWqbuosYHwavPaZAlleS1tyr/gXEiDCBV3wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452386; c=relaxed/simple;
	bh=s10duW8MIYGZgLQ4YrpZ5MmGajTYGp+W2ESEbAiA4ts=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=S7atJTIXuVgwd14PTx3BLMil1zb3bhXuho6664VJut3n2E4YQ7cuwTyofm4pHyC2ru3tvhPe/RGxQum2x+9EgsDZD2I7IUWD8W/tHslSS2o8+t8TnvpEf3lmouVyvtl6XzWayfuR31oRyt5xfaiataIdmqacQINOdQn46jjEIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GbGhM7hS; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GbGhM7hS"
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780452382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y94GexdbEGEmiOo9phYF+92fMWxZFTUjHe2v5T7NUxE=;
	b=GbGhM7hSBid/iHO6Gf4bpN63/puUnNqFrGB8NtASBvQXxOkioDjX8ktGmJ9sT/gFJa7EYl
	vyVBUvXko3mf+8jW5+Pcf3by8tenNdTXPKpLyUwP/vStrUvUF8xcZMfaQuP0C5HFalEcGn
	Mj6jDaK6tCXWk2j7zBtTZZxENU2uz6g=
Date: Wed, 03 Jun 2026 02:06:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <452fc2b00de0b87e233c2cdcbcdd343bd840ea21@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 0/3] selftests/damon: misc fixes for test bugs
To: "SeongJae Park" <sj@kernel.org>
Cc: "SeongJae Park" <sj@kernel.org>, shuah@kernel.org, damon@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, "Kunwu Chan" <chentao@kylinos.cn>
In-Reply-To: <20260601142802.111592-1-sj@kernel.org>
References: <20260601142802.111592-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

2026=E5=B9=B46=E6=9C=881=E6=97=A5 22:28, "SeongJae Park" <sj@kernel.org m=
ailto:sj@kernel.org?to=3D%22SeongJae%20Park%22%20%3Csj%40kernel.org%3E > =
=E5=86=99=E5=88=B0:


>=20
>=20On Mon, 1 Jun 2026 11:23:11 +0800 Kunwu Chan <kunwu.chan@linux.dev> w=
rote:
>=20
>=20>=20
>=20> From: Kunwu Chan <chentao@kylinos.cn>
> >=20=20
>=20>  This series fixes several bugs in the DAMON selftests. Most are
> >  trivial but cause tests to silently pass when they shouldn't, or
> >  fail prematurely on slow machines.
> >=20=20
>=20>  Patch 1 fixes mutable default arguments in DamonCtx.__init__()
> >  that cause state to leak between test instances.
> >=20=20
>=20>  Patch 2 fixes wrong operator precedence and join TypeError in
> >  damos_tried_regions.py.
> >=20=20
>=20>  Patch 3 fixes several wrong strings that produce dead elif
> >  branches, skipped file existence checks, and broken dict key
> >  lookups.
> >=20=20
>=20>  Based on next-20260529.
> >  base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
> >  ---
> >  Changes in v2:
> >  - Fix From:/Signed-off-by mismatch.
> >  - Add Reviewed-by tags from SeongJae Park.
> >  - Drop the duplicate memcg_path fix.
> >  - Drop the empty aggregation-cycle retry fix pending root-cause
> >  investigation.
> >  - No code change
> >=20
>=20From the next time, please add links to previous versions [1]. For ot=
her
> readers, the v1 of this series is available on the mailing list [2].
>=20
>=20[1] https://docs.kernel.org/process/submitting-patches.html#commentar=
y
> [2] https://lore.kernel.org/20260531085633.48626-1-kunwu.chan@linux.dev
>=20
Hi=20SJ,

Noted, will add the link to previous versions next time.
Thanks for the reminder and for providing the v1 link.

Regards,
Kunwu
> Thanks,
> SJ
>=20
>=20[....]
>
