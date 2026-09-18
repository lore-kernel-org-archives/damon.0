Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB484A3F33
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744040; cv=none; b=sZoETipFS3FBr8TBSqXEo0gW5uEwPoj3h6Ofiw0e5qRjQvt5sj32hBxaCiRS/xn46wTSIf4AEmffXYTYNaWn+3aU+6dv5Mm39zl2Ph5z1DD/2nhf7WB+/jge0LFvYkTSlnV01gZHK54V83JnPCKRLxivGp8ky0OW3BEassGkjBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744040; c=relaxed/simple;
	bh=Ko2X/Sk1Gp8BhTZfE/rVzCbv6wySKCujzcPHGicamwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YYO62IrRE2eU34/viGeuJNrNTRmwxNo3HaQmrKskjuVr/TugGFKabw44rnZWZ5G1uTZkrbqXtTD3CMlufd4W2JjhFbhGgSQbU+r+WpnzRt+ehZUcHTtNT81RpZu6utZG6mIymvqB70IRdTo45hua2E40GqAo30NDCCPdL589xI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHZXgz4l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHZXgz4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5641F000FF;
	Fri, 18 Sep 2026 15:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744039;
	bh=TFVpJzdzDH2zFYSWkMmKMwB/QtqtEW8bYSF7fcWTE9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AHZXgz4lp8oS3Go2A6ToXj66E/ehm0U2VZ1Jn1p7daL5Do73izXNfNyCilNeS11MP
	 NreuKDjP+4Au8SYcFIYV5ik3BUkiUqx81tyiasOIkWomu7Ymebz9rQ9VEm4eAC7K+0
	 +wN8TlXtaIWSzR5GYm9ziasnAOn3hZbuE/1qwYEoa8GEI2sY/x13U/F8HCwECi+rWd
	 //LnsNbM+EPKPERQDx2UWMCLI3FYqQ3r+HfX+C58Q8bh9XQHbL5RZ/A+18JTT6groR
	 upY9MSTv/JCxVvvFsGcHesp7ZjMKPNPvjpBdVVUL0xsN0wlArvZXvqJI8e3qUZRvcI
	 RCeQNw/o6wV2Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/7] mm/damon/tests/core-kunit: test
 quota_goal->complement commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260918142827.85303-5-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
 <20260918142827.85303-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:07:18 +0000
Message-Id: <20260918150718.CE5641F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918142827.8530=
3-1-sj@kernel.org?part=3D4

