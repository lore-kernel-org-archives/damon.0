Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E18490C10
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398283; cv=none; b=sQNYxorPTPgkAhDt/+qSSLhuLE0zjAIStj1d19/6m3MpBF8Mc96mzS1yoaX7qkpdTpCTe+fPOaATOEr5NgJrlW8FxV9ILa50Yu9AvlE9JRlVGkMWRDvytdYk4+NfAOGVKFxmxEcuCIiCXT2XxKjR8r0RZeFAxiYaGVVaExQfNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398283; c=relaxed/simple;
	bh=ShTHyPfrDZTmnLaAkBzRKdMsbVKiG1oaKytUNR3lwGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NNARaCytqQ7Ai8uMJKAGPDi+7f387WyZWbAi4i/tvtbEEbqdWg0wbaPujmK8QpE7PoI++eFfhV60HHEVAkXv/NXRXYUFdOl+kDGpIBDMVrfK1RWn+6ibgBIBGjSP4miub3+8ylA4lGFuDf5IjTA4gE7qvTz0clVjk0Ma6o57Gu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEIgXHA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEIgXHA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA5E1F000FF;
	Mon, 14 Sep 2026 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789398281;
	bh=ACwj0rCJxzMAyfhxXslVXARq05byTQK/zl1By+kINB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mEIgXHA4P0WV2yOJ3LNDHt/ziaxw3bXZl+3NrLripKTLzsHJiz9Fb0rVGg08dwoYP
	 VQSBProfORvBFVG9jqGy7Uzc5+WVO5Dk6EiyRca1fCbLiTdIYTtBWpgPveSxrBCeco
	 dEvezA+Ne2BbSZ106osgHdgzOpiM3M7X4qieV3o1QuW72cgL7JGrm7aFs4PBwSnkcv
	 WI4Pgfc2TTWKlGEpK+yLqeR/kjE+zYREYhC4RBiuZp5jPfWZNnee8bWFAPH/l7Bu6H
	 jq+pv4JgEd4sOTz2xUIIqEDK7DcFwWkyJ0YDJR2Vge94qoRXxxRQqsLg2JZpL0O29O
	 6GqapZtTLZdTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] mm/damon/core: return an error from
 damos_commit_filter_arg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914142327.92510-4-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
 <20260914142327.92510-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 15:04:40 +0000
Message-Id: <20260914150441.4BA5E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_commit_filter_arg() is supposed to always succeed.  It may not in
> future, for example, if the given filter is invalid.  Prepare the case
> by modifying its signature to return an error when it failed.  Also pipe
> the return value to its callers and let them handle the error.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914142327.9251=
0-1-sj@kernel.org?part=3D3

