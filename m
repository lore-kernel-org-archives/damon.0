Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036376;
	b=etGAOKzLkOJGekEHsOS/yHVK/VU27REu79kiKsjcAGOzGac3PizJHkVhN9RqQwGXQTV/
	 IxnvQRrucGrres/kfw+rhYfVStgy17vtsCmW57nBqDVaUp3xkjwMz3DqrFuiMB3yhzZQJ
	 cZ1qD+FyeqM72PI/1xUqcb5muzxa3X0YbFt/RvBBYVHssTJdNo6HLwZRudOg2DdDV5EoY
	 vQ1ZnVCSpG+R0O7U+Q7ybL/Q8lBzIqcCmipxR58qM7YAV9Q9GJHzPfOak8LZvQfUbr9jS
	 mep0QX0T3+Wr5hhl8kzK2Bor3SsuAaYAykdFmTwhms8kh4sfDc1ORQecWrP42NQlcYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036376;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vqJKj/+vMPxvkLgk+HZHWVFuHrW+qvIM0t/1LBFXagU=;
	b=2932x4CWq1JKP3nQT58k9ZuRl84t9kMZbdBB/FghkEpM5Lr7Iq7p8ieW3g3yJpD3N70L
	 ORzflGc1I7s2mKFOxmXkl6yQZgMmyz9iaBPFEynzDJkUIMFvH4kN8p4zmrOvPbrv+NdCc
	 eifyxccbc77YuA6U60lvEhH1rMNxGbIaXJC/ywc1BVsxEDOu1t/Mw4RQy+VNnF9ixO1av
	 zdNDY57U0RNMi0CbBWpbT0CxXIrNHhuZPs41zbJgGx6+lKfXCaFH+0rdJ4kg6bYvtsW/D
	 bgGIlmGOuzObrd61I897uiiWMG+v1qTHi+TfvrFHr/lV2qw6XkT+QNuj3RrHb/EoMiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzEbGBrd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F9606A32A
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzEbGBrd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82D21F000C9;
	Wed, 18 Nov 2026 21:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036375;
	bh=vqJKj/+vMPxvkLgk+HZHWVFuHrW+qvIM0t/1LBFXagU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FzEbGBrdxXhs8FvKy2K670D9gYc2vppesn61CN5WjZyynS3UTg+KSPc2nqrDtWo6f
	 CD8L8GJCy//6sPNvn0kT9v+n84h33+Mw0GA9Tc8YU1aCGNroK4MzKdBhiOLtDiG/7K
	 JEayKo/gH87jZK0+EyZuP4ld/tnki0TPr0XYQDG4bMjx/Ghu72YpVZMAcOpZE/aZKL
	 DDl1lzZmmj4pv8CNY19kp2i9Sm7Vx8BeZVGm/8jMGXmZd+VrRGSap/pwDIbi7qcvvk
	 xlXYUG9HKrPUrEwDPNiG7XddsiikxQEm6zb4PImrOYELFPIE5KLLSVUDZjoBIgJg3r
	 imouGyZ5GLAcA==
Message-ID: <sashiko-outbox-221980@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/17] mm/huge_memory: mark folio as accessed more
 accurately on split
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-14-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-14-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:12:55 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Kairui Song <kasong@tencent.com>
>=20
> The behavior of updating the folio's access info isn't consistent for
> huge mapping splitting or ordinary unmapping. The page table's young
> flag has to be translated into folio's access info.
>=20
> Right now it only checks and sets the folio's referenced flag, which isn't
> enough since folio flag updates on access have their own rules. Ordinary
> unmapping (zapping) calls folio_mark_accessed(), and it also checks
> if the VMA has recency to avoid false updates.
>=20
> So first just use the right helper here to be more consistent. Keep
> accounting the young PTE as a cache access, sticking to the current
> behavior.
>=20
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D14

