Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF531ED8B
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789135606; cv=none; b=eLSAIJbmfV8AA27mqFvUCf2PvzqRTZ+QlJIv2NWHopJ4JF+RkwY4P7W+ndwsMUp9wsnJwrkK9yqLslmDu0xjTcnkbfzflh4LlgbSKwpoIJRrHUOOSVnwAISHESWod57c6xL/EpbyVLvzs96TYp2APCc/CRiVOAF+6h7jsLiz5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789135606; c=relaxed/simple;
	bh=dDSduH1a67F0TyZAGHjcf+lxU6YaHfG4aHkaRnygsME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kl9BnYkFxfcK+KUjDtRFzEJnWsnCBln4e6+CmgF7A2KQfEyMvCJnj9p3IDIQ4l4++g7z2uH9mazIwegFgvL+pfVZvYpomB7CLClTyrsDyocHnUFa5ItaAKg85JeuCwchfznmzvPuCZHma7QSmBjflo1Ko72WSvQ4v7WyPZuwC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2EiAzpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2EiAzpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF711F000FF;
	Fri, 11 Sep 2026 14:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789135604;
	bh=dDSduH1a67F0TyZAGHjcf+lxU6YaHfG4aHkaRnygsME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T2EiAzpuh41DdUNa5X+H4syzEwMRTzFxGtvKndLhE9IUhUKGOwfDBkYCb6LU3LPF8
	 crHVz/dzhGJ9jxsxrLccmwzBTDgz9by4WrzczWjOlOzZPZFtNEFuM+X2py7nE6Xag6
	 8Nhet/DIswmyP5LG80xk1H/VN5YrN0XXQ4xfovUwO5yLeif7mLmFA19WPTvBKZignh
	 FXzHwDoMX3A29JGSrjr0GFE7ugtatiKkJLU0oH1JlPn35cAvGY97F8Pdq8U4qullKo
	 omz+qZEi9m3XsfX4EhL1kWeXHjoigYXDq23kc5Uw/Q8V9a9sQ7czWv+lVGB3gaoALm
	 mrw1jhXoRtUig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] Docs/admin-guide/mm/damon/usage: update for
 probe_hits_wsum DAMOS filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911135510.96914-8-sj@kernel.org>
References: <20260911135510.96914-1-sj@kernel.org>
 <20260911135510.96914-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:06:44 +0000
Message-Id: <20260911140644.ACF711F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added probe hits weighted sum
> based DAMOS core filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911135510.9691=
4-1-sj@kernel.org?part=3D7

