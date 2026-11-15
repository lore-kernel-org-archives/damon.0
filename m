Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774984;
	b=wTeYW4DRHyQFAJKVwT1Hr/Hv8SkjscSu42H5rlVbexYQ9ij1KNWXigdf21FDcgVcujP2
	 vSTft/Ov84msZo740g62CcRT52xyg8G+PJ5yE1glspSChMOfECYy3zLdt+01zRDcd8Xre
	 x1UAOqj2sKYzhbr45rCCKAn8gbZk3DOxOd2QLxugSY1oykQZeRsowq5leK8rILv3uTGuz
	 WnyRKnqAhG8i12jptOM2x12XtDZmbbHzGKJTKNDnbSm2pHfu0LT0HzpAP6+9akFG/8ptk
	 h8xwG+y1TPLWEPNgm1DP20u181HaOnfhSfNeF2pj4of17s/0XmVNIH7h81os77YUANg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774984;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jJTz/kGwOrzCxGPPVMCxUpw7HTwjl0QgKtnNxziDyjA=;
	b=oE2HBgjz1CBwDOS1DL+8UBopgrRZsUjNd8saGofP0BsHJcJ4VO1pmpgW49vp1aTBqals
	 19Q/KMd1vGfEW6L9xfyn5zIIQPvKYbMErHFbsjJ9Hp18j9t4yTnXYZb83zPkb6HsuhrIx
	 fuLBKZUKkRA/eoJ7qmunAAvvBWVQJ0I1p9HES+Py3bpbWT+5b/In4MzjYdWHuwR3wVs2u
	 YQtmd/UE6hUQxZPbemLc/shYdBKne2HdDzWy/gDufAFGHzWakCB5tJydEz7hSLFZy7Dgn
	 JCayxtVzOrPe2dyL02Kg5by/krHF1bkIy/ezQnh4Dvpey1SXM7tjBO/+/sAFzNQ5P+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ci/qxbC8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30714606A332
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ci/qxbC8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56CD1F000C4;
	Sun, 15 Nov 2026 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774984;
	bh=jJTz/kGwOrzCxGPPVMCxUpw7HTwjl0QgKtnNxziDyjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ci/qxbC8CNUEPB9aQKmlopGi7kzrqO3PNveWagF3Ma91zGFhnwL2B1j9maz8/kozg
	 iuJlfELSxTH44y+I89n/haH5Xgbxmrg44qsEmEDoujQWcdWQy8L6jqNRogRZJ7NPyy
	 asI/GVUpbjao3tEswOM/r/JKph3D/ukNjgJQ1mUsqhLxEWMSz1dwABJSrrkh0a7w+6
	 1cLp8lBT+vRUPPyJyBQ6P4jxYmf0ErKOmzTBFTGFEsS8Qw0VyzMF3cyyewFpEowqO7
	 Qmk5DO1XmmAAu6GIDdpnYwEoDGP7YAPnC2oh4f1u2qPQ9IkS4nyLAZGKlvVanhuLYZ
	 qcsN0zgoFQ6sw==
Message-ID: <sashiko-outbox-215845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/27] Docs/mm/damon/design: update for report
 system
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-10-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:36:23 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON design for the data attribute report system.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D9

