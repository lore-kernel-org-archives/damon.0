Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827466;
	b=l6eYLcyoWeqjEmApzW6Tgdsujarh8iDaXtBqma6ciq7qT8mwsxg+dJ/3+2SYC2sAj+Jt
	 EUGoAzou+I/1HavocdHVPrnfzlUnF/4Lcs3wWgQO2zdpw+Cdrpfj+jCKEVXqa/vCYiray
	 hR2k7ZOlYaOU7Gyfdw/kFIhjKZJ+ti43xIO+TSfBbYX7aElLkyyhN6l2ohrW2GORJVDge
	 61owna1O2E5DE8lghy4iMUJggA7mDp+DqopsDHGYzq5qOrMDQO4GDqlc9TlXulPauJSSQ
	 DEU1hOH1bv51+Cu2KkMnhpgg2lu7myPsfnX5ZEBTS2WXNUAphE0CpYdxbpbCdbxVSUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827466;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bzLQTHKM7PVQSxlrdOQrKsQVbmNMgxbpJB2qZNodJfA=;
	b=fZ5fo772TqV4vgJhgUlSakM/yEuRdfbxwyXdzwfxqeiLGhnVE5KC+/ELPWzQm9/ZZoFy
	 zZ0NSUHcIIFUuPjzkmuDm1oMABDeh577ExDm/p4BRcKrLKL/W5PYVptDZKTTfNeWQl3GW
	 VQe2Y8M12SQoes7NQkvMNcIkHtyTehi2hbYH19j6gV3Wu35Wh3wEzILfON4iIUwOu8Uoj
	 bKf9GKXi3V/eGtiwx3CpUmTP/82em/Lz4WFeGZZnzU4L0ZNBOmXxDJrVUJIsPvqn+6IUK
	 KfVYwtk8LXbx11JZn2zaqE2KSrdbRvfLLKuvr5w01VYwVfHaWt4oG3fjUcRfOv2HHaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owOSpjwR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADD60837A6
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owOSpjwR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B141F000CC;
	Mon, 16 Nov 2026 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794827466;
	bh=bzLQTHKM7PVQSxlrdOQrKsQVbmNMgxbpJB2qZNodJfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=owOSpjwRWb2dYt6ffHDBnusY95jIIULVnN+eAlP8QlrOhahoYyR+Eeuqm8lrO75jZ
	 iOXJbsxeAN2cFbdZWFr/VbcFW7cADoClcuy1SCfm/HvZtmythiKoSDBQJ2J9P7gYxt
	 LApwtKhkFFhS7w0OAvvHjxQmJWEaavFkqMKkRVzM3w/K4dqPXU4lTNlyjforYQsZ1/
	 ljlJQkrxFzY6dYvTJCylUU69L6dNXqE57mD6yQHuoCVUk+fMBOgILm6qmadQxzRixR
	 YIMWCIDl06GRQf/Hz5lFvl065sRjrUArf+PtXY6FAfVbl6MS5o2jFKmz2IpvTfA/0W
	 ZE0b2nYsMJAkg==
Message-ID: <sashiko-outbox-216854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] mm/damon/tests/core-kunit: test
 DAMOS_FILTER_TYPE_AGE_MS in damos_filter_for_ops()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Angelov" <jasonangelov@ucla.edu>
Cc: damon@lists.linux.dev
In-Reply-To: <20261116-test-age-ms-filter-v2-2-3b265d59ec98@ucla.edu>
References: <20261116-test-age-ms-filter-v2-0-3b265d59ec98@ucla.edu>
 <20261116-test-age-ms-filter-v2-2-3b265d59ec98@ucla.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:11:05 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMOS_FILTER_TYPE_AGE_MS is core filter, not ops filter.
> Add kunit test covering this rejection.
>=20
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-test-age-m=
s-filter-v2-0-3b265d59ec98@ucla.edu?part=3D2

