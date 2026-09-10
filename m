Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B47B3CB550
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052139; cv=none; b=PN+QZDkP7cOrnpH0N7HU0+j17snMpvSksUhTQMRM+BgZxPUA05EvXpsp1+llzAWI5o9mCYFwwVTCo4KlOPo4PP1HZoGwERPkib/ZtB4e0rDczlG0EnJiGFpJ7cVcK+PgBv5D2KbEB3uIooSRnP6MWQU0zSoZmXnLc11w+2ri63Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052139; c=relaxed/simple;
	bh=z0VrrIQtt5DoLHqzutv8y7qpQsQlNhGlOi4TdPL77s4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KHqiRuA2PERTU5rnDOT9l+1X36OwUNnOwShUZJz9UAPMsr8O9kudmgTh89QSvFDk2mGIeMygGpdaeId67aSrPdTubXBC83Z8T1ebu5oiCcI1oNS+VR/i8fg1z0NUIpGYsg1VE8N5WjO4vAkeVlYJ+E3xqXgLezBBG3hRZe9DhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDfDywXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDfDywXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A4C1F000FF;
	Thu, 10 Sep 2026 14:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052137;
	bh=z0VrrIQtt5DoLHqzutv8y7qpQsQlNhGlOi4TdPL77s4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aDfDywXn4TYjhTPV9RDGT+765jWAIaIg7ls2XEPOlMFY8EzaNq3Tx2QP+GV2/J5u1
	 7wl5imfaPrNJ6q6XYAa5fnl6VrK/SXcc8fcr0yoXqNC9jIsM5hfNETH52NHurjSErT
	 XZWsFR0jYdjAxpjKvkzVMcuH7LAy+G9UVEWyuGxSjh5IO5aP68ptuMxvAxz8RPYXiA
	 p5KxwzY4toT8gMYxbuLXIi92RwelNdhSWMvuWW64gBmZEPtgytpQViqotxpoxNQPCn
	 qeuHI40r/+uTnKn6P3jfiCOqmwTM2nvL+yWNLHcQ2mNOSOMUaS3QgN4TCzAFh1iNLs
	 yZ7c4SQx+NQjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] mm/damon/sysfs: support
 DAMON_FILTER_TYPE_PGIDLE_SET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910142234.171562-5-sj@kernel.org>
References: <20260910142234.171562-1-sj@kernel.org>
 <20260910142234.171562-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:55:37 +0000
Message-Id: <20260910145537.84A4C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Extend DAMON sysfs interface to let users setup
> DAMON_FILTER_TYPE_PGIDLE_SET probe filter.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910142234.1715=
62-1-sj@kernel.org?part=3D4

