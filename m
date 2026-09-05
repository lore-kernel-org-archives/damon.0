Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64F3BB124
	for <damon@lists.linux.dev>; Sat,  5 Sep 2026 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640697; cv=none; b=XM3/i+mNVsKkBjWlTBBmCJ+1E7fj74bYJ5oMRp4xMYPpTbZfoqxnIkmH4PWWv50q5PX+s26v724uEVcD+PGrpSAaTCf5ExBO+pd5mAk8PRtsTbpTpfbOM6Ymty0h1ZvhNrNubFTAnDLYOPifINSTM9D8/fAtIlCJC+nOe/tZwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640697; c=relaxed/simple;
	bh=CqTfVQwQTUUohk+XoObTlxudLG0wW5oiuWt4oKon/V0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uCGRiiXqK3/wkmrh6T4y0axcuQ+JVs2ib+hwzX9OpnvzUo9UDLt3xUWg/9svHNYQ1hh6vdZLCYWwt8URns5cMQJACYENkndv9SHxj+BrWeGm4Tf4eKMPl6s0LrhsMxCMDgXStbCCLYS0xVeUYWT7QFb9+7jBmuwZ7H3SMnfBdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awTNCYAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awTNCYAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A03F1F00A3A;
	Sat,  5 Sep 2026 20:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788640695;
	bh=QqOjqFzltV3rluh3sdZdqZ1Xtkk2YwOqzRM1kPjlUOA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=awTNCYAGJqMbm1HNg37FWq8Nrp1Sw3AFxClE4QnLru9uv5iSIvUTaxxYNsQgFUt0b
	 39dXsZipGlvftM4enB7+DHLg0e7T2aE77wxvdjb5pKoGDameo5Wdtr7PX72tihTMWZ
	 oVyC7d6N7cw82yw/B3YhPhHhl0h9dHS7NZBp6DcG2ahHuBXOUQZ2YtKiFXcq/t/Ib3
	 BMBKJNTGAhHgTZkYYdTYyWj7VTBL79ERDhrm3QamHv9+HM0SG12p06ZSOuN3/IW5r1
	 MUVRtlup4cRiQ+YodVm5SAH3apX8DuiIWJqlmc1upJAlfOmZlwv8F2imEJLYCfgPBF
	 mqDHXFurVlROg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/5] mm/damon/vaddr: support apply_probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260905202634.88102-4-sj@kernel.org>
References: <20260905202634.88102-1-sj@kernel.org>
 <20260905202634.88102-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 20:38:14 +0000
Message-Id: <20260905203815.5A03F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set (vaddr) is not supporting
> apply_probe.  Add a minimum support.  Do not support hugetlb pages and
> PGIDLE_UNSET filter type for simplicity.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905202634.8810=
2-1-sj@kernel.org?part=3D3

