Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88688337107
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 13:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737478; cv=none; b=GbLjvFMt59VaqRTp7Y3+bOPYcm4gAqjJAaeGdobtnaOkxJ9hYHgDhDeorOl4VRiXRWYfx06KQsjYlal84e2PdlZMbG8ebZ7TRvZZeJNOuEGdvfneGi8CugZNg4xBzJZVb6WouGCyZab3srV1zdWaWChVoNraEF+Lc766HPPH2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737478; c=relaxed/simple;
	bh=lUTtbU1mhy4CUNVJjJ+3IJO5Mh9K/YZY0ksMyXswXXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bw5rgySkEegin+egYzvbHXtkZpdzMzolLzXtB4qnzyhJPwMXTOsEtBhZG970CuHl3Xw0wFcJBXV3pT59Jlfr8tzaX4YO7lSQAIESzjZS3uPfuNMC61Co5BbwDSsQN4Bv0ZEakLHbWJIB2rV5nvxWpO0uv0y4GxAjdfGnpyBK8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI2Yfz+L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI2Yfz+L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0E11F000FF;
	Fri, 18 Sep 2026 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789737477;
	bh=5vx+ZkuHdSL1ALbZOLAo+NKmZA6iG4uj6eh9+IBnLCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BI2Yfz+LTi4YZG62OXoparLYk8PWcLbMdXmfWmgm5JkagjKPrvfDhFhqOOjM94GDm
	 5Xt0/BZmtYo+K0ygZR5RrH1hbORot/S48G7GA3Wpn0mZSN5DJOMvn903iehbTLyiKz
	 NlOI+DYuFBGTatojtU67jqdG0f1nHPrHv4KnNFa7+2pf4GlD84yJbPzFJuIK1nRWcf
	 Ec2igpBBheo3P8lJBcFBS3t6Ug/ugbTLndBqxszoolvkmCL6VxMnt3bcN+Ac4sxKYJ
	 m92nRiSR5VYgeISJgRk5Bu7y8YWZuLSoI2ycTqdspawGpI243Clxu+N8btbDF3vmfn
	 fYZgHN17VDwgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon: document that a zero sample_interval is
 accepted
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karthikeyan KS" <karthiproffesional@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260918131301.75879-1-karthiproffesional@gmail.com>
References: <20260918023859.13556-1-sj@kernel.org>
 <20260918131301.75879-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 13:17:56 +0000
Message-Id: <20260918131756.ED0E11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_set_attrs() accepts sample_interval =3D=3D 0.  This was reported as
> a bug in v1 of this patch (rejecting it in damon_set_attrs()).  A
> similar patch was already declined for the same reason: a zero
> interval is intentionally supported [1].
>=20
> Document the behavior instead of changing it.
>=20
> [1] https://lore.kernel.org/all/20260722094304.3132750-1-dayou5941@163.co=
m/
>=20
> Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918131301.7587=
9-1-karthiproffesional@gmail.com?part=3D1

