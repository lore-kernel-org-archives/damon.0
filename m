Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0133985
	for <damon@lists.linux.dev>; Wed, 29 Apr 2026 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446122; cv=none; b=Uwf3vAe8VdJGPOYUTUyX26L5WwiUSk1s6rj4krCt1jwgmYtr+ZXHE+m35J5xdoSeUxmqZsRoDD+HFFi7YFLOYyVkSN6hty8uPXQQYWsZXok+obshikhZvUmyu6qokpbIM3GBHBosAEQG3dywQhYFtA7sCp7r0lw8kFA/Ms4vBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446122; c=relaxed/simple;
	bh=yxbWgYCgRWzdDhmOtW7FQDNcl7xainP+avnXeyzHsrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oU65z5ieCtGF1PZiQejRgqoGtE/s8CRK1CgKzva/OiWAXjhYSkHWIVyO4qEQnKiksX/B5XnS9EE8lADGpqN7bzKqKW4vHivi4nmCo8Fr2EmDnSPSzJ5TQYrsfMwDSVw/qREX+0eNBA8WiWEOBC8s2QK3TYkuNUfckbnCDm+To88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRurCdf3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRurCdf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B80C2BCB3;
	Wed, 29 Apr 2026 07:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777446121;
	bh=yxbWgYCgRWzdDhmOtW7FQDNcl7xainP+avnXeyzHsrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BRurCdf3x/5XZxXAo09vS66jOxYWw1bMu5Jr2jgzxxSKbrrJnJ3IrBKnAHAxbWtZg
	 v1vD0408lWELFjatz2T/+Qsc10SjqpGYIB5yyJXY5qZKq5KC4mWzoRToQziGrMmkjE
	 ATrJLN0sT+6IKlcZtaVdBSQ5V0V8bN7daT6QrznNtGFusshhi9CKdOQKxR7C1hu4iM
	 agOp60h2B0JdcLj4bq4us8+eZhGTYlEKTv3m7cA35iVWA0STNUDKE0gjRxihPg7Ick
	 9jlVVFuT8Z6x+4pmQT+os5gsMmGPGO2fakfCgq+f/sMwOqCv19ewlT2NrshPBefjX1
	 N4/NnCQtutufQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] Docs/admin-guide/mm/damon/reclaim: update for
 entire memory monitoring
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260429041232.90257-7-sj@kernel.org>
References: <20260429041232.90257-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 07:02:01 +0000
Message-Id: <20260429070201.A6B80C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit updates the English documentation for DAMON_RECLAIM but =
fails to update the corresponding translated documents.
--

commit 0775463e5909bcac92ff21d728b9a1b112304371
Author: SeongJae Park <sj@kernel.org>

Docs/admin-guide/mm/damon/reclaim: update for entire memory monitoring

This commit updates the DAMON_RECLAIM usage document to reflect the new
default monitoring target region selection, which now spans the system's
entire physical memory instead of just the biggest System RAM region.

> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentati=
on/admin-guide/mm/damon/reclaim.rst
> index 01a34c215b66..57ab8b187650 100644
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
> @@ -229,7 +229,8 @@ Start of target memory region in physical address.
> =20
>  The start physical address of memory region that DAMON_RECLAIM will do w=
ork
>  against.  That is, DAMON_RECLAIM will find cold memory regions in this r=
egion
> -and reclaims.  By default, biggest System RAM is used as the region.
> +and reclaims.  By default, the system's entire physical memory is used a=
s the
> +region.

Should the corresponding zh_CN and zh_TW translations be updated alongside
this to keep them in sync? The translated documents currently still state
that the biggest System RAM is used by default.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429041232.9025=
7-1-sj@kernel.org?part=3D6
