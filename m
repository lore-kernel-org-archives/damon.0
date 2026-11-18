Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969007;
	b=lDHk460v7cpqCsyi9RUbKveLlDiFDW0fGVM1JQlaXS50L2gOteKp0FVcbrgm1UJRhRsh
	 ldoLi0zxfS9oO5fxydCexpopdzSWCBgrcpvdVRZAHJS9j+L/XnA5mDLOmVWa/AFZ7/XDj
	 6mGqSwV+PUOpwW7ZWQoyNUhyNeRk/nqHdpxB09K9+m9Ib9GuqXOBZ5H9UiD6b17tcdkt3
	 iRWNIyYfyPQQd/FNXs7TO8CxwFO39+GHq7hwaJNiZFq7rWkB3Obzzmj0I/0sI8yJNdx9F
	 sssEJBVNMa2FQvJANkcV7uR/Yu5C8pJEeNOEXeiYAwxvkowFat3eJDKWlF/+l063hNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969007;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GIo2Tf4L6/GbV5Tvmj/mgedlT5qlEI0BBdBqvMc/3jM=;
	b=cJGYI1+9Sl+ldakdHQG5bxCuBa+eko6J+jiq6sNZHE0RfptNCxg/RQqYtEgUjavULSiV
	 5BqSPEPatvJ9FOKRotna0jwZ9qrjMRc/EBXYVtbQyKi6NUi3k5OQRW5jhdWsB4Pbgj64e
	 fsvqMGZUQ3hMXLZmRAXiIj3zZWn2fn1eMF+lOp4n+f4/4od7DUBOwEeKIpyzGU6QdIXHN
	 vwPH7yGMHkIFwfkOE+0bHHv7bARucx/W4L6D1s7k9Oz7EZpUYYMhctjTC4ZTlNfQAZmSq
	 lPtI9ssVSOohDXLYsrxppEPKpRTE9onI3jcbddUtEI9ObUCKfeKFrLzePYYUua2FhqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ee1UL5wz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1E2606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ee1UL5wz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41551F000C9;
	Wed, 18 Nov 2026 02:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794969006;
	bh=GIo2Tf4L6/GbV5Tvmj/mgedlT5qlEI0BBdBqvMc/3jM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ee1UL5wzFyU+usA6cI3bdKN2WDhJJUdlm3QCXKb+nmKY2osPEoIniKYjMRJlBY2uI
	 LguQ1vOOioKVs6AvKpcLueqrModv1j2IbAfAYayRoajPJCERhoHFihdJ02RHAoafTt
	 nx4laI3hV9nTNiz+0V0j9n5CbFfx7KswF8/3Xrgkl26g/Pt3yqYCd+W9hbZqPv/xZw
	 wKcaT2yC4UnuawTYV2LKoB4x7d0WhasZzibXYnc3eLNPgr36hjfOX+eIoqGMOxjJ0y
	 Uw2AkmXxsnrxxIGV7zUTSdASaDF+zUwX4nRCZ6+zmtaWw3k09g+98sLcZpIjFc+ag/
	 xbmkjXENEGBNw==
Message-ID: <sashiko-outbox-219962@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 24/27] selftests/damon/sysfs.sh: add basic tests
 for admin/reports/
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-25-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-25-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:30:06 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update sysfs.sh DAMON selftest to cover basic file operations for the
> sysfs files under the admin/reports/ directory.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D24

