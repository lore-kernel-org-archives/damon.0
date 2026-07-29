Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732732BE7AB
	for <damon@lists.linux.dev>; Wed, 29 Jul 2026 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334586; cv=none; b=h28WzTxrIZA+xUJs8IgWGN3S70oN2qfzPfJV+2zLCWZorQF1ef3AUIk7AJ3kuD34GaNszkwo+SqdPV1tiR0ajQZOSbTaa35ENH9+75zl/ZEyyNEIAYDLvLy59LOyf+HbI0eBAtMLVasLEmJTZphrhvleQSRtTGQGvCT6IZbj23Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334586; c=relaxed/simple;
	bh=orJI44A2a+tgzpWjD55HCGYtISBZvIbAZ+ZXBxwKQ4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jMpqWOP1cd2X3T1n54uk8LDrhEXaD7IZYAQ7gbshuqNh3cuVHIisXIwXqSb3KXiy0V4OTpKglRI03CRgve7DYVx0888CpobwTMVjY63TU+yxev4EpPb/Ey/b5RjW7+aS255YyPmJYvOfZIjznEH5pUAa360qDqzsc/6s2N9lZXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp68xETD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp68xETD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24191F00A3F;
	Wed, 29 Jul 2026 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785334585;
	bh=5qS/X2PhQvw/X0y3jL+iOCLPkPzXhQ+Jln0VokanD0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xp68xETDAUeYJ9gbyVVs6jFK3FaFgLQ5UhlG8SKGTKov8kttH/QGG5qKeuEl15Da3
	 xA9Syz9wBet3Opd0JxUSMufM9FJOLQuHLZuqrz0uEEOS0XS5o4JRr3RgH67bhm2Joh
	 MqleSeNKrgPl1jzaBcoRjpd9jbHBlIN0AmH0H1iEX0XkL2lFutrKyNnyT6XYZy0xsD
	 aO2ysidbYEiPC91S9r0G0VJRnrEZt4zwtONgEeri65fkE1ZN+linfFee1g8CEyPfxQ
	 M0tsUYqlcZVCBesPlbsYEse0FtRnQ7rPbsA6l4c0bwHbMTPaw4InuU74sKaxKMhya/
	 Jx6FR+CyQbWwg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 05/12] mm/damon/sysfs: remove probes number
 validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260729140253.87753-6-sj@kernel.org>
References: <20260729140253.87753-1-sj@kernel.org>
 <20260729140253.87753-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 14:16:24 +0000
Message-Id: <20260729141624.E24191F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the upper bound check on `nr_probes` allows userspace to =
trigger massive unbounded kobject allocations, causing soft lockups and OOM.
--

--- Patch [5]: [RFC PATCH v1.2 05/12] mm/damon/sysfs: remove probes number =
validation ---
commit a336beb0d20022011c91edc1b40bfb3902ced157
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: remove probes number validation

DAMON sysfs interface drops the >DAMON_MAX_PROBES validation on
nr_probes input, intending to let the core layer validate the upper
limit instead.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index e3858ffab4b22..85dca07169c63 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1234,7 +1234,7 @@ static ssize_t nr_probes_store(struct kobject *kobj,
> =20
>  	if (err)
>  		return err;
> -	if (nr < 0 || nr > DAMON_MAX_PROBES)
> +	if (nr < 0)
>  		return -EINVAL;

[Severity: High]
Does removing this upper bound allow userspace to trigger soft lockups or
OOM?

If a user writes a very large value (e.g. 2,000,000) here, that unbounded
value is passed into damon_sysfs_probes_add_dirs() and iterates this loop:

mm/damon/sysfs.c:damon_sysfs_probes_add_dirs() {
    ...
	probes_arr =3D kmalloc_objs(*probes_arr, nr_probes,
				   GFP_KERNEL | __GFP_NOWARN);
	if (!probes_arr)
		return -ENOMEM;
	probes->probes_arr =3D probes_arr;

	for (i =3D 0; i < nr_probes; i++) {
		probe =3D damon_sysfs_probe_alloc();
    ...
}

Since this loop allocates sysfs kobjects synchronously without
cond_resched(), will this cause the system to freeze or exhaust memory
before the DAMON core layer ever gets a chance to validate the parameters?

> =20
>  	probes =3D container_of(kobj, struct damon_sysfs_probes, kobj);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729140253.8775=
3-1-sj@kernel.org?part=3D5
