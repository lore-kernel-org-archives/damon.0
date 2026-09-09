Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B132931EF
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928528; cv=none; b=IXcqcqU0WlVuPu1sRMzUeUSvbt+JQZGtxEfZocCSeQWv/S8zITjcz7Tr0QcAyEYXOC1YOJPY8APXHCl4eDNfjF+Lk6X9PNmnQ8cWD6Me2Fmhb0JDE0ZgCGgrGCk4w+g85o3lV1qlPGw0YH3AQ8YaHlyxJhLOgsHMXJ6BjNyPI8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928528; c=relaxed/simple;
	bh=1iX1eYfAdQFIb6tPRiLX38NwKPOsXK/O/9HcjXRr74U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uuutUUlXXCN5/FWQxCnyd8a5OhO+dyuOJy3lAeeZC5WsaHGyRXJY8CalXlNjxApw3EZ4FLH2tb+mB2WThvOg9QB8BWDgJ/JoWc+yuHYD4dvukpbCEAa74PWRNrbC24a7i30XNfiMFsAvbasgskLg6uxGUHFzyZA1aDPpQp0YJfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G89+2XOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G89+2XOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9BC1F00A3A;
	Wed,  9 Sep 2026 04:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788928526;
	bh=b7k9cJV+7q24uCWlir2gSwLC/YVE4LaolbEEFlEBC54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G89+2XOPBLenjxyb8/Qew8LFrvfEDLtBnavKqsOTFNHZW36o8mcuywKoD2Jf5qUI7
	 1D/CIUxvTBLU1345z67WVhmkD1i6HclXIiMBrpljffPbfz9mZsTBALnQFwIfbHzkQB
	 mGsFubipJu9zdKDoBDD8YTNkgrLLpjd920EWaDPB9gFqHqB60J37ftRIe9B13vIXP0
	 twQhR93YWUxFl2qfUupEsu99m42mKvmqOs0qQXbruCfPazOlMUN/xzCkm6g00Psd4W
	 0SV43AAG5tm0Dr++SjqqRMkz5Qz4QYl3WAtg5XIYX6T+eG8U2DGcvqwCuHvOpKQPKM
	 fudfXb8L76BMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] mm/damon/core: initialize damos->last_applied
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909041122.180644-1-sj@kernel.org>
References: <2026090805-evoke-tiring-a0dd@gregkh>
 <20260909041122.180644-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:35:26 +0000
Message-Id: <20260909043526.6B9BC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Patch series "mm/damon: fix uninitialized DAMOS field and kunit exec
> expectation bugs".
>=20
> Fix a few Sashiko-found unurgent bugs.  Patch 1 fixes use of uninitialized
> damos->last_applied field.  Patches 2-7 fix DAMON kunit tests that do
> invalid memory access under test failures.
>=20
> The bugs are better to be fixed and eventually merged into stable@ kernel.
> That said, the fixes are arguably not urgent.  Patch 1 only introduces
> negligible DAMOS efficiency degradation in occasional cases.  Kunit fixes
> could introduce quite bad consequences but those are test code that affect
> only test run setups.
>=20
> This patch (of 7):
>=20
> [ ... ]
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: <stable@vger.kernel.org> # 6.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit af5f76aeb9c9aa9c77d5e1d94e0ee4618c805239)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909041122.1806=
44-1-sj@kernel.org?part=3D1

