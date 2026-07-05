Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAEB371D11
	for <damon@lists.linux.dev>; Sun,  5 Jul 2026 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285662; cv=none; b=T9YhRiLkTJHu3LhWlUw6EnBbx/Kt7TG35wTIxJt+od5iYHTKEwo23+VkLgQvLTXPYFL6PyrbfZDDmVx3XIoqeMjOXOgeP5yhOdubuDQ6uHAUbAcyjInqnvp8ps+AhXM1Py1/T3EpOqyceNEDrJsJzYdgAGYdsLyuWXpfmDDJ+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285662; c=relaxed/simple;
	bh=xbBaZwWKgodZM3TQ0UiqnaYViTMJr4hqM5hpZq6BWv0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xhz659LS4muaTx8+WhyLCEJMQ0/toUGERKquChwGYQx6ZOGGFM2XHTAJ29knXcQ5uhXzweOqQuGG2KksaqlawUHQtpMgrz9lF0eqUr/lY35NRe6SE96loQufXRRhojuGEYqUy13ilTIKOqhNEFue0JxPnCCeNWg0E7SBx90WLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv21jYkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv21jYkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F62A1F000E9;
	Sun,  5 Jul 2026 21:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783285659;
	bh=3QUmCPZiLZE6GxNPLdjt/Vu4lqE4y9+dxp0AjIh8uno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lv21jYkclrElJu/fC3Yab0RI4z0HonJLNAKZGD7lqJQwYT0XcFZ9Di4E/ftcVi0Gw
	 wr3qb7LfgIZp/5ALQ1g666oZIx6Ox6a9MKp3QNDQhgF5E4TdeL17xY9VYuSZCUeI1n
	 dNYAgwqw7xwkQBu4ZH0HnFMqB+Bk8/wlskoCPzqlFMBIIn+lhjze4iN4tVcdtqmKGe
	 QzsohI8YqEuDeVbyWY6eY+3+tE1ZQY59TYeIks/Gc+6ktLrwpFTrnttkFjTPbA2Cde
	 g+Qb56wlbIxxSAe1jS+qrg+5P+lLa4Gn9CQCctnltikID1QtWr2/ZjAP2WWb4hKZCs
	 EnsWNY3t/5A1Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/16] mm/damon/core: ask apply_probes() ops
 callback to set sampling address
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260705205743.98656-3-sj@kernel.org>
References: <20260705205743.98656-1-sj@kernel.org>
 <20260705205743.98656-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 21:07:37 +0000
Message-Id: <20260705210738.5F62A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Malformed kernel-doc syntax and typos in the `apply_probes` documen=
tation.
--

commit 2691e8480612ea2e98837a8db1eb30da170cf383
Author: SJ Park <sj@kernel.org>

mm/damon/core: ask apply_probes() ops callback to set sampling address

This patch updates the apply_probes() callback in struct damon_operations
by adding a set_samples argument. It allows apply_probes() to directly set
the sampling address for each region, minimizing unnecessary iterations.

> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 257a4769296ab..7c82cd0c2f29d 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -646,7 +646,8 @@ enum damon_ops_id {
>   * It should also return max number of observed accesses that made as a =
result
>   * of its update.  The value will be used for regions adjustment thresho=
ld.
>   * @apply_probes should apply the data attribute probes to each region a=
nd
> - * accordingly update the probe hits counter of the region.
> + * accordingly update the probe hits counter of the region.  It should a=
lso
> + * &set sampling_addr or each region if &set_samples is true.

[Severity: Low]
This isn't a bug, but there appear to be a few typos and kernel-doc syntax
issues in this documentation update.

Did you mean "for each" instead of "or each"?

Additionally, parameter references in kernel-doc typically use @set_samples
rather than &set_samples, and the &set prefix seems unintended here.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705205743.9865=
6-1-sj@kernel.org?part=3D2
