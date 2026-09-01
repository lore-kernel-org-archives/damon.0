Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BD63A16A1
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237335; cv=none; b=mEunZbqqxqwXyKBqhSG00F4xHVtffxKUl2wuAqx2GOhAkGwqp6MMDCACns2v3wDBEtlnr4HgmAnmsc8QiezsC0c0UUWhiluQxm4NWZA5Vx9++08WoQ578xjnveqFW7qhOYKXl6bGJ1ibvXB0gIS5jxIH5yVc1VJfpGqavD/BPyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237335; c=relaxed/simple;
	bh=bXoCebXPjw4gMHobEKbqPdIkhapGRnUpZUSR8LAF3fU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MIuvtYnEDtImuVahktW7A3aQlbkHTvnIXy0bQv18A5W5wtrOgf2790rzlmQ1QsbqyHKgIKwTa8mHVAjiA2hPhDQ/kjdUl7iLLFQrvF+mtP3pL9tG5DGf4QZ/M22LfG9YSqK63U651xPiz+H4RA2ezQzaw80UdC52Qr9UEE5+G5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZGESNos; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZGESNos"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4401F000E9;
	Tue,  1 Sep 2026 04:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237333;
	bh=qWJhYLITnm+SxIKFTnWm2C2eVz7qdpyYbCkw1dP7+Ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WZGESNosJp1/p5axr4NIwb8vW7KBf5KJO8CsH8PmCjT5/ezRdzzV0ZoOMcPBy2k/p
	 4iVXqlhmqwYZjqKwuXpq05LZt4OyB8rUn83itoAQLJ9g2ADyLLerIquqevsvmTzRu8
	 bNtD+X34yMSsxEXWsYRyliTVzzb0JE48E3jS0/DqGJb/ANm6UTNa9KXkCMj1OJFFUH
	 pbxHwtlOxqe5ewTzEuYGF+ZhYBpMgv7sMmryobCl1MU8A1AHcGezt+0NhkOrcu0gwc
	 bjNmJxjskye8XZg/ai0Xh/frbzShJ9RM071Gy4DRrzRSWYsEtqWDok0Mp5bkYQtQSP
	 eSwUZcndjZBsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/17] Docs/mm/damon/design: document pgidle_unset probe
 filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-5-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:35:32 +0000
Message-Id: <20260901043533.6A4401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added pgidle_unset probe
> filter type.  Also use a list for the types, as it becomes not very easy
> to read the whole types in a simple sentence.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D4

