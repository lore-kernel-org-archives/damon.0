Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774894;
	b=NBN5FCV25D0i970/VjO4loO+j4AyGNVDkOFGkiuY6nm0JzLpT0/Wu3JnfUXJ5A1S1zmu
	 9gXT+rzYeVabcMwteJ8cRyUt78ueXbkfit/oWFbKLfAr+PBITmuhE8sKYae3zoYozr4DN
	 k3JwtDuAouuX2svaymf4DfntpRIl/zFZ348ECrJjBgj5SzK2rKWB6tIPM8UjyNiO2WrF1
	 wx44a+8KvRojrdDFn4RCYtO1KHM5cks/XRfpRy+qDOH9ZmNhndCMQNbRG1YyJDczrR3g/
	 TdY6H5/KeN3EPEg3xAcmexdt35OyZTGmJ3YEmkLLChcm4kUes3tpNItnfGQOxqY0ySA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774894;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Qt4OgBME6KtvTNc1vJwP7Vozok5+bun7TKugRYW0HR0=;
	b=g+pvVrQ+ZBiVHdZZ5CTqL9ftIToHMkqyHw9ooxypmC7v5J9L6kuxaHvFM2QPcZwczx6+
	 Xcn3yr1SWKTpZNmnBflSBSuBLvTmql88ygO7llZT5p6gGH3x0EUctDwKorsqsovUyMErd
	 wQFJY5Ihl7foULw6FxHEj1CdV0dwPZnNuRfk70ZvanSQx62zGmuAmiNhGBmDBrAyzyoVX
	 n8+0Cg5fSkF+JfwZkffmPnRUH7GhZR5tYfulskxKRUFXpio08wfeDAeUdWVbJ91Ad0tqh
	 O7q0pzxP7JzCrIobcBaody1DRubHu7JxNQJsm45Zqum0tW/opP+oDhrnxisIn2IUaNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXg7TqP9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D28606A32C
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QXg7TqP9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E461F000C4;
	Sun, 15 Nov 2026 20:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774893;
	bh=Qt4OgBME6KtvTNc1vJwP7Vozok5+bun7TKugRYW0HR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QXg7TqP9k3GpwhGbQfLcdypgHQ6TeECkmR06USkRg7+l50oWmdek/o5scYPZvUwzT
	 0+2XAV8rWUXjw4fXbOaGAkRvOZ/Q2BJ808hajgy0dDFvLyTIIkLCMsa83vC6CNgdzy
	 8zlnCFZ98YtyofB6taOenHcD1oybM1C2F5YFhb1nSB2Q5qJZCVWk5fTFaVPjgxIfyL
	 k+ebBp4qd80tRq/ptV0Af0yD3IWpATMxhIY7QTvBGcou4QbaUUR5qrEzE5MlVznLf9
	 uHVCZ3cp5p3+2w9KhbvNizh2VOI3nEO/innborjjawf1ZLkRChksmbSLyzCgRiwJjg
	 12acX+9WeyZZA==
Message-ID: <sashiko-outbox-215840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 27/27] Docs/ABI/damon: update for user_report report
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-28-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-28-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:34:52 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON ABI document for the newly added user_report type data
> attribute report support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D27

