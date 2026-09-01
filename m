Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8936B06A
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269724; cv=none; b=uTyXsdouRoOM/jXxTrk91MXM+FDMPaf3fqpcb1rnS9DfdTHnrjbQ5AakAshrbKY32j8xXZJBN4oTxiEI64Sbr2/xKIKKcON2H/a537hz0qewm6rGVBcOKfs+CAjXUYn2tQ7RKG+1MGBeEN1Fga/CW8LadsmRN5oPVARVZ5q+N3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269724; c=relaxed/simple;
	bh=NdVIL8LruyB3o/ADs+pvBuXAoSFe0DWlIfAAb4PSRpo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fmdWfkORIYccGCSG6g/+AUWfa4fCPPZbdp8XOtt6V4jw6N+pIIpiY5gKHHDZjnfv4AaqipONfQZevGP2kh2aOC8fQA3MdnAdbAfnGv+2Rx7bkY5pVCus0KvKorDQkh4im0hq8LLHesGVG3ci9rBVj82hkaPZBuAqRIrrjcDBZvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJU1X81o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJU1X81o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F81C1F000E9;
	Tue,  1 Sep 2026 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269723;
	bh=YXhJOSwpkkas0DY0qEX8RCIl/aGN/B5tsRlg3g5hN14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KJU1X81oKg+YLay3JTjNWOlpHWCr3Sw98cJLpOE+33DZh9ZTvvuXHn/NKeON3kaZp
	 xOOg0Ccdg+wEaom8JMgKszsxj7CVlSymGGq2MLCx5gimAx/sQU9S8FAyX9x9pbtjse
	 Ts6ww09xAX5sNa+VhLVFPAgb5JOvUeNV2PYc6gJJ0qxGytsbYQxiAd40nJVG70NZnk
	 SOLoHfPVgMK6PQ8KuukOBNH0445wdw8hBfbgv27zzGIw/RcyALJ3b/vzFC24wxg5Fp
	 Sx9RlFDb8qllJPTKQ74EhbIU7NOX8F8UvbZFu0Ks7dBB7HsUrIZIcT8POjKQ+WqNcp
	 U19kE6uGyGNxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] mm/damon/core: handle extreme memory state in
 damon_get_node_mem_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131850.98037-7-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
 <20260901131850.98037-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:35:23 +0000
Message-Id: <20260901133523.7F81C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> In an extreme and unlikely situation, si_meminfo_node() might let the
> caller show zero total ram.  That could cause a divide by zero in
> damon_get_node_mem_bp().  It could also show free memory larger than the
> total memory.  This could cause underflow and make DAMOS temporarily
> make unexpected behavior.  Thanks to safety guards in the auto-tuning
> feedback loop, that should not be a real problem, though.  Fix the
> problems by respectively returning 100% and 0% for used and free memory
> queries in the corner cases.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260328133216.9697-1-sj@kernel.org
>=20
> Fixes: 0e1c773b501f ("mm/damon/core: introduce damos quota goal metrics f=
or memory node utilization")
> Cc: <stable@vger.kernel.org> # 6.16.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131850.9803=
7-1-sj@kernel.org?part=3D6

