Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012622;
	b=cVVaB5Eb47wRExBl3IoefSF7e3+/5gWPV+kNhyPlw/ufGt5YbOiQzPLVVWrw9Q7RP5Ek
	 cR7xWyQq5eRTzY7T5BQZxARhwSj/r45FqX8o/8YuC9NKsmPzTlKdTtrIQTYbXjtNJmMI2
	 12UoaFnc9OPA2qloRN4jfmJJJZZnkI3X6GIrwCdOkLgm7KqL1K8Vd1u7B3GAsc9fJBwlr
	 nopKkeMkS2qZH2v1EjD7epRzZWATIr3Jke+0VLng5NMb1mL1RFA6tfJV0v/zEJ+BM+oSX
	 PH965+1FoAAYbqch1e9NQJT1D3a403ialaQ4UijSZfCVtiuTzKTwktTzrzdCbVyF8gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012622;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OYEGNebjvvY61dsVS0luDPvpML/EzfKQ8GGvw5416pI=;
	b=FgdNYzK3bnIOGBtpnYhmEvfpqsqVq6sQWeLOzjch+cDLT2hiFNDeZ+jn7v9tyZ/vQ9KU
	 QxZDIrl4OKl6fypMeRZXRAiGWB0xfiVxi3NbVN/DQXlTmDwd+dczl+ZQGTv90T0EG83L0
	 /hivz14VktE+bWsPY/jOk/FQulE8JPxY3p75hJQO8qmUrlr9dDUJZ5yaFU38VJ8SWhnsJ
	 2LxC/l6M+nUw324v/4evd20w1qZ0xlK1YrPPU8aQaOlFUz6gQg4F6JthqoY51k3Jt0CyZ
	 KWu4IbP98UKlu++8onhWUwQdoij7GAGkmliYxUZe1CvdBkQZc1kCUEDw1egxVZ/7r7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxPh2M3w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8779260A261B
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LxPh2M3w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED91D1F031E5;
	Mon, 26 Oct 2026 11:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012622;
	bh=OYEGNebjvvY61dsVS0luDPvpML/EzfKQ8GGvw5416pI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LxPh2M3wkb2ktjVFjYVKyVHjaFmhfSHDB6lRjTcUrnwSgD112iCfhPk6qwx9T4eFE
	 zmQqXnZPkqA4XRsZcpq8oXjir+cPgflZZFAAzzH9rJRiyB1KcDagAgkqKIAaFxuLJY
	 IfOptWZTuRLvsP7chkOHRRH+IgBPf4lXd+LoHo9MxlPA3r3BoQ7Qfp2ahNF9FWkK4Y
	 gXl7dWwJ0QvKPQBU9s8tGgmbXP1HmAJv/mb0lVOZHOGCHTpSUeb5hIZSsKBQW2lNVm
	 bqc7DO/exaTZvcEwjwz2iWOfS7/LDh1pf6uZK7Jl7ZhpTvg9p6KJlpnxFbHjAvkfYT
	 Fn+18YJx5lQRA==
Message-ID: <sashiko-outbox-185046@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] mm/swapops: remove unused make_guard_swp_entry()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026-unused-sym-v1-5-82ca2dceabe1@amd.com>
References: <20261026-unused-sym-v1-0-82ca2dceabe1@amd.com>
 <20261026-unused-sym-v1-5-82ca2dceabe1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:03:41 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> make_guard_swp_entry() has no callers.
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-unused-sym=
-v1-0-82ca2dceabe1@amd.com?part=3D5

