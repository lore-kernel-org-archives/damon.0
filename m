Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D4741DDF0
	for <damon@lists.linux.dev>; Thu, 24 Sep 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281376; cv=none; b=F98oY64UOnsHGLp1O9b+lCGUYUtxg3R44jmSbAkFPLGll8KHVMybyUj1Y/gOSbA0vsA814wIXCC348IAy3NOab05oywhh8m5vJUnEuStf19h190FSP8n6cGbWejqHZxHE46KKv4LoDal4b3au2t4ZQGBN0zBQ/gr7D2FNGpBWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281376; c=relaxed/simple;
	bh=siWQp+wK2awmy+277hSgAMPOFTUqgmsMAlh0e7sZIFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UZcJunR7F8my18V1Dr1+llcx1dBMQuqkCYdNu1ad4F9qkXmfXI3kXWQthpfhSsVCt0eri+78Kt9gvG7yKDUh+U+ujd9pGhE0FDpNEC5LosqlBy3wMy9kXPLzOlHkcryHfjOOsEoFop1Z6AnG5xB0K4A0zCt7cYSjklF5rXHaPLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=af80PwWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="af80PwWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210EA1F000FF;
	Thu, 24 Sep 2026 20:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790281375;
	bh=siWQp+wK2awmy+277hSgAMPOFTUqgmsMAlh0e7sZIFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=af80PwWgflbNZqXUD+NNELf0KiltGDbJgplrLZlNMgjUSd3jtHTrp/blTRblmMxy1
	 l5Y8+V+IL16CNKbk/AyTLER03vZcpLgstKYox4b9MGPGyggl2Z2q2T+F5hBkGv+TDD
	 05gltWEgEe4I7i2zQcA/ACFUBndVOsdAo3S1goM4qd3Hzft/3nn3aTw+9kZcUuBwvl
	 LtUnPSiHvmfKDAwgGSKhP783k1TcGHnogOQvDaSVbdvzL34ZrHpTJSR/7TceljBS63
	 WK0Je4wTTVhA6beIdOn5m+tEdpub6V+Tb/06utSckkCceuwUu7O65J542YMxf2Rfhz
	 tzHT81AfoIGvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/tests/core-kunit: test preservation of
 quota state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260924201615.4478-3-kmehltretter@gmail.com>
References: <20260924201615.4478-1-kmehltretter@gmail.com>
 <20260924201615.4478-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 20:22:54 +0000
Message-Id: <20260924202255.210EA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Check that damon_new_scheme() initializes the new scheme's quota without
> changing the quota passed as a parameter. Cover all eight fields
> initialized by damos_quota_init().
>=20
> Also check that damon_commit_ctx() preserves those fields in the
> destination scheme for both accepted and rejected parameter updates.
> Use an invalid min_region_sz for the rejected update and confirm that
> returning -EINVAL leaves the running quota state unchanged.
>=20
> Without the preceding fix, all eight fields are cleared in the
> constructor test and in both context update cases.
>=20
> Reviewed-by: SJ Park <sj@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924201615.4478=
-1-kmehltretter@gmail.com?part=3D2

