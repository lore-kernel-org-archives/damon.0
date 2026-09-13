Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5E368D76
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320132; cv=none; b=lsZfpUNXEMAEunJUcxTGpak9ZD+r89so65nsusK2Z3Hyl5kiIRgTKuFrHrfoQi0fg0nsP1rvzUNDWLgRVjMQkuiXupcwTZoDhnHrRfVpYpY8hyQ5ge49u4t8H8PEkKkAEOEFAt3SCExvxEvRUtwI/FUS10Z7OjlT/4IIW/5I9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320132; c=relaxed/simple;
	bh=K/HToFycEyaoGQGMDDSfrgc7kh7BciEX3qGuNReItig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DPKoVOPmWLQFtC9H42m/E7elNb1G8Zc4j0xiz/0NCf4+36Yre8Oy6It/+bfxZQ/lp3TuBZFkdyqLgoV+8qVA2map9Ja9sZrcuD3j5ShwpAzpJQylRu6Exz2/WsFPHdrM7IcbHPcrpqmoou0n3owBhRAawvUXDfwZWUMmBvdTBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk3e68yt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk3e68yt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CC81F000FF;
	Sun, 13 Sep 2026 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320130;
	bh=5l9iDCJTvS4XrjchRI/dmwiJyTgmgGa4We+RAvIk4d0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mk3e68yt+X5Q45O00VqYDp/EzOzXCl2dQnh/P7PmuCxurOKt2WVJ28f5eLG1/Ac6m
	 IUKAduTmy0NUcG6K79ABMq+kOWrPPgvHY9IqpPCyJAou0DpQlHiHAHI2xDVns7EcdX
	 OuKMCKQtN2w8CEwYkoOtBckrzeEYQP0EJp1WyDRmB6pBxbltrfeHLr4z6iQwjo3Zbz
	 biZG/8J9gEACvGL1BzpgG7zY+EcTCaSQIg5ju0oFXijW8BfHpVlhi3vT7CQaVRrjnK
	 D/rrcKxL8ATGylPjrsbIhDQcYyRKejmhhJVLa6bbSOKbLDCrEAnQwdfuPgwdsG0uz4
	 VR7gaXtbKA1Mg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 7/8] mm/damon/core-kunit: extend
 damos_commit_filter_for() for wrong input
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171706.103052-8-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
 <20260913171706.103052-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:22:10 +0000
Message-Id: <20260913172210.B1CC81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_commit_filter_for() supposes damos_commit_filter() to always
> succeed with given inputs.  damos_commit_filter() could return an error
> for invalid inputs.  Existing callers always pass only valid inputs, but
> they may pass invalid inputs in future, for test purposes.  Extend the
> function to be able to be used for wrong inputs-caused error testing.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171706.1030=
52-1-sj@kernel.org?part=3D7

