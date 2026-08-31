Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF488472093
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200256; cv=none; b=D+AasiIwnxYipyNMOeli0zRV8MHUS6+xT8OAg9qQ1zSVO+mgNh6M2pYP0jQe+J1m3Q5GVxunOjBc52DtEbT0bEQVn2PKcDtI/gyoeE5W/gs5Ykt0S3TuqEWQ1adj1qKgkF6VzajAJEnTXCQ7njdJHsjmWX45gmejRz/jUoivE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200256; c=relaxed/simple;
	bh=My6IoOI9aDxtVkNBUKRYdYmDHf9ObZpm+tUR1Ina9rY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gfTG0ruPDJVylS48Sgnw8hnG9ST4drZFWyH0K5M2BbrY7x2FearCL7to9cV8XF1FbIh1OooKKy0AxMG9uXtfO1/TGRDw9NvrrdsHmsjTYIJ38MF0fNNKEF7MdxF9nyn64s0Qd12DyL4fNMN7Z8gEZdDZTpAVp47ujyupb6aw5Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTJAA582; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTJAA582"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7033D1F000E9;
	Mon, 31 Aug 2026 18:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200254;
	bh=08cAvps1iOpVn7MSJ9flQTmCLdNQCivo+jiQAuzvAuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dTJAA582MTFZy3qzQgVkEbIui7q1quip6WSKpav3ulkiEoor6zXB+6Laa8XxQeprY
	 Wa5eHV0SjOHf2Qscw4QpiEjUGRkAVoDg368/9Yf+hwSNK6QBbiR7bRYlsOM/qgH3re
	 zL7OAdG8Q8fp27k0C3RSytijZBmzX3L85xO1Jm3jDbyH4MVXeZ2H+fgcgPibwxg+/o
	 D7Uc2hklAMSzjFy8QyBRx9YhtD857oL17uW4L0+aXaUqbWJiFaivSXgE6/0HEht8h6
	 r/zOMnR66hAUgN9WbgYv01+N0EHusfCgTwdju/seQpKT6tsNdTwhkuN7vZPWPrupA6
	 /yGN4fFH8CdAQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] selftests/damon: prevent remaining cross-object
 state pollution
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831142611.77572-7-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
 <20260831142611.77572-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:17:34 +0000
Message-Id: <20260831181734.7033D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
>=20
> _damon_sysfs.py defines constructors with mutable default arguments,
> including DamosAccessPattern(), DamosQuota(), DamosWatermarks(),
> DamosDests(), IntervalsGoal(), and empty lists.
>=20
> Default arguments are evaluated once at function definition time.
> Damos() instances created without explicit arguments therefore share
> the same DamosQuota(), and the other default-constructed sub-objects
> and lists are shared in the same way.  The sub-objects keep
> back-pointers to their owner scheme, so constructing the second Damos()
> rebinds the shared quota's scheme pointer to the second object.  An
> item appended to one object's default contexts or filters list is also
> visible from other default-constructed objects.
>=20
> The shared state can corrupt test configurations.  DamosQuota.sysfs_dir()
> derives the sysfs directory from its scheme pointer, so operating on
> the first scheme's default quota may write to the second scheme's
> directory.  The wrong values often match the defaults, so tests still
> pass, but the behavior depends on object creation order.
>=20
> Commit 8319dadcbd81 ("selftests/damon: prevent cross-context state
> pollution in DamonCtx") fixed the same pattern in DamonCtx only.  Fix
> the remaining constructors by defaulting to None and creating fresh
> objects or lists inside each constructor.  Explicit arguments keep
> their previous behavior.
>=20
> Signed-off-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831142611.7757=
2-1-sj@kernel.org?part=3D6

