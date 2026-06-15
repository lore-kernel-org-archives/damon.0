Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C9238F935
	for <damon@lists.linux.dev>; Mon, 15 Jun 2026 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559721; cv=none; b=AyZyseSQAcU3Cvx8DPw5pkIz6dLyTE15o1DtbGOdfC4BEJbDqjb2ImEPPqFii6QcIwPoN9g1Iy2LU739+Kch4+Cz06vRKQolX2F3QJxETeqyIgoqzaYlU6yheUmb100MpXm+KtuKixDb72SsIutn5anTuQ7c3lNYinP0wavppQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559721; c=relaxed/simple;
	bh=x6UgW44R7h5NkurG9BHrQPMsrVN8ouOfWyg/9Ih09Hw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oQmgLBUOQtfLwowyUcjvQ5XlWDW5qDe21yxouQJ0j3WoBJPMPIOsDjUb2cInWN8tT0tQ2B1ALRmPaGxt4+UHTVAiFt2Ru4sqT/i65/DsElwiPgkwesQu0/N1IKond0ZU0F6Apx64CIWz+HXRdPbShxNI9wirofH8AkvPuB1uE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=CiHNkWzu; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="CiHNkWzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781559709; x=1781818909;
	bh=x6UgW44R7h5NkurG9BHrQPMsrVN8ouOfWyg/9Ih09Hw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=CiHNkWzuvS6incPVViH7b4c/8S2KO7h9qf1ueeJTsPBx0+cHc1fvZWP7CSKpAl6ku
	 XphCRMQhbtZGv3ix4kP4y0e1wET7/udkJR7NWUfKagSY+SNpKR36wTQoMS2Q1/2ueF
	 LYAZqNi/1tO1MwHM0fgAk5CwNSzcZJvCG6cXTRChlpy8dEq0v7LJSrkyrtAMqyMBew
	 YGN0Vk+aVDfWI2P/8rVW7MsQsi8S2tqO9aVtXv7MWsa7ahSR3camSRIVT5Ev8j5juH
	 q4qTssCufwqMP1jH30pbwF6omOPDLUbshB0NPydDH3tnM7Lzr+mlji6LGMQui7Z1wZ
	 WeCBqW1TxEBhg==
Date: Mon, 15 Jun 2026 21:41:43 +0000
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
From: Philippe Laferriere <plafer@proton.me>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Philippe Laferriere <plafer@proton.me>
Subject: [PATCH] mm/damon/stat: use secs_to_jiffies() instead of msecs_to_jiffies()
Message-ID: <20260615214113.122923-1-plafer@proton.me>
Feedback-ID: 48859933:user:proton
X-Pm-Message-ID: 113a8e10c485d39b550823dd0130e86e22ad2d35
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The conversion of a duration expressed in seconds reads as
msecs_to_jiffies(5 * MSEC_PER_SEC), which obscures the intent and
needlessly goes through milliseconds. Use the dedicated
secs_to_jiffies() helper, which expresses the 5-second refresh
interval directly. No functional change.

Found using Coccinelle (scripts/coccinelle/misc/secs_to_jiffies.cocci).

Signed-off-by: Philippe Laferriere <plafer@proton.me>
---
 mm/damon/stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 0e14f5bb8f75..b05b68f73e10 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -138,7 +138,7 @@ static int damon_stat_damon_call_fn(void *data)
=20
 =09/* avoid unnecessarily frequent stat update */
 =09if (time_before_eq(jiffies, damon_stat_last_refresh_jiffies +
-=09=09=09=09msecs_to_jiffies(5 * MSEC_PER_SEC)))
+=09=09=09=09secs_to_jiffies(5)))
 =09=09return 0;
 =09damon_stat_last_refresh_jiffies =3D jiffies;
=20

base-commit: e3d8707358ea76b78bdec9928937bb9a797f2c8f
--=20
2.43.0


