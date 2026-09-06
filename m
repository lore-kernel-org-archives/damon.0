Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FD536B935
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720632; cv=none; b=ebw2XwpoIUGHlWAkdZ170QQFmMJkqIqPJw3RE6zoCR6e311WUoPe9EiXedoMXxyLofI1/Ir1BWXrQXbmL5E3EXupXpZTTbEvx5LSscKqdDLG+dgMC+gCGeFYogJhrMTnSXID+y1Ly4bv24inBaPi5cQYJ4dASUBXFPeJb3nW5zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720632; c=relaxed/simple;
	bh=A/UEXCthQcVnFYgY9FD6Nhajs9VjwMiSvmYqoFH/t9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RlpMPfst2y0qt0cYqPTw9m1KH8SWZxm996iyDIaY30VQJzBY0Xgao/XKmYYD+Apbf0ZtAdgUhofgwdNHY6xQYbCChRjov1i3py5rlCsUbfl2rhMvNpU88yODETtIRmGPd/TbEzu2D6mYFI/lJBbBB2WQQSng3BoDtG72CncV3wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noqP1Hhx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noqP1Hhx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CBA1F00A3A;
	Sun,  6 Sep 2026 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720631;
	bh=SY4qMwaSzpri083axXSQvaImE7zo27F2PzM3Tv+6sQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=noqP1HhxsmvKW6XjtnWdkcoImESNA/uZBcoQ2ABJUqFJFrR2fQ+0K4xsQDFfH17U/
	 TQq6KQAl/0e1oJcFCNv3kNcfgZDcPnOWn+VHsEQndLTI4iHfpxmZ+T8ItaQu4aRLgE
	 O/scQ2/9Y0ul+HmKACvnpr345PInI98fv8iyhNpDwXa0N7RA3RRgKwHVG17NOkTOng
	 i2rTBEankPEyZ2T7j5zKpeKX98It04xU64OUJ720wifF5NgN0ShNmsOiwWjU3ixDfi
	 1feiX34EwItHeT6EBlDbdcRw4PnIVcqIrVVOq/w8XtahaxRGN9T0mh98PtrRAeJpCg
	 DIa+R01f6FnKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] mm/damon/vaddr: support apply_probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906184417.96621-4-sj@kernel.org>
References: <20260906184417.96621-1-sj@kernel.org>
 <20260906184417.96621-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 18:50:30 +0000
Message-Id: <20260906185031.04CBA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set (vaddr) is not supporting
> apply_probe.  Add a minimum support.  Do not support hugetlb pages and
> PGIDLE_UNSET filter type for simplicity.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906184417.9662=
1-1-sj@kernel.org?part=3D3

