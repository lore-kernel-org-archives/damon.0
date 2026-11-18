Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968787;
	b=v27vhWOdYHh7beCH2dvR52RAEe1z6PtB7oaTc8qp1cZ/hLjkg3AppJpvu8L/ULrT4qXo
	 YtPi8Q3UwnJn0fws8fime1ctWcMeO1tMubihz+t9+vTMw4Z4G5BfL+Ihp0X5SFu5xbwvg
	 3Hu71rOAsryYdifZ52DuFpvKcQIlkdIBcfzra2SBeCmHGRUJ9CZk+/1HFh4a+5yNgQBDu
	 r1s3e/MT5u1gcKrl6cl+ijty0rRrKgAugCzM29RUI0nMokxjUSkQYL2nST0muZzdx3txI
	 JHlzweEqz3zpCt1phD30Ni5Lvlkruq7nfzLYDC0bq6duEwoPaWOC37r+9P7nE3ck8hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=82Ce8Fr8BZHiYle88LD4ojBC8HBNPuwVcGis2pjysUY=;
	b=eDh4oFpPjsg4l4PzSahtdTJKq+Nt+GuV+acNBzsXtNRx5TllOWd6cFOgT4cMhHCPmVgF
	 Dg4uKuovXcU0Bu99+pF9aJZqnv2zXeuV+8kpUXGb/XzQBqPkyXGT9R3+XZKJ2fDKJQWnA
	 HQsJiqMaDPKqfv2s5tUzV4hWKgc5U5Kv6Dbx0fx6960vzuVpZCKrechaUulReZHMFuOXW
	 CoVtwWlO0AS1DRs0N1hQsiT8H0qoS4YOFQvQJ/IwZMDHvNeCHuTZ4V+PcY9cJkswYLxXb
	 +wm+ZLrUXbKMwgpdk3vj66OIRitER3syRxRw53daY/q6BFyAhDBdrLG5pJ2yUbKzRGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1HbI2BB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2B606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1HbI2BB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95E01F000C4;
	Wed, 18 Nov 2026 02:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968787;
	bh=82Ce8Fr8BZHiYle88LD4ojBC8HBNPuwVcGis2pjysUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P1HbI2BB8jFI09+Dt4fqk4kNBXVrOdzFItr0nwAJiX00tzEeFvjZpP4PDEC+cSaHi
	 Sw5yrxoKZCtAEl5mPd10r7AWbB0sbbIQ5SPweQdYympOP5cJCRfGYlOyIW7XuzPz32
	 mv+jQGJYoDE7Mz0SA75ZMpYIb5DXPG9/OxfyjSsoa7sDxApsO58nuhZ8mkrqbrPj1w
	 GXcVtClp/d1JrNWLcmGbme9y+2HnFp1KX7V+al7VhEkjb0p9BAFdvaC+iaPVskbM0A
	 ruSq1VzIRTkMEQ5p7T8QOdn5Moq15Fh+tdx/3TDpiTN6rnb1HXFV1tv+/Sj7IENhWh
	 g5Ce+h9HWyVNw==
Message-ID: <sashiko-outbox-219941@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/27] mm/damon/core: implement data attribute
 report queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-3-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:26:26 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement DAMON core internal data structure for queuing received
> data attribute reports.  Initialize the queue for up to 1,000 reports,
> inside the DAMON init routine.  Destroy damon_region_cache and reset the
> pointer for the queue setup failures.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D2

