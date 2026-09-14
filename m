Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD136D4F1
	for <damon@lists.linux.dev>; Mon, 14 Sep 2026 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397083; cv=none; b=iDpqpOsyPFxmT25hahC67AzmIDAe9VLTsAk00bQTBJYuph/0vJUDVKosgpgmpSp118nQOuiLA+NAnj19Ge1gAWTqr+HDbxPjGi8/aTRKy5aaayh3SFbEU5GiklBRrkNuv93wiJE5BV4X3ZGSgCPhIf9MdXNpzaY01GB7gT9+8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397083; c=relaxed/simple;
	bh=rDX2W5U4EWi444wTdtmrQniFpeZJCZIetJW3MtjVADc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lwJ+VkAjSZtgxR/Iu0efZaodtxqFLXBfnYyNXy868DLRcF0vddNaBfiG2t2e+o9gD2LBO3z1RKqqb30bIXhzOZuI9cn6mAHpaQjvLzz3xgTcjYBLrCSUmjh/XabsEUkFcmhcPDewLBGDwlYti34cV+uMFJuT3ImYdhHLZLuJcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZjaattU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZjaattU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054651F000FF;
	Mon, 14 Sep 2026 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789397082;
	bh=OvVR72wBa9TZny1eLPD8N65WCuigWBN1UDofNfAsrg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IZjaattUTqkmDK/amtzmozzgEK9Knwn+N79wVWPR5d/Af3HpQ6l7xgxv6sH+EgN1h
	 8/VvppHzJLg4PHvoYJmaCaIyug12f6I3/unD1uVeWROiXNdRIXvKAHO2wpvxnPBVBa
	 OQ3bSGU6OzjITMUJ3wUC/tmBWGUnyKZeFJe8KCzVRkVW4h/Gr6NQ3zGD53b0UbwsDh
	 w2PssxiwPMTY2solnlxwygQDGsqZRInO8IHR5F4YACMXCCaqwT84sWvvLwu71HERzy
	 sh5r6sRFAfp7UXL2/RX4dB7Y5XhjF7RhmPmS3SMeJzWJkZddP8ERW5NVT/OHfWqkto
	 MiMS0lUtaPiUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] mm/damon/sysfs-schemes: read
 sysfs_filter->addr_range only once
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260914142327.92510-2-sj@kernel.org>
References: <20260914142327.92510-1-sj@kernel.org>
 <20260914142327.92510-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:44:41 +0000
Message-Id: <20260914144442.054651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface reads the user-provided address range arguments
> for addr type DAMOS filter twice.  Once for validation, and once again
> for assignments to the variable that will be passed to the core
> layer. If the user updates the argument in parallel, an invalid address
> range could be passed to the core layer.  Avoid it by doing the
> assignments first, and then validating the assigned variables before
> passing those to the core layer.
>=20
> User impact of the bug should be trivial.  From the core layer's
> perspective, the invalid address range is not really invalid.  It just
> works as having a weird address range.  No critical issues such as a
> crash or a leak could happen.  And sane users ain't do such parallel
> arguments update anyway.  If they do, such racy behavior is arguably
> somewhat expected and deserved.  That said, there is no reason to keep
> such races.
>=20
> Fixes: 2f1abcfccd86 ("mm/damon/sysfs-schemes: support address range type =
DAMOS filter")
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914142327.9251=
0-1-sj@kernel.org?part=3D1

