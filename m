Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2C44682E
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792089419; cv=none; b=MYSu9IGnLvwv6Vdt5QxLEZk2m4A2rvVdCRaH+E8E0LWXFayeMVSF1/yAPYp/z6ERG0Ji8gFd8UlvAmvbmCi4qWZvMMF/M10Oiw5mtbCDNyV9egYX2a82EzLcgvQQXBJPCdyiPS+iA31hoJYNE4IcuO2tYqIoJ1ECMOeFm4c6an0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792089419; c=relaxed/simple;
	bh=ld008Wr6pPEPLn4xcqHHwDwPYBrpzc/KRQOzKVTx9wU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ISZ75BDUkY/pEH9eMHesOqHPYDw3YoCJsi9huW7xxdvyUgFtnBAQ1B3tFtELsJa+RZDJPbd8daU9F5U84+cYlAmr7vmlEod9lT7ouOp1nhxVU2eHz5bqN4rT+y3A14WsoihCccb0WayNffVSOOvosLfaJ/VVLlxqWjonpNPtvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWv9Vhdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWv9Vhdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211911F000C4;
	Thu, 15 Oct 2026 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792089417;
	bh=ld008Wr6pPEPLn4xcqHHwDwPYBrpzc/KRQOzKVTx9wU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BWv9Vhdi3jk2LVMaF5jyM3E6qONmGzSZtpV8XJ3zhmzzO5k7rlWxW4QKpD5dQFKvm
	 tlzQeTrp+MeOgU0wCGh7Wblw36QO764D19EjhALSyn433AwBIMacvb8UM6apLCHwWZ
	 1f+UsJZ0+CNPH2qkJ5TTezMMx4C6Jvxr99YOEBM9gD1EDlL/hhXIAzqS49CvKPUeC7
	 o7tWebYGlYiaR+6gbGwjfobs3bk5aTOt62/bUdXaQcNlC7cJo89ey3SH8qbmLffOWy
	 OVIet14PFxG34kgU2WQAmjYuQVPdzKG1bpyI/48ZUKVu6VYIfk1r6DqKCWyUrSiZQe
	 8Ysb6ldzAMeQg==
Message-ID: <sashiko-outbox-173310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/17] mm/huge_memory: mark folio as accessed more
 accurately on split
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261016-mglru-fg-v4-12-2106750c0bfa@tencent.com>
References: <20261016-mglru-fg-v4-0-2106750c0bfa@tencent.com>
 <20261016-mglru-fg-v4-12-2106750c0bfa@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:36:56 +0000
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Kairui Song <kasong@tencent.com>
>=20
> The behavior of updating the folio's access info isn't consistent for
> huge mapping splitting or ordinary unmapping. The page table's young
> flag has to be translated into folio's access info.
>=20
> Right now it only check and set folio's referenced flag, which isn't
> enough since folio flags update on access have its rules. Ordinary
> unmapping (zapping) calls folio_mark_accessed(), and it also checks
> if the VMA has recency to avoid false updates.
>=20
> So first just use the right helper here to be more consistent.
>=20
> Tested-by: zhaozhengzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-mglru-fg-v=
4-0-2106750c0bfa@tencent.com?part=3D12

