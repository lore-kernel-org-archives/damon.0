Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49278F2B
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 04:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013692; cv=none; b=nli5m6IXFKa1zHVZuF7fOS1DTINnb+MjGK6FiQHTmftWUYGXJDfmyaoLkxuWUj69PH5eStlayMH0uXJub0tHwXHcEFF8lt99gtu80/YaJdLl1g4bA7BFAlRNolKMDAqz+rxJKf3k4y26uHoM77PHp8T1x8OjdWFoopS7lL8B+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013692; c=relaxed/simple;
	bh=OkIcKQQE5TBrVOUfczkjdc5zmh2xahBCzY8Zb6mF1os=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WMEjPa5Ty3pfbsV+JmtHb1mo9qS2m9PFXzhvehLbclC9gKQJCrJ8sBJ5ESwlLZ7nZ8K+ze5Rd/Ws0SpjP3TgPIAImHbYzkX6otCdhRkwYrKHeDw+AHeJy5scaHDNyO7sipSMDDco36ATImogSOR6h3IxZ0+R5iRRDoUysAPXVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTqGtptL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTqGtptL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5124C1F00893;
	Thu, 10 Sep 2026 04:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013690;
	bh=nBpbn3+cOhvqXjWglTEFlO8tuUbw7Ggm9fie8PASMNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTqGtptLRCTD67op0qU6yEDI4TQOpVNdLBymuyT7UcUdqyAao85VwuSdyLgoKRpLC
	 z7pLj3jrDEBGbzYGPwug5jN4DDpb7pXhDa4jKphGQSm1C8bpBjKuq5ry+EVvpPWgI5
	 q2Gge5LrC6iIxqKpY4I/OHwvQKyyOohcxtrDHdhhc9H5IeCEDYjqiT3QIZmXGAVdWB
	 IcxwYAC4FtoacvAYNQSmgBykX5GFCDJLsrla/PBoHdbcV/+IRqrdBecSV8P0k3caOM
	 C1Wczl2A4BHiriSLIOxF0zQmQKUuBpSeCl8eH8gE1brpemKJUId7gXL7Ozf26++GDV
	 S4Hgx7U+Iiuqw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 1/5] mm/damon/api: introduce
 DAMON_FILTER_TYPE_PGIDLE_SET
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910040911.148273-2-sj@kernel.org>
References: <20260910040911.148273-1-sj@kernel.org>
 <20260910040911.148273-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 04:14:49 +0000
Message-Id: <20260910041450.5124C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON_FILTER_TYPE_PGIDLE_UNSET matches only memory that was able to
> confirm if it is marked as idle.  If the memory cannot be marked as
> idle, it simply doesn't match.  Hence, finding memory that was marked as
> idle with only DAMON_FILTER_TYPE_PGIDLE_UNSET is impossible.  Introduce
> a new filter for the purpose, DAMON_FILTER_TYPE_PGIDLE_SET.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910040911.1482=
73-1-sj@kernel.org?part=3D1

