Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67E48EBE8;
	Thu,  3 Sep 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788432360; cv=none; b=urm8SkBC3O897YoB6fWloeEmH8d4Ov3nH5bm/718t7rNtT4dynXL+v2JTiwoWfkxOt8cSNOYiYlYFbY/KGoH4TmX9bpwiE1rPpn091c2x3oXtlWgXGPOQtEGEEZCvoKV/ccdIfTPqQIGJ9U0rXws5LZ4DwA6an9sc/wzVCXaoI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788432360; c=relaxed/simple;
	bh=C0oL3UqeyZdGOSjmzc4EZnL/cchO/VVWF0NIt1FY0P0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dIloGZyXdz8SARbFOQgqfHFljaU5cSnoqawVUnmblRcaA/sCIp9yHT+35ndZrLun+ooRdvjAb4UueGsQ2AS46L0CecM8ZcTisKMN7KsGxxNPequjTv10dq7aSDDVmL4AdGsceyhqetCiYToS+5ZXnS2NdcM50zPSi0CDKRS/I30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8HsYZ4W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8HsYZ4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBE51F000E9;
	Thu,  3 Sep 2026 10:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788432358;
	bh=C0oL3UqeyZdGOSjmzc4EZnL/cchO/VVWF0NIt1FY0P0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8HsYZ4W8Z1zqOJBRdk6tPXXobFFOVhpamfriWZn7izV417VMmiZ4zpB4ugB8H4NK
	 Pm+4KLtdGoRwCNN3oVzK6gKH35pgwdJo9yXIG2j9qJUJ61xrsPn2WVyz3Yjsxct+Kg
	 Zkvc+s/9XWDxLl5ciRcEr5YOilmyAlntXUCsYdTXT/ycMR+OfY8/vZL4r9hECSGCaK
	 N9BytSGfHr8wKhYt6KI25aMiJI3w7qovCflpIV87X157CHhb7EbMzXmSAMok+D0O76
	 6GKCDIM9MRwDYvlQFwzer/DXQeJ2BxEvEgUvh3TyRn/l1lr+WHxcAJBBHUGL1UpQsN
	 N11g44KXO2wPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] mm: convert PTE table entries in ptep_get()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: linux-perf-users@vger.kernel.org, dri-devel@lists.freedesktop.org, damon@lists.linux.dev, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260903103002.1091859-5-usama.anjum@arm.com>
References: <20260903103002.1091859-1-usama.anjum@arm.com>
 <20260903103002.1091859-5-usama.anjum@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 10:45:57 +0000
Message-Id: <20260903104558.6CBE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> ptep_get() now accepts a pointer to hw_pte_t storage but must continue to
> return a software PTE value. Add __pte_from_hw for both generic hw_pte_t
> definitions. Read the hw_pte_t table element atomically before converting
> it to pte_t.
>=20
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903103002.1091=
859-1-usama.anjum@arm.com?part=3D4

