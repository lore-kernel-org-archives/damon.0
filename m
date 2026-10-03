Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5F456E18
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062446; cv=none; b=gy1jTWg/CKq0JAqUl50wMPKBbYHae3eD9mfLEefhFeuycrWHwCGhZsixJv62A5S9RsxbpCd99ArasPWQ4HkmBcJ3X7WD4+c43MHXtnOX0qSxkAAf+qXxF5mNnhcFqHDhG0nF8wrZOgxulQCohpTZv63+B/a+od2HBKsN0+q1inw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062446; c=relaxed/simple;
	bh=y7PvLg0yAk+wRSfj5P4g+4Sx/68b5+nkrALseWi4Z0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RRczYg2uMF9KRaab03suarTkcp2YHczrOqWAZMsR2U03HAydO+qUXNVkjwZkVJOnYGennVaWxWzqHg9DVFO01SzfR23naV+E2rxOv79AbSC9MwUwc5/N8Qj4F000RoMwdWB2/S5Ee8yUVB3WK2xET8Z8h/FQkNoi8xlo9mltTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/fNgqwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/fNgqwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4741F0089B;
	Sat,  3 Oct 2026 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062444;
	bh=y7PvLg0yAk+wRSfj5P4g+4Sx/68b5+nkrALseWi4Z0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/fNgqwA7hCy4d7hoMbgZC4/v+b52Vkco2qOmfuFRQpMVChvADi2+DlFUsCXIYPlC
	 395XB957rqKn0HdxCSNxzJx8aCfqmj5oQnEXaJgY2C2tEIQyyaSjGi7HUzD+36mmXY
	 LeHNQQ28slgqbhAqsu/CYHJJ11qmXcCREMU4RwVvCAWXN6NJrmhiEh5Td4VvS2b0Bg
	 GliycfO9BLdvObVJUk5yhxCpbTdViZBBI8Z4iCZ8DQFmQenpHag7o8ZA06HwRQxUr0
	 1M9NucpOZ++VU8ALUw5DxKg2nw7B1uc57GHZBECA3N9p+7hO5W0j66d+jltW4SO2dM
	 CHQQZxZmtdGIg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/9] mm/damon/paddr: remove page_fault access
 check primitive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ravi Jonnalagadda" <ravis.opensrc@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-1-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
 <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-1-0f00417b41bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 21:20:44 +0000
Message-Id: <20261003212044.6C4741F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: incomplete removal of DAMON page_fault primitive breaks monito=
ring
--

commit f8b1b9b51e640cbb863657ba42563c571bdd1e32
Author: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Subject: mm/damon/paddr: remove page_fault access check primitive

This commit removes the page_fault access check primitive from DAMON,=20
including the page fault reporting dispatch sites and support helpers,=20
as part of a transition to perf-event probes.

[Severity: High]
Does this commit leave behind portions of the page_fault primitive that=20
could silently break DAMON monitoring if configured by a user?

The underlying page_fault producer and dispatch hooks in mm/memory.c have=20
been removed, but the frontend configuration and core dispatch logic appear=
=20
to be left intact.=20

Specifically, in mm/damon/sysfs-sample.c around line 593,=20
damon_sysfs_set_sample_control() still parses and sets the removed=20
page_fault configuration from the sysfs interface.

Furthermore, in mm/damon/core.c at line 2088,=20
damon_primitives_enabled_invalid() still enforces that exactly one primitiv=
e=20
must be enabled, allowing the page_fault path to be accepted as valid.

Finally, in the core kdamond loop within mm/damon/core.c at line 4393,=20
kdamond_fn() still branches on the removed page_fault primitive. Because=20
the backend producer is gone, this branch bypasses ops.check_accesses()=20
and does no work, resulting in exactly zero accesses being recorded for=20
all regions.

If a sysfs user configures DAMON with the page_fault primitive, could this=
=20
cause catastrophic automated memory reclaim since all regions would falsely=
=20
appear entirely cold?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-damon-perf=
-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com?part=3D1
