Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853862E414
	for <damon@lists.linux.dev>; Sat, 15 Aug 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786804770; cv=none; b=c216rniiLyj4H0DsuWM07P/qai4CFJHfLtpJnlo7ip/YH8teSLLDpnJcKKz+0gU+TQ7h3NBtBg73+QNXs4GC3+j3aZuFSS5DByL/mI8yY4jgueVaKu2Hpdj5mkw/mqvPdh9WA2onfHC0YzNtsG/+koOJg0S0/qWySe1T8t0qfWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786804770; c=relaxed/simple;
	bh=1SWPmnCkAxCettAX0cBIE1a1R1pRzs8k1XC1XiogDRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g7gBbgVehv+B7pvELAPrv5Y2+nT5uHUc9Llq5vy7z/wgxIGxtNKlqpJ0YjOc8DhbXm+enuCDoq2a+0x3XaESeuezKvyvY406xaMCpNLSCmUmTOznaNm7wct3hdlVuJ2EiZbpBsqNyC3bgd4ep0rI5+LnHubOmgAozvjEFtyQ10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewY1ooDy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewY1ooDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C602F1F000E9;
	Sat, 15 Aug 2026 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786804769;
	bh=1SWPmnCkAxCettAX0cBIE1a1R1pRzs8k1XC1XiogDRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ewY1ooDyX0iH+7eKAEcikhAaW7VcwX7UWJDq1KWOd8D5KkjUrxV4nt3NDFjbsUO5/
	 xLJO76bVsjQiv9oIdEBDnVMQg/MSPRZLo+jNgn1JiSh2icmmFJFsjOTHwt1daULTJw
	 jiVhrMWnc5rgDvzfkSQqnzifzK5/YDeTwC8NYQ3VNkfpi/gYAPi4G5yGlTNNq8WWQf
	 kjV3jDjepoua1VA7qV8M7HbxyUo+0KJLEiZRQ/AC0aijhOYHUgHLRObNymdtgfN0LK
	 B1mqB/0FnJn3UichuRYMYkLS4cmN85dX/j0pTq3nuZP9wdVEcuF9C2YkH1gYEzh46k
	 gj/WDXJbGZW9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/tests: use scoped_guard() for
 damon_test_ops_registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaeyeon Lee" <jaeyeon.lee.dev@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260815143039.17291-1-jaeyeon.lee.dev@gmail.com>
References: <20260815143039.17291-1-jaeyeon.lee.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 14:39:28 +0000
Message-Id: <20260815143928.C602F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Replace manual mutex_lock() and mutex_unlock() calls with the
> scoped_guard() macro. This simplifies the code, improves readability,
> and ensures that the lock is automatically released when the scope
> ends, preventing potential lock leaks in the future.
>=20
> Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815143039.1729=
1-1-jaeyeon.lee.dev@gmail.com?part=3D1

