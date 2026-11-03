Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793677599;
	b=LtuULQcFs62te90zbFKsBMvG9g4oPP1ztlU1+G1A5XYj+AsJ1W7up8l016X2Q/XwUD4r
	 dRe/J5EWNP33uRInGXJQYiy1TMgQEPYfysUXRKhuMSYpiwvwM5qmCXzam75F970IZbGpE
	 2ipMNMfXXOO5odLMPgLHojUjfdkmPpjz+5i3gkyIv864uG19ZELezlS99ekdcX8eVA5Oz
	 f61BkR32jqfbpmN+91rt2r6QhdwxL/aNN8GKPY1iLRBTt3NvC2NclViutxhFNndY343d0
	 nUZqd+cCJj0nrlrOW0+tUCx1IWJF9lH3dSGzsKIY0ZlMuUI9GioUEHagzoxg02KoIeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pwVj5oxfVRTyQKfsqEoLZWoU1i/N5apZIhXRJKLjNU8=;
	b=499Qy7s7KQV4SEErpodfxFt43/DdLRGGSJHcfJkTwoojW1pFxL6QGQ5bAXF5ugSpiVQs
	 +kbzgyvhX6V7fXqb456ZeeHOgIaRi2k80aC1K4utDRvX0CwgCj2QYNrItKSM4yfEblCIQ
	 1T6O3dC9d0NPSnD/wts4azilWlr4/kU6Ox6eDmPODMpZCAE3VcMBJ3Kj5Kz+eZtkkvHGa
	 7GXFhocVt83uYkVNWcJ5apZWUwoLvlSPqSeos5vszJ9UnbgvXehtrR4qATIsNd9hjXKyp
	 1h67C1a0WwTM4l8FaVkDl+fvTXckcUpr2QQbnUSbn0SDHdPIfjvYfR4Kms0R/vG+Eng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Prd9F0hv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0D606A333
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Prd9F0hv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB681F000C1;
	Tue,  3 Nov 2026 03:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793677598;
	bh=pwVj5oxfVRTyQKfsqEoLZWoU1i/N5apZIhXRJKLjNU8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Prd9F0hv80kuPuLSC7Ze8taYGS1tDHS8LoSG0yKvJlSj81mJ+AODpUpJBXlrT4Ho2
	 IkYfKKNc+pJ1JfPhLlv7cG5V53AfysDR6RvY01k39vm2gsS2VJYg/htzr0f+I5ptUw
	 YwSCTAueEARsgyG9LKjuBYrf9dclh+Iol+m8SCnpo/LJg6yod9OCACEYF5ZqR+s4j5
	 pnV5Zf5kzYAY3K7KVPEI+iK7/thU4tjNyLpARLLKcx8GXH64v3v446Y2u+2fhG8VYO
	 jl3a4PArPG7w/c+pwbdzssCVnRwG5runcfB1EZHAupvTmXSRjzne2Og3w3z9quZUrK
	 TuHXErvf1lnfA==
Message-ID: <sashiko-outbox-194539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] mm/damon/stat: avoid overflow in
 estimated_memory_bandwidth calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Guangke" <gkwang@linx-info.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261103034034.7978-1-gkwang@linx-info.com>
References: <20261103034034.7978-1-gkwang@linx-info.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 03:46:37 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> estimated_memory_bandwidth is calculated by access_bytes *
> USEC_PER_MSEC * MSEC_PER_SEC (=3D USEC_PER_SEC) / aggr_interval,
> and users read it via
> /sys/module/damon_stat/parameters/estimated_memory_bandwidth.
>=20
> On 32-bit systems, access_bytes * USEC_PER_SEC overflows unsigned
> long once access_bytes exceeds about 4294 (U32_MAX / USEC_PER_SEC),
> so users get a wrong value.
>=20
> Fix it by doing the calculation in 64-bit and splitting the division
> into quotient and remainder.
>=20
> The issue was reproduced on a 32-bit system (qemu-system-i386): the
> parameter estimated_memory_bandwidth reported 362 instead of the
> expected 1926150; with the fix, the value matches the expectation.
>=20
> Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated memor=
y bandwidth")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wang Guangke <gkwang@linx-info.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103034034.7978=
-1-gkwang@linx-info.com?part=3D1

