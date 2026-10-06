Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349339E177
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791269753; cv=none; b=Etc5r40ZNZ02/63GPnwMGAPbNlaLfadTA7zJ1LefyaQnHEcXYQEa+n8rh9H0d2VKZn00P+zvRBZ42qz6s9lOdAyBJCQBo8Kkc4j2P2kQ+UJFcTQbO0BTIWfARCrbXsjxemsTTQtyjHea5rdykSXt2ORewKwhgvctvmBdtj9YaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791269753; c=relaxed/simple;
	bh=EDIufxevTK/7lLN4z7P/fzyqVnNC3ZGaVp3wobTvk6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lY6wFMG+PClihKovr+q8l34yYVzGu0+G3poOl1oUw1L3WiY3onvRsbIOLx7qoCYu72XE5l1s5ehiOX7Ar/EGBeJ4kpm1N3vaIj2ytqvrCy2wT0oNRcag1+4zgjeZU3xrxGyH23+XxRaeUCUHskkQ672AGZBR01Y+amGJK64mNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTasWwET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTasWwET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74061F000FF;
	Tue,  6 Oct 2026 06:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791269751;
	bh=EDIufxevTK/7lLN4z7P/fzyqVnNC3ZGaVp3wobTvk6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NTasWwETxQuhy5+f5pod3e3Pq2ZhNEaAzEMdIeGwxYTgAd9fWsyNb0QVWg+rCzk0N
	 KcaotF77rnwfB6vM89GmHb/QuTKPKrWHyxq4rjD4//KYHFvRfX+a1z2WtvAsnz/fM9
	 DGfrVO3tPwURwyf0FMhMXPODEFva8SQvqRDAXImkLwOehiJDnuvuKsHoXGLENNPppg
	 FkD6IpL2mofdtrhbBaHza6XsDGKrZehcXbXSRt3kFlIOk18bQCt8IrIW4bOQzf9FLH
	 8NynACzVNQANnwCc7JoPDfkWS1NDmJ/ZScIJxXAhgHxr6QmcylYNMT1mYEIyy2Gm46
	 q4xommE0rUHNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] mm/damon/tests/core-kunit: add test for
 unconditionally skipping the last region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261006065209.41507-4-sj@kernel.org>
References: <20261006065209.41507-1-sj@kernel.org>
 <20261006065209.41507-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 06:55:51 +0000
Message-Id: <20261006065551.C74061F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Liew Rui Yan <aethernet65535@gmail.com>
>=20
> Commit b3723b596b54 ("mm/damon/core: fix unconditionally skip last
> region") fixed a minor bug.
>=20
> Add a KUnit test case to cover this behavior and prevent regressions in
> the future.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006065209.4150=
7-1-sj@kernel.org?part=3D3

