Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16903B4EA4
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483191; cv=none; b=PdHE9kRHHjhZPmaV/Z+lcE0Na2pMm1Nk2uf2g7dVtpMBD6sWgWmLECTP4VxfW/aiv6MdkjTJ4gFf5p3IKV32P0BjDV75QxKKr6E6p5fyARyBZ3ZV03cIGkmOE84jjTeMr2vTLUQOQjn2NM0DBB8ZSqioUj7+M/+smfrmYn8btqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483191; c=relaxed/simple;
	bh=HrP7YlL/H4vM/w981LDGzi3DiBMvU9RUywn3lrhh4LY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X86qGBKIsw1UVnp4ACPTgxcYPr8RoOdGilHq/+YCjnTdFKDalJ3nGDBCjC81ugInurFi8jr4ob9tc34YqpY86ZLoA9wO2Ciug5QxDo0GIPzcA6+vT1B7N51UBtFc659qCk73v7rGfMr1FwbjyRPEDW+1qeIIMSaCQAYnMrKmRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQuLnchJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQuLnchJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475871F000FF;
	Tue, 15 Sep 2026 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483189;
	bh=56q4d41o2D1cDBX2vJsaze0cdkITAw/1yyhuMMNwzkI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LQuLnchJ6nXGW0mPJPY/IFyRv7I2D6cGBDcDz3t1WtzRoXf7ITvftHnnOEVD+e14+
	 Uw45SCnet35v2r00LqnMRyEB2/aQqejarU6XU3rzaz9z+HgbHaaFDN8ZLahHrA2x7G
	 wjyr5JJOJ1QNR2rqqbAh+v5K6cFkvgtdWGpXxO0To3YU/GRl0mRAXNa4BRuAwR0LRc
	 JjlBdE85kfP0WgO2ClMqMG1CQB6gBVNK+cSFli1Hrm3K3V87ytTPexhZ0zlBeMraRT
	 1UYLMroHdwqtVKSowOR3lRXGwAJptIKLIDYDdPByLM0qviNmTSklbAF/ETHbG98BTF
	 ZLbEfeSEun9NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] Docs/admin-guide/mm/damon/usage: update for
 hugepage_size
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915143359.91472-8-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
 <20260915143359.91472-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:39:48 +0000
Message-Id: <20260915143949.475871F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] doc: grammatical error in damon usage documentation
--

commit f587d7d9920741b1ef2aaf02c04d27dcea002f5e
Author: SJ Park <sj@kernel.org>

Docs/admin-guide/mm/damon/usage: update for hugepage_size

Update DAMON usage document for the newly added hugepage_size data
attribute filter type.

> diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation=
/admin-guide/mm/damon/usage.rst
> index d3e37400367bd..6b80bce5d678d 100644
> --- a/Documentation/admin-guide/mm/damon/usage.rst
> +++ b/Documentation/admin-guide/mm/damon/usage.rst

[ ... ]

> @@ -308,6 +308,8 @@ Writing a number (``N``) to the file creates the numb=
er of child directories
>  named ``0`` to ``N-1``.  Each directory represents each filter and works=
 in a
>  way similar to that for :ref:`DAMOS filter <sysfs_filters>`.  When the f=
ilter
>  ``type`` is ``memcg``, ``path`` file acts as ``memcg_path`` for :ref:`DA=
MOS
> +filter <sysfs_filters>`.  When the filter ``type`` is ``hugepage_size``,
> +``min`` and ``max`` files acts as files of the same names for :ref:`DAMOS

[Severity: Low]
This isn't a bug, but should "acts" be "act" here since "files" is plural?

>  filter <sysfs_filters>`.
> =20
>  .. _sysfs_targets:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915143359.9147=
2-1-sj@kernel.org?part=3D7
