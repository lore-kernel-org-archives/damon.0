Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5A3C3BF7
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482979; cv=none; b=MnVb0iLtF8e6qL2/45N2x7EbyvUO2DWT4eECreZsTMXYnrJVKx6BI4pm1fH/gAfsgXi7hqPbKSX/YarzEYws1ANF/5fU6R6gqwg/YGRNsNerKHX97MhAKFTfATa6ZTWXmswINEc+UtLbARBu5PtA/lcleBDJXQoX5amjtVt+6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482979; c=relaxed/simple;
	bh=z1yjkXCLumSsmMgBlTH9Kt6K/ulZbqvJRvuzv3MQqJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sbwFFDzNq5JgSkKoLYv7jCF8dipypK/f36V9a6UWPMJAnF1T42SbnqsBCU741ZElOT+lyS6hDDnFWU3BotMm2P5qXBjj6IeAPU6/QzsGIgaIqxoNnb5FbEKWJ+zmNweyGXRK8m+FjZlqyT5yTOJLIIj97hlXMzctRLx15agLOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUeuXQiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUeuXQiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C141F000FF;
	Tue, 15 Sep 2026 14:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482978;
	bh=z1yjkXCLumSsmMgBlTH9Kt6K/ulZbqvJRvuzv3MQqJM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UUeuXQiZ9OZ16h6ORphzND4MVaiSifS9sbK9J/prL3yyaBsNU1z3PZAq13dJ/tVU0
	 0NuAkkYrhj94i61hcunOiZP8aChCeCjs7l+994vA8jzAoaXF6mCtx84JduZ4nZJHc3
	 ruIUMqTa2x6qF+pXF5Jv4yowyVKtX466D7cpOJuNEEy4Q0Mts42vVaZj7GkxNwuw0Q
	 f5+JGvyctzO2xjpPKSgReyc2Xtm/bnP1t5vQqeSC7PKKz5BNIHnzaA2yY05qn02y13
	 BsuN/vagcL9alOUokZytPrKcgKDwDaiul55qGEdTJKlPp6qLDsGsREVR2eX+E05odk
	 L8P+dWYU6IlIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] Docs/mm/damon/design: update for hugepage_size
 probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915143359.91472-7-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
 <20260915143359.91472-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:36:17 +0000
Message-Id: <20260915143617.D4C141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added hugepage_size data
> attribute probe filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915143359.9147=
2-1-sj@kernel.org?part=3D6

