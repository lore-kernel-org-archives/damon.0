Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE84A091C
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052159; cv=none; b=a6HlYorLEQOHWVA++HN1zmAZAhr4BBbfGtg1UbzyA4JljU77ckh8dJKJogG1TBN/dPemn4AngqlwUyFN0w8PP02ER4c/MqWOCDZj39FiHVQyAV/g/ssY0ADAqsJq6PGx+Fjt7qeTsIOmCDCjD8mIptYTJMUMp6/hvi/vjRW56k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052159; c=relaxed/simple;
	bh=sCNAM1mKYl42kNhTajTj/NKr9z68mRufY0Np2SfCkfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tp1KOA7HwncWEtCRddrZk7uUcuMxOXBBTOgoEN9nTsq1rfBkX9oq11DKsOTfJ8o3ZqHzCHe63JpHZFN1Y7HNuRtY8tCgrLA+hA6KzsUk0aX1HffrHbHawZ8b0JhLQYb9l/eF9lQ5qUZcT56ZfO4ZpOJRGvfSBtFdl0bPI84P/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kF2HWZws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kF2HWZws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B57D1F000FF;
	Thu, 10 Sep 2026 14:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052158;
	bh=sCNAM1mKYl42kNhTajTj/NKr9z68mRufY0Np2SfCkfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kF2HWZwskghEpbR8G0J9iPmzIthTdRI2ja8AEPPY0MQd1ypItNtiOpkpZZHdZOI8I
	 cc9D6XoLsskJh5XChz3j+AShy7CsLDfoo6TYeu7YQSwuGGl8+rS6NFpDsbDL63a0oj
	 V5o+NyCjc4XccTDh57wUdeu43b52pIn/5PkyHwPETkCFlwGWwM/ENPscvLkYw7Vuvm
	 7WB1+R3k/85rCINDCoPy+H07zNnLV3AJVbGFRF8Lsu4ZfGVSPlmmaXtzzlgJIfTqCL
	 ocOCdZSLGo6mqTMe6uzAa0tG2YYOJ9DtXuzWBKxIDih4YIwQk5tC+2RIGYIEq7bYqD
	 YT3DOydmmQq1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] Docs/mm/damon/design: update for pgidle_set probe
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910142234.171562-6-sj@kernel.org>
References: <20260910142234.171562-1-sj@kernel.org>
 <20260910142234.171562-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:55:57 +0000
Message-Id: <20260910145558.3B57D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added pgidle_set probe filter
> type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142234.1715=
62-1-sj@kernel.org?part=3D5

