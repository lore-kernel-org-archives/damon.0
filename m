Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CDF279DCA
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807296; cv=none; b=fexixkcwOe/FQD6wqjK34V1T69JkC9hdNKddPVuwbSf5pB2Zp4HaB+tqfUnUNwNjvu4djBjXHEJt3CLDvSOgPWwwiEH4g/AASNV/+ENAOgcNgjh01YH4EKxM9RcQpWucAwWGn6CetVYd0YdBez0Flag8J5BCCqa6aCg2yQQ3xA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807296; c=relaxed/simple;
	bh=2AU9VYrfUrZ9Jn1A9fKRpit2OcYPeUx0HdyADfuzmqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sdHB6g7XXA5qjQgk0VwUxWwByjEAhZhCmtC0lgQnudcaHbO/1oXzP+Ttk/4rm3jpRGEIdTwDmnJRR0N/PbCKUMYtB7eWVitibZUzq9bXV7sq2vYN7K7o0F9ehfMwfDoFumWwt8pPlXe9whbHPryO/TSa9jq3m/aZUajndClyMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc5JkqWY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc5JkqWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6358C2BCB3;
	Fri, 15 May 2026 01:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778807295;
	bh=2AU9VYrfUrZ9Jn1A9fKRpit2OcYPeUx0HdyADfuzmqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Sc5JkqWYpG2lYOoKQ1n3+jHkDfZxVnOijFMtxq6sA9V55cdMhwg4EsKTJWtN7ySA3
	 0mNJoUXttxBY0y70MygH9oLQTC1sCeSfuDSaDlY9pqmsJKnIZ787aF6bANXjLy31zl
	 WXIVX+mJUO6+9Gyy1cufOXqzeFr5rjPji3DA7SOlXJfOGRTlJfkPTa0mei3D8XWL0i
	 g2mxLRE8CsDVqco3VoBZEsEcP/lMFU/an0fK2TJNXE/fB0wrE8jl7B1uq8byLJzw3w
	 GrHl5bjAI1AvDDFEMJnCFn0caCYUEiYeBSEWMuMLNuP73camARuBO6aUUA/ooWys6v
	 FijgV2icliXig==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 10/28] mm/damon/sysfs: implement probe dir
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-11-sj@kernel.org>
References: <20260515004433.128933-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:08:15 +0000
Message-Id: <20260515010815.C6358C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly introduced kobj_type structure 'damon_sysfs_probe_ktype' =
is missing the 'static' keyword.
--

commit 6edcbcf176b612eae059c59f709c455cff251235
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: implement probe dir

This commit implements a sysfs directory to let users install individual
data probes.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 5f3b253f50ebf..c028e4b1281e6 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c

[ ... ]

> +static struct attribute *damon_sysfs_probe_attrs[] =3D {
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(damon_sysfs_probe);
> +
> +const struct kobj_type damon_sysfs_probe_ktype =3D {

This isn't a bug, but should damon_sysfs_probe_ktype be marked as static?

It appears to only be used locally within this file, and omitting the
static keyword will needlessly expose the symbol globally and might
trigger warnings from static analysis tools.

> +	.release =3D damon_sysfs_probe_release,
> +	.sysfs_ops =3D &kobj_sysfs_ops,
> +	.default_groups =3D damon_sysfs_probe_groups,
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D10
