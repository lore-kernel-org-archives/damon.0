Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635DF1D63F3
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398146; cv=none; b=HdXcnRsO2j/4Ly+tSGW40yq9K9EIFoF4R3E7GdQA1PIG1Rlu+vr7ZBBHziIWmpCzGAFkdEYtW1rb+f293Rqb3KALnGN/vy/lA6c8aeb62HeV4dyLZX9Zh6BPewZF+IB3gVOsIdD4iKyi+GkyQPGBxkFWH+tgM+mdZTo7oQXBfNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398146; c=relaxed/simple;
	bh=CTxUCNzEBalkfHdKv5H5M9djH9uQ60J7yX2jlDaDPpU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YW6UJWEfeN7N9rwJJHzd3iL2HH51IJcGlRj/XO8T4JWqiBkwOIgvKz1FbO+6Uzlrj888U0ny1PlgrGJbZaoHhYMBeluVBCq/gulPDQkx3JNfEqO9AQUOvATqKaawHkhozhrQRFN0Gn8wZdxpB5Sm6lrzCMrIpXPSB+m0H9jy7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1JgJ4Ta; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1JgJ4Ta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA03B1F000E9;
	Thu,  3 Sep 2026 01:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788398144;
	bh=TbOduznd8c9oTKHhEMJqI3HSx8W3sktRfJBgUFGGY5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W1JgJ4Ta1KlP1lQ7AF6HfOLLiEt0YSq4gwZ2ZVKTQ2Vjz10shmMtM+IBWVyPWPJh4
	 dDk6nWHE8zeifBhUq4lf47ZBsykipekNhECg8b45cPpyI6gjtdQHXoWoxmEKj99zvO
	 MJAdf5G7Abi0ofPiD15SHG4rGHEawRwmVw04K5AnTzUrC/RYqbrahVMzz5z4Mt9sqC
	 vj7NGMKXTWFk6BREz69JaNhEE3cTupf2IedAnXYxvrVFEPhEkN1OPRkWzzAr7+0UT2
	 NEoHnzB/epqNIow5x3AFwa3rGZ88ru2emEtyti/yl04qnEzzb6pJT7ClDgZyOoB7VR
	 XT1HlpXLC/Bog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] Revert "samples/damon/mtier: error out for zero
 quota goal target values"
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260903010722.94244-4-sj@kernel.org>
References: <20260903010722.94244-1-sj@kernel.org>
 <20260903010722.94244-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 01:15:44 +0000
Message-Id: <20260903011544.CA03B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> This reverts commit a16fd3ad9d89b05475864da97327870464611736.
>=20
> The commit was made to avoid zero damos quota goal target value, because
> it can trigger division-by-zero.  Now the core layer handles the corner
> case.  It returns an error for any attempt setting the aero
> target_value.  The corner case handling in DAMON_SAMPLE_MTIER is hence
> no more needed.  Remove it.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903010722.9424=
4-1-sj@kernel.org?part=3D3

