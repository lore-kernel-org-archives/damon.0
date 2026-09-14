Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DFF36D4F1
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397321; cv=none; b=aPy0OUgxO/dgi/hZ6P2XsxMtX6XlHsCxeXzI5h7B3nI270F5xZ+3yyRmkJ2KthmqCW42QamVLZNgpQdxH09nNXUyvN2eJLH3Uxp3RYh4YyxR5NKXrCPDhkEDwd0LnKje4lEu6OO8LZijjf66BCmN4LaF192SNEWUWaugfhkXBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397321; c=relaxed/simple;
	bh=A7IRSIbcGXzWHLr6nCQjonyz7xDgoB7Wybh89fM7AsA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CHfIT4XyIQWdFWZ4PaghvTxMo8OrJjgJw1KN000ZyLg/pqoNkIAMxkZBHQEjp5yIKGFx6Gu5htCwlG/DOpSDjfpJWLkhEs7FYFeLhTZCtQDa6HMxAMaxP7sTKoAAoEUIfPH2uDJ2/DedXwS/ZgO6WGRnyGQmZCpjSTB61X2DC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ocumz/OS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ocumz/OS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25201F00893;
	Mon, 14 Sep 2026 14:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397320;
	bh=1sC597MBiBFS4ao1ofWP1sux3Cxhj8VOuLKOrmHpQ2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ocumz/OSy2qQlY10TamiPJYcPFJSmsfXSlhr1NruRjO7tHOFlHkOKPGu5fI53X42D
	 x/87W+q/CtBOkLa5XP9VYwUUgShAIlz3U8DrQ1FrElNwBq/gccx3AUvatkVx6t5EOJ
	 MWqkVWE6rbY7bwzllIAUhHBoCXiPt4KCzd5Fs3pPx7OH8BxeYg3qvDL5glckC+0Ynr
	 +kL1a/9nDNmQZjEj1N6MpnWrFid/cp5VCiF0jjvw4sMDzYSSZ018JAz++o2PA+eSbZ
	 8/LEMH2jPPnNBjYn2kFNsf0ke6wpcNIv2ZRtB8X17IofWhUpWd+Z7cvMJuyJGXtTlJ
	 LlgzggKHY30MQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/8] mm/damon/sysfs: add min,max files under
 probe filter directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914144448.93732-5-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
 <20260914144448.93732-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:48:39 +0000
Message-Id: <20260914144839.F25201F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> In future, DAMON sysfs interface will support data attribute probe
> filter types that have range arguments like the newly added
> hugepage_size type filter.  To prepare such supports, add two new DAMON
> sysfs files, min and max, under the probe filter directory.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914144448.9373=
2-1-sj@kernel.org?part=3D4

