Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066A02253A1
	for <damon@lists.linux.dev>; Sat, 19 Sep 2026 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780635; cv=none; b=tH69IQs8cqruMWsupHASdux2w2ZjXmQQ3z+bQPcdYzRf+H3YjRGUHVXRM9VACgKTPvVj3Z2ECiv/Wn2SX1Xe1LETuGiOfYVVbVrBQwatiDWC4IYtV6TRvq9JYNIc/CtDGq5d3CorfdJ3iQODTQKLS2om8BHPm5lpLy7gdCX3i4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780635; c=relaxed/simple;
	bh=ZZwajQVgRoIRr+GH6iqQp3Hkc/LCdQMuIiMKlWlYnck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cfIovALMXWzwxTiTQcI3I7Dc9+SCZoSV11wPGbyNwybxGW9mpaadpu9s5A1ajDyB4xyMzwuc5jW0qfEESGxJY466x76vzmZpgKnJagrC27APh5LjUqN9zGjrNo72k6fw96VjICRKp+FSUsL0sb2FXPXC4jZcRk4E5/nuH3yIBtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwdK8sQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwdK8sQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964EC1F000FF;
	Sat, 19 Sep 2026 01:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780620;
	bh=tXt3T0hI01qyrSgEWApU5QbZ84tZvQ6/3bDbQ5NnHVc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IwdK8sQRBbHmWZ53HPYJvvnl9tpXURDGiNCVBGwlrJBW4WvD6Qg1CdoITxXflJhWi
	 UNmhj5AWXophmfYlC6RVTm3TyV8n2q1KNFGDU/j8Yi6nraCtMmYlLuIET+5oCsQdZ/
	 b10CTMsCx8/irIVrQ9nT+xE/iua+d68CNzii37nvrjNdbAq2OKlAeuvPvdLIto/62V
	 xPh0ASo6dHsfUqSYnFYlNpP2DAlPVj3rqQ850p1cuPMBZ+Dik9rVf8UpIiTw+EgwfF
	 Xf3xk6G4qjPHigzRkU9w0w/CmfgqGZ/e4QhUm7IP5XEcREfHqr2JWWQNE9QXjZlxxK
	 0d5fUMtm1/80g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/7] mm/damon/tests/core-kunit: test
 quota_goal->complement commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260919011359.88921-5-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
 <20260919011359.88921-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 01:17:00 +0000
Message-Id: <20260919011700.964EC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend existing DAMOS quota goal commit unit test to test the complement
> flag.  Set the source complement flag and confirm the destination is
> updated to the given input.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919011359.8892=
1-1-sj@kernel.org?part=3D4

