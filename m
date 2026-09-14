Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D246D0A2
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397222; cv=none; b=T2Vxv0lfoSRATwn8r7hkLuf752a8I3qFDq8ZuykXRfRhdbxCa9x9aG1/LltrwDLK5pLLIZUCzYRa0eAahXZ3k1JmpTeN4Fk2iHnbm/GoshIgV52kvv5tTZo+LV5kgX/a5jIHzRWNmz45zDebTuLjNPhY58GkrAj9I8nodQvFaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397222; c=relaxed/simple;
	bh=7MuK61K+JdS65/Gwfj+S0/jJDNc4LLOf+Pv2Dg9ELUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f9zRw1M0mwBNAT93UALh2XtRwNtrZqtO2w7xYzkbBcbAIfYOBdW2TXE9FO8zd9uXzAiPhrtoL9iw3r7VJAuCJeLbJuDbfRh2/G6cRof3OT1IyiT2P4NFv6HN+JA7/9g5GWh9H8ybmY8dRR0JpFT3uKf7q99kSX3/Ix80m+t+lbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORR/KXvY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORR/KXvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A82B1F000FF;
	Mon, 14 Sep 2026 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397219;
	bh=4Vvaso1DDUwim42MshZRwUkNhI4RA3H3lu80Mzy/Tp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORR/KXvYprztULhyj5Q3WTXQKrTukOUf7dQlYC6DoJAqn2UTXdTDKdaVOqW94pRgy
	 /kepzOOfVLYYLp5MtCXz+NOoNKkseI/Y+bRWpWAymFiHBK5w9aVqA1GI+4SMaICUAV
	 Y1DEu/fy93zuvqTDMh1iQfeQwBl9BxFFqucv5m8qeKuqYIrMgqi6WSgr21vNzSeC9R
	 F6Np1niUnsDbVpOTGvWzKd0LJdTeopyFqJZSLXk7cvD5Gw5AXhUm0AiiuMErbV14u0
	 Q/WO79I9BS7iVuWvudMeMVxG6sN84SjPN3Q7PBEEmlQMqPNu+cGY7Ek63GvgsXk+hY
	 cSyrUWry69Udg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 8/8] Docs/ABI/damon: update for hugepage_size
 probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914144448.93732-9-sj@kernel.org>
References: <20260914144448.93732-1-sj@kernel.org>
 <20260914144448.93732-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:46:58 +0000
Message-Id: <20260914144659.0A82B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> For the newly added hugepage_size data attribute probe filter, two new
> sysfs files are added for the size range.  Update DAMON ABI document for
> the new files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914144448.9373=
2-1-sj@kernel.org?part=3D8

