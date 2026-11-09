Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186717;
	b=VFuwKfk2+dDQ0nxwlKLSYHfSv1xJKfW6FZVOlvxv2kw/FJur0ZLfV9P6xPfs9fcW4Yob
	 1az6GMGBUn+LQ0+mEYntEqj9OxWikAD4Bbd/NnUjBC+TNFxDQBsiA+GLKmpgYTMkFSTrY
	 KDizbaBxKyTLrTLaxeTUrorR59v26SC2M/6Fl+SOXYPYhuQ8/ZQZm9PumFG8MsENjpFL4
	 A0v6iXR3CsMgjxAD/rQ4GKm+8NBuFlJPg2HiiRjv78VU/bunYfOCWBl67ivFdR0c+m0Mf
	 AnhIB2emcvntrwmAkPM0VWVJd5oUJZGhRIAcdBO2Zk3p/xMQSlvi4HMsMK3uHDVHPoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186717;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o/wCbh/09eSp9H4AYoNBYdfTFWGi0y3B9a54ugNuxOQ=;
	b=hMjpNgJ1Vvl+r1O7wt9MtA2lGK5zxmFEnJsATrnNn6YXKGgTFa0ax+cZpGxFmnlY2M69
	 dYsRSgy+G/PUu+5zQrQq0XeWIsNOFPiJ6fpizTKhy8fluX8m1QSGOZQTXarRZjG0hmsfH
	 7gjBNDznz4HJCrpwOWbkd5p9B2yukW9P366KzKe7+BEK067TlrvR8pS1/QKv2l+A0qZ7+
	 XWIFUbwjGdlCLLQXV+hBKTy73aIt4h8TObYRF0UdkKQyrDgbtKYgKgW+Gl6IVjxmmKmcv
	 LUbDSd4AmrwtiLAlpF78uRBVqsmdBOcrAWeLsHgBlnPor2jLrR8wmny/6/tjStfafUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnwgoVg5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97873606A31C
	for <damon@lists.linux.dev>; Mon,  9 Nov 2026 01:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nnwgoVg5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114711F008A1;
	Mon,  9 Nov 2026 01:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794186717;
	bh=o/wCbh/09eSp9H4AYoNBYdfTFWGi0y3B9a54ugNuxOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nnwgoVg5x1tgpWx+h1ONoK2Vbq9wkF572Y+/RZz2F5RUJV5Er+bH0/Ip6X0xOoorF
	 17Vid9QGsZm5pI2cXMHsyEAwZzO5J7YukL1ByZyQ6WtEjs3tCfOwykW/+PYuRKJehE
	 ARgy1pgjYkCaX7S0iokUHOhkt9zSssVIDc9UH+pxXl1Fm3KoVdR8z8mqzhp/Oys0JG
	 qtvLCXhZCnl/ssUcEbuhLW3fsNeH15ZiydDBVIfJlltKJYFM7ptZbMU5o+DiiRWMOM
	 1j8K+DYtwDygI+QZVBAlz+bLF504nk4ccUwJV0UEYvaQuXNF6JoDMw4r9lQHwnpPnp
	 JWoQeLoVJfAMA==
Message-ID: <sashiko-outbox-204286@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7.3.y] mm/damon/sysfs-schemes: read
 sysfs_filter->sz_range only once
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261109005724.87550-1-sj@kernel.org>
References: <20261107050434-failed-7.3-af19aff38d6f@kernel.org>
 <20261109005724.87550-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:11:56 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON sysfs interface reads the user-provided size range arguments for
> hugepage_size type DAMOS filter twice.  Once for validation, and once
> again for assignments to the variable that will be passed to the core
> layer.  If the user updates the arguments in parallel, an invalid size
> range could be passed to the core layer.  Avoid it by doing the
> assignments first, and then validating the assigned variables before
> passing those to the core layer.
>=20
> User impact of the bug should be trivial.  From the core layer's
> perspective, the invalid size range is not really invalid.  It just works
> as having a weird size range.  No critical issues such as a crash or a
> leak could happen.  And sane users ain't do such parallel arguments update
> anyway.  If they do, such racy behavior is arguably somewhat expected and
> deserved.  That said, there is no reason to keep such races.
>=20
> Link: https://lore.kernel.org/20260914142327.92510-3-sj@kernel.org
> Fixes: ea1f204ba29a ("mm/damon/sysfs-schemes: add files for setting damos=
_filter->sz_range")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@davidgow.net>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: <stable@vger.kernel.org>
> (cherry picked from commit af19aff38d6faea35b10f26cca32d0e54f8aea5e)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109005724.8755=
0-1-sj@kernel.org?part=3D1

