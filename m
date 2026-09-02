Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B33859FC
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328584; cv=none; b=eb0pmW9sp/ni5fo1JkiiaN+7G0+V2uZ/w6vaLl2Yf8ZtUg8JmWVGgSHTZ0EgOAvOrXWMZyi5ES//HKhn9HrsQwg/4rrz4xP/meI3TaY19G/snPEO4HThUM7h1znMGdHzK66S7XCxqmpbQ8cFe1K/ceAgMqTbweormz6zM0etXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328584; c=relaxed/simple;
	bh=M490Yrs9cay9OngnbV25YEz3QN+DOcz9DFyK3W34bIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fYyj7iSmE9+29rYcof+Ehau5fl25zc9BufejXgb8SYx2Z4pX35V9yluVpVc4YzuObrFbs/+DnXBxKSd+Dkf76Iwc361wFCHb64DTfwBJSWT/f6jacPTzE7juOMLe6aVbT3EmBYsSfLdRNfRDrgCANXFsi0V5BkBGKXmTEXegYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJj6KcD0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJj6KcD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5894F1F000E9;
	Wed,  2 Sep 2026 05:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328583;
	bh=gMfG01BGMrlmgYwWsATu3d2aLeXyAPyufe5akby3L0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJj6KcD0/XCiGBmeotNkvgjLiOxSKQrRaTWVMPWOlcmJHlZ+dPAN7hjx/xO8cuOPp
	 qg63MYVj8dvTtLO4UL3+RTU3AdPJAcQJje+bQjupKVMj675jEiyN92i0H+ghts7fe9
	 Rk9AzNPBWZqP6w5KUPRBaAWk9AtqsLh1cM/Zo8nF4D+vFz06qD9ZPisLzODvcEwfQ1
	 IEF7O0dHLNE+F9yG5N61tdggGn8ve0OCS4fWDv7NGhFJu6J6elM+ed06wbK3NBLzI4
	 b26MGvPpKr+brpZ4sYLVl4ZsiyO08Oso8nGy93Ru+fkkPY7K6s/csTJK1RTlv1fvbL
	 4qE10R4QF0Ogw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] mm/damon/tests/core-kunit: extend set_regions()
 test for error case
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-7-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:56:21 +0000
Message-Id: <20260902055622.5894F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_test_set_regions_for() is designed to test only success-expected
> damon_set_regions() calls.  Extend it to cover error-expected calls,
> too.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D6

