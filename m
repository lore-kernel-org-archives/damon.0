Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A43D5C3C
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483356; cv=none; b=RK2O3zx9JlAKNvm1LSQxfTrpRPhifh65e9GJ5y1gqUs711UqRdjcmnqa2wnvnOdOwvHNbD1X1zEukBXJWsiUP9xjB8qvWS6WRXcR+Byhw0MQ/nvc1TMMSk3WHYLeCZjqYKa2rkxmqyFwxrMz5XtsfIjVO/tjrhw/uxqCXcFeM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483356; c=relaxed/simple;
	bh=2IT1Hfq5PxQ3v4/DctcH5YVaGXoaKS+zWCWu6bzssv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rv465kUJKrCOdcTYYdr3hxZD92h93w6TA4c45lnzkwXaIlEM6PWPUka0JJVwlR+Il9kTdXr/CXN0s1834R8cVoW+m/ZYrsYp/jnfumi7LBKv/tu3sAYVg7UyxeSL5vVj/vC2DuepSr1jtWir3MeWtFTQAvx6OTdLaQWUsZUvhL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nT3uJ3Jh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nT3uJ3Jh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9911F00898;
	Tue, 15 Sep 2026 14:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789483355;
	bh=pmeYvmIEoqHDL/jeqMh+yExjZay123VA7p9G0+1txPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nT3uJ3JhdhrZPdV0OmiSz9kSMYKtcvekRCGDN2C436k5ftPDNYawcDatEJw0Am751
	 RyGTs4W4CiueDeSJP0+EQF/8pVqERLGUTz3z06TqJOq1CX67Fv4z995NJETdHwoXpG
	 +u1qnr/dd4Tt8Jg19ybsi1eiTFsZEO7N98Y/Jn/j7uoGWqDhyV0H9b/vZ1LvNhxuBV
	 AVaGgWmwzxi65h9AdpJtEOYBdNz+MEHDlrbUdCHlYEbDMxmeu/eG1uLC7Pp6kFXM6K
	 gLfuTZ9OnjZIuWr5cVxKlB0LqvG+6SW06BWgiNDao0m+pkvtT+GSV58hH9Oyq1OE9Y
	 SsPjo/siGRWjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] mm/damon/sysfs: add min,max files under probe
 filter directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915143359.91472-5-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
 <20260915143359.91472-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 14:42:34 +0000
Message-Id: <20260915144235.2D9911F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> In future, DAMON sysfs interface will support data attribute probe
> filter types that have range arguments like the newly added
> hugepage_size type filter.  To prepare such supports, add two new DAMON
> sysfs files, min and max, under the probe filter directory.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915143359.9147=
2-1-sj@kernel.org?part=3D4

