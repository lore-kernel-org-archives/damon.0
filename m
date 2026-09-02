Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85C64
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353327; cv=none; b=DBUXdMNDhl01ool2EAh8N7lTLOaiyJ3xdZszHwMgzM5N30UrbiyBK5QDDVVAST+bnEaz7CPsPsgIRHqOJ32jYgpKhdjoTKaNyveql5PSR2KjK0MCgDJ9nKB9X7h8z/WfZDvH4nv1+fZari6o5veELZhXTfLiOBAP3U4gF41mF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353327; c=relaxed/simple;
	bh=v1tBIUmRYJlj2ovfr7kZWb1/oDWPZnGZjbu83R95Z60=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=olIkVIp8JBvH5JVP25jXNr9Swf/+k8di2j0osSXYLy1D4DuDC7mtDDkkUmCowdkN94l3+8IDZkU01Vt01iCRSmZ745kPbc0T3jfDRTG0dZKDUDL5ciAHNUjBI4OSwUIe5ZfviVIlMTa15PlSowl8B3pJMbcjAiQ+WujWPR2XkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j69aS+Ch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j69aS+Ch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB361F000E9;
	Wed,  2 Sep 2026 12:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788353326;
	bh=JTvIcXxoxwefuu+aEl5joQ89q376JuhfJKzB4ZZvg4I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j69aS+Ch5ndXRyuzJK9f+6p1NjTVtvOSses0Hs7B3KrK9hP7jU5r1i5ZPbrLhAV1G
	 knXF87qofMFDc8JpjnkX31mRAK2O3pdiE4LQ0N1Zcq/V0RrO72Iba38S59GZSN4nna
	 w7EjaSYqz9xqbhp8XUcdCDoo421KoU9ikn21P6zwl8HZJkboC1UqraJLRj0httaVqH
	 WoUjT4rfv3/KTCWqZsiGXyz7Ab2Xnb0UT73XqIsuWDQKgy3DWXEKWOW1vMic90TJM1
	 5Ew7h9AtdTT4NCOcwjo/CREjg+Ilmqhud8mzVicoRAcc3th4+cOw7KOjeovvSE0+Zy
	 298m6aAY6i7ZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Docs/mm/damon/design: fix broken :ref: usage and a typo
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zenghui Yu" <zenghui.yu@linux.dev>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902124550.31175-1-zenghui.yu@linux.dev>
References: <20260902124550.31175-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 12:48:45 +0000
Message-Id: <20260902124845.DEB361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>=20
> The Statistics section refers readers to the DAMON sysfs interface
> documentation for how to read the statistics, using a ':ref:' role.
> However, the role name has a superfluous 's' appended (':ref:s' instead of
> ':ref:').  Moreover, its target label 'sysfs_stats' does not exist; the
> correct label is 'sysfs_schemes_stats'.  Fix both.
>=20
> Also fix a typo, 'frequenceis' -> 'frequencies', in the Adaptive Regions
> Adjustment section.
>=20
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902124550.3117=
5-1-zenghui.yu@linux.dev?part=3D1

