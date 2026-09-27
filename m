Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E73B9937
	for <damon@lists.linux.dev>; Sun, 27 Sep 2026 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790511196; cv=none; b=QWo/DCgyakNldX7Tv4SoZu4+oBQRTOlWKNZeb6VmMKjbJEV/dca1r+pU25qfXreIO4oN7d13OEl2VtC6/ZB1yYH5UJoqO+glZBtU4Jl2sBjSJ8l/TAaKhbGgxE8it2wvV7O4eoZxPdxQQOeF2eiZNz7PirqvHhp8hj14sZqjbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790511196; c=relaxed/simple;
	bh=PMKO2EqnX0mpIX5L1pa5ltfFIquhUNmWvSkc64r7sBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GivlG1dh2RjmzYmXRW+cLPXI/9LpNJEitNhoUZo0l+wEttP1wIu3iR0c1NcMmry3a87Pgbp3nCYvaB+BPp3DYl3ckSp0MzcFwh3EJdMp6axm/1DwVSitsL8gXOHGQmyuQDdNxbqLfBvrepsU5bgrd8n0BCIOVDsVAwn/r9eCYz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUc16vxt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUc16vxt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CEC1F000FF;
	Sun, 27 Sep 2026 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790511195;
	bh=NUWGWxULwYMlB9iwILU35uCJE1ZeUN8iYKtgLq7VDQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bUc16vxtr0Tv2w5c/C8oFgaW+4ai95EaUP/V3FfnbMg9k3Bgf7fhmkhB5ZYgxVQ7E
	 kMGq0JzwP8bP1MClnS/Z03t8reonUmT28Lq+l23xAedLJTUe4S9PsVtsGYY7rc20Q1
	 KXjcFUKXMqILEjjBy1EIIjQ9L1U0Rjql/eX9KlDJ7XhlHnSEIYLjRMJLy/ScHVjHuO
	 4kPgEZ1MLbJ8hmWsIQN6kYXA4B82zq3iG+i2uSx5Ra8QRha6GnQLtrvo2ATm0nUwsC
	 xaxRXc9431AlX689qQLyDv5bA0D6zgIZa9uiF17i0Eu+dWtkSDy1+5mFQ3wcFxaCn4
	 MiI7jJ0ND2VuA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 6/7] Docs/admin-guide/mm/damon/usage: update for
 quota goal complement file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260927120533.50484-7-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
 <20260927120533.50484-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 12:13:14 +0000
Message-Id: <20260927121315.31CEC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] damon: build error in core-kunit.h due to typo complementfalse
--

commit eec8b1a2e73ee2822f8574a7a1b78a43cc0fed67
Author: SJ Park <sj@kernel.org>

Docs/admin-guide/mm/damon/usage: update for quota goal complement file

Update DAMON usage document for the newly added quota goal metric
complement sysfs file.

> diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> index df84d9cc7d204..6a13d9bd377cb 100644
> --- a/mm/damon/tests/core-kunit.h
> +++ b/mm/damon/tests/core-kunit.h

[ ... ]

> @@ -930,6 +932,7 @@ static void damos_test_commit_quota_goals_for(struct =
kunit *test,
>  		 * Make it kfree()-able.
>  		 */
>  		goal =3D damos_new_quota_goal(dst_goals[i].metric,
> +				dst_goals[i].complementfalse,

[Severity: Low]
Does this regression cause a compilation failure when building with damon
kunit tests enabled? It looks like struct damos_quota_goal has a member
named complement, but not complementfalse in
damos_test_commit_quota_goals_for().

>  				dst_goals[i].target_value);
>  		if (!goal)
>  			goto out;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927120533.5048=
4-1-sj@kernel.org?part=3D6
