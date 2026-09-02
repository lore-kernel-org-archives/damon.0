Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05717A303
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309585; cv=none; b=LMKgYrqXV3mlBx/VAypw5B4X48dBQQOTrc82BgD9Dd6ClIPRwUssn7/Um65sEyAne7QD6KbXLCwIGl1UQYesbKOeSN9aZNT/HmqHCdwl/w5/8J44Kf0dw6MVHRiLyL356cxJnUA9dqMRDiffWb5U6Erp0L/9Tb1l2kHHWjykBVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309585; c=relaxed/simple;
	bh=Lf555ZPZDJB5UmVjD2BL6opUbBjzJwkuz6hXyVR1zs4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aIBxd/yQL15gU4MxLF7Y0yb0n46/I3G2O+w2fgiFtmT95duqyl0NRl5xx64ElJT1YcON/dvKABZlYLKPN/+lhOSYcjlm3VRVPTNsGIYSPO5OxbjbOwMxRGa/VyU7r0YDlkR0/Edi6NZKX7AnRP4JSAfjesmS7HYu6DyDRRa48h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2f7EED2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2f7EED2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0581F000E9;
	Wed,  2 Sep 2026 00:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788309584;
	bh=iY47JAQc6SJZg/NmlDLvbMGVOVxKC2snE7LnVE9YbsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y2f7EED2nFFkl5iaUYKEbkpeQv7dDG2e6DQEMQLJOxo3jgcooOgPUwuOdEN55PWbj
	 lgbMAdo5K0UcTYqpCtAtK1CsuAyovfIoUXeDSsRNRBFODhAobrw0nK4AgRSF0MiuuK
	 oWD67zPSgHp91hzFkLxyux0qnsy7e0uDSU/t82eVrcdkkfphPLsp1PswDGu4557zzp
	 IFJFqANmHnyIu4aYP8j1ZlaNL1TbFKvmbBVYAOzv+SjlSSoTbYMSlDU3dRf35jDqln
	 zlwb3/rTQGwWfCUBV2/mPcEjzUWqa029grRcXb4tGZ0qm0MvvYP1Xda1iAzQxyGcLR
	 liLp54U/FK7HQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] mm/damon/sysfs: set next refresh jiffies per sysfs
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902002725.108635-5-sj@kernel.org>
References: <20260902002725.108635-1-sj@kernel.org>
 <20260902002725.108635-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 00:39:42 +0000
Message-Id: <20260902003943.EA0581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When 'refresh_ms' is set, DAMON sysfs interface periodically updates
> auto-tuned parameters and DAMOS stats.  The timestamp for the next
> refresh is initialized when a DAMON context starts, and updated in its
> damon_call() callback function.  That is, each DAMON context updates it.
> However, the timestamp is a global variable that is shared with all the
> contexts.  When there are multiple DAMON contexts having different
> refresh_ms, the update frequency will be changed, depending on the order
> of the contexts.  When there are multiple kdamonds, it will be even more
> chaotic.  Fix the problem by having the timestamp per each context.
>=20
> The user impact is not very critical.  It does not leak, corrupt or
> crash.  The update will not be faster or slower than the lowest and
> largest refresh_ms values of the contexts, respectively.  The user can
> also manually ask the updates on demand using kdamond state commands.
> That said, clearly this is a bug and can easily be reproduced.
>=20
> Fixes: 9fd7bb5083d1 ("mm/damon/sysfs: change next_update_jiffies to a glo=
bal variable")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902002725.1086=
35-1-sj@kernel.org?part=3D4

