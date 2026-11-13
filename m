Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585873;
	b=v4sqAVk/a504NJR7brGq2Z+bGyKOsBdxwuNAPV0T2QqxdRoqiCC228gjGoPuNeEr5b9g
	 +nM764Rnf9d4s5YJXusVfZBadNyNd704ySJDRUIfG7d3GKPJbjNioUxWqNkIEWZ6P3T3G
	 ZLXs376dKwxn2DDcB0PrtXOdpkBNedh6rdSdA6y2Mk3Uep1ZWIU9dlV11bof1Wtr1EsQn
	 xAtzk3p2MlQ8EJyJ+hrMeM/XpeiZUvPSs4bkhb6AptpuBorp2OEC9fgUCABauJFGnz32Z
	 OnMGwT+YDOrHTgp1e948c9JwBWV5xV1rt7Apbp9RKBqtBtzUNA/b8XCzJc+4DLF92gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=29U9m/GtTCklHtdlc0ar16ANUs6vifDSopHgNV5JGlw=;
	b=IPIB92MEixRWKc4wUjnS8T/6EAnUZmt+B6T9iQW+M9V6GgcwM8gCHYlkoPBU2u3b7T2C
	 WrZ9/PqBOn3W3D59zpBK6z7zw4LQm9YNibX9siCU2FSlXYArqcIQv+yWFDjw/I9pEJnjH
	 WzqEAcL6qaYELCrjcHb6AuXWvMMQChM31XECNmFYu8zVQ6iHkQHR3MmV+fymxD05OXr7o
	 Jt87pydvdItVxH0wm4dEpaxBeQgkL8/lqSVIAd7+i/2NqZfzKgq50ym60+Ba5EOHM9GOp
	 pDs/FXargHHmwfMEtaWQnLnvgBRvnXAeeCFkcblnXkin0QtEPgvuJA0Rbji4Ixv0+wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HESgn9fB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BFB606EA86
	for <damon@lists.linux.dev>; Fri, 13 Nov 2026 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HESgn9fB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943171F000C8;
	Fri, 13 Nov 2026 16:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794585872;
	bh=29U9m/GtTCklHtdlc0ar16ANUs6vifDSopHgNV5JGlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HESgn9fBYbj9rKEqLmIlFhsO0DHkJ6WvixKVjfyKqX8iyviTfDUq4NVq2Bg6QKMYu
	 JTfIUFWLJP7ZVYMx4CJUIVZDopWMLFpN3wyYJOHIDs0NA8W3RtnUXOe3zPWNX15CrO
	 PW+qGS0cPbiN9soxN3HLoXjooB2dc6bhVc/IBt5HQnhszRmPba+2zGjqAAPu0RwFS3
	 vYHaVKAn0g9kZ1t64ZMs2c7TEMHQwmF1xaYEDEeGW6tWs5KZKsnSLovyYxTHO9vd3Q
	 sZUUbsmr+O6DX4nXXL14aPvhxbhdvrBFMoBJ840WMBYq6YZ0jPbflu5DkcI0z1lx8V
	 gkkYwpEKkVr0g==
Message-ID: <sashiko-outbox-213149@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] mm/damon/tests/core-kunit: test
 DAMOS_FILTER_TYPE_AGE_MS in damos_filter_for_ops()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Angelov" <jasonangelov@ucla.edu>
Cc: damon@lists.linux.dev
In-Reply-To: <20261113-test-age-ms-filter-v1-2-b99eab2f71bb@ucla.edu>
References: <20261113-test-age-ms-filter-v1-0-b99eab2f71bb@ucla.edu>
 <20261113-test-age-ms-filter-v1-2-b99eab2f71bb@ucla.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:04:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMOS_FILTER_TYPE_AGE_MS is core filter, not ops filter.
> add kunit test covering this rejection.
>=20
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-test-age-m=
s-filter-v1-0-b99eab2f71bb@ucla.edu?part=3D2

