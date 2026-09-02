Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E21390239
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358203; cv=none; b=RbRe6Bxmv/z1Rk8ZLMsJuKjh5JFxC0EmCTnsoF1IdB3LtX2ZkIU6qfR9pkEPb5I3pkrgB7Wsy/VU5Yw0PwQwyFopAXJn/FQ1lPZFPmOYiijkVbw5mOBRCp/2I82g/CMZgZC5UKxMuKi9bMvxrW0r+gtvlf+uRW051E2sB+K0hDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358203; c=relaxed/simple;
	bh=fw3KmFP6nkz0VGjwQPKNjEAgd+FNftcovYB04yKVG0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g6RBncKEZctpyBMwvKoLR4SVyv0k6zgSBhW4VAqK+DKEUx8bozKNYMfsVLHmbQw/n+w7PDj1Q0THn6IiFDaKS1YxoqgX+xe1+pYDY48Ds+D5eqwAipiAZc5HT86jaRkMa7c9+hsLmjw/ro+Gq/RcI27Mwv3YCW83rIXRN0rQ5MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6DwyYJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6DwyYJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4D71F000E9;
	Wed,  2 Sep 2026 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358202;
	bh=fw3KmFP6nkz0VGjwQPKNjEAgd+FNftcovYB04yKVG0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y6DwyYJaiIv2Z5QTarRMlffT+x4Oy8NLDWOEdUiHCqpKmD3Z4rJ3seWJ5nuvvgnKJ
	 MUCxJT1k/m8oy5juuw0zFPMlKj9atqXuc/1yY5o9/kKaV5PFWwog6CQX8hMowF1Lef
	 6kS8fOynVWGXalQzNJ4Hr/O1LYtMnfwmqVn1Qhhs4NuLeABumwrMiyFV5T5A+S94E8
	 PCj79qLRZl0X28Pnw+AhMDiUWDfXfzgeREqn3ZcbT7xlNsOlWp7pPWQbKiDoABvJdN
	 N1YOh4nJcaRFq1BsccciFDRiI3XJAmbjgZMb4VjYGL+y5YfXE9CQX1ZIWoiJZ4Dua4
	 5S5UmR1U+HMjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] mm/damon/tests/core-kunit: test
 damon_commit_filter()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902140313.85983-2-sj@kernel.org>
References: <20260902140313.85983-1-sj@kernel.org>
 <20260902140313.85983-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:10:01 +0000
Message-Id: <20260902141002.7B4D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Add kunit test to ensure damon_commit_filter() updates destination
> filter as expected for valid inputs.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902140313.8598=
3-1-sj@kernel.org?part=3D1

