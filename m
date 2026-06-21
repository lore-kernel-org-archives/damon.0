Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707A9285061
	for <damon@lists.linux.dev>; Sun, 21 Jun 2026 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057992; cv=none; b=DSN60vr+1LT/2khomixny8mAvUe79QXzvqY3vz/hlhsFkZ1FF3yaEdXljAolTn8CHKuE2+yRuNIfPRGtQzOaiJIKUxRiQDK4HmXjvD1j33znIisK3QvwiQWWnKdnAL+SvX2ac7zPzmZlGNjHi0c2/G5Y3zzszG+JJRweioIYG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057992; c=relaxed/simple;
	bh=YpjF2LHAIfm/jOjD9HTpUJPZs/wX18rXlJbXx4JRvM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OlVgAW05NiGngH8hP/Ma1M97TyHceHA19TBWXPHY/aQahXVgId3ON7qacVjS1Dj9YdcLKpMYVYqEGFXiLIJb8iH6YbIxcQokICyChl/sO9Hzdtu4zCf8MYmxo2lI6cs3t6segel0WBNthNRFNnRH8G7AIXiGNsz8dSQq4jrZJoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaO36uGB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaO36uGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE441F000E9;
	Sun, 21 Jun 2026 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057989;
	bh=e1IJgedKTqPMP9oJfkq0oB4m5gCKEY8fOCPFcf3SqPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PaO36uGBUDlO7nzAYYdjKSXFma3CkokknxnVYtC3rfH12TMZosJXZioRxGPVjx8oI
	 zUrUayHZtfImp92/nfHyKubDfLJUqx2Y7L/XPKSLcdYgrBwxDXPPo8lIbLGh/MyWDN
	 fodNj6NlCu6npyNEa0ccRtVkj/ik1u5M450e3m3Ksdu4Nu/q/ezGiqE7o2FzF+txEE
	 IsZEV52PaEWhVFDjkguf/WkhUKoLOJpE0yPxEd5z8PNZ636OOQQ3mA1cvsMn3JUnUN
	 Tan2xgswXjLdjCfdDZIfr1Jfv96OtlTfH3iMxlHqXXO58NfDz/sG7Db5/XCGhf8Ha9
	 8vd8LOAvcCkXw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 08/17] mm/damon/core: remove
 damon_verify_reset_aggregated()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260621155715.87932-9-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
 <20260621155715.87932-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Jun 2026 16:06:29 +0000
Message-Id: <20260621160629.AAE441F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Misspelling of the field name in the commit message.
--

commit 859f6640a11f9d1e3f6d935049f590ffd710d9f9
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: remove damon_verify_reset_aggregated()

This commit removes the damon_verify_reset_aggregated() validation function
from the core DAMON logic, as the field it checks is no longer utilized in=
=20
actual scenarios.

> nr_accesse_bp is no longer being used in real use cases.  Remove its
> validation function.

[Severity: Low]
This isn't a bug, but there is a typo in the commit message here. The field=
=20
name is spelled "nr_accesse_bp" instead of the correct "nr_accesses_bp".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260621155715.8793=
2-1-sj@kernel.org?part=3D8
