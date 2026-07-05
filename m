Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72C1369D4F
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285495; cv=none; b=eM3KLIjws99ha0GJzC8F9a9R2dxBdX6E4Yk+d0hwlIIkKOodA6lMuVA8brR/GXGkursBlv9M6FZ/V8QwZ4pNBok606hbKs+qNPqKQtQe1vKwfFVIEvnSJyFHlgA4bTeOIsLpE0nitGUhTYTw2sgRuZSdJECDLV6uZrZgBafV4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285495; c=relaxed/simple;
	bh=SBECTHNB4zUMKv7MPAurpCxt9NENVzDpwYnt0kTts8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CEP3PAXmtqLh6bILqWKIayYZl11k81Z2T+mmZs/Dme99S9QfHNg9uVFgU1jafVNJxX6emYpNt9bzSu8ZcG3GMjd97QP5my+YgG19AR60qi30rJPp4kZgN3rq1AeUVPLFhFsSaw4wgdBGg6JOWgeTKBtwhXW9pHthmiIyXs86R3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loIMeiZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loIMeiZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FC51F000E9;
	Sun,  5 Jul 2026 21:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285494;
	bh=3SySlFZr8twNYUH4jC3MGlUIOHqoBJnZHSGcQ+WezaE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=loIMeiZRq8t6bg9JuK+xijD3QPw3eby/qWse9jOWlkL6UDB2fM+QGBxG6zK/sN6Gu
	 1mr/Pn+S5S1Et8bqLvV/DFZ/tB0vTmpiMYOw+D/8ovsYQi4jDRwYbyxL3nDUnQv3sT
	 /4W0/O8csF2T5QAHV1azc+I2z8ULH7Ag1YSA1BNbUq9FSYWeMkTr4Af7Mh/qCJJL3N
	 cZc3eWAkO23Pksjin4olRmQxVHOOufGptlDohl0Ez3lQzrAtGWJV7ejOySOirjasVp
	 yzp/1VnFaFnpkb3CA1vqh7vlplHekKO8/9RvA0z4C+4/eHYjkXbwT++MGtrjnp4NTZ
	 NnAX0AZV4uo3g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/16] mm/damon/core: introduce damon_probe->weight
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705205743.98656-2-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
 <20260705205743.98656-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:04:53 +0000
Message-Id: <20260705210454.34FC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing kernel-doc description for the new `weight` field in `struc=
t damon_probe`.
--

commit 4be82423c8a2e9beb3264e298ab3af6bd580eea9
Author: SJ Park <sj@kernel.org>

mm/damon/core: introduce damon_probe->weight

This commit adds a new weight field to the damon_probe structure. The field
is used to specify the degree of the API caller's interest in the data
attribute of the probe.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 616bdf0954b52..257a4769296ab 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -763,6 +763,7 @@ struct damon_filter {
>   * @list:	Siblings list.
>   */
>  struct damon_probe {
> +	unsigned int weight;

[Severity: Low]
Should the kernel-doc comment block above struct damon_probe be updated to
include a description for the new weight field? Without it, running
scripts/kernel-doc might emit a warning about the undocumented field.

>  	struct list_head filters;
>  	struct list_head list;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705205743.9865=
6-1-sj@kernel.org?part=3D1
