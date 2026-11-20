Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198779;
	b=5NIJFdDOJGEDclhWUsv+wJZf/UbFaRoJb1lwK99Jr+CJd30yDzTFnbf9n/LnMvA/mhK+
	 i6hXehAMk1uFT9GYJJkuz2OpKkxlI3jb9gTaGOPTppMS3R1bxUJAFA37NAlkO59MyPFL0
	 W/bx7fnvscjEtunym6hLrdx7Mn4e7aBN1EKpDuyUqcOSpGJaaVU61biH2MGVVHDGvlNia
	 AdJDmj/+GGMfHZ+vhsft+dEgOzcgfXRHCGS/oRulgQRzbB07ZF7T8fo5h6kBKogsRXWKf
	 rgVJ5bfw25EiFO3WKnftJg9WYS9N2/mSmITgHoEom2wx8nWKVpNy33bvVdXmifc2M0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198779;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lwsyC23ZXmHheOI5J8DIel2Cs9/MLX+PEVVlqZIdUh4=;
	b=0J8RwJOy5de1ZFdOKV7CvSn3OjDSG6A4gxuOQvmOMb4tAU5Y2ZFDmN959YH47yDI/BlI
	 kXeNB6aorDaqXAamg1sQ7d58DamiZsdEufDG3sFyIsm8yiEICHnSTSX7SPKrd+3I04qIW
	 VQLrZxcqFSw+75zbQY4DWd8OnpeFP6mKyY/RjSh+dNzIvr+M52SIQpxD5R+tgqNvuoF7f
	 c6HA0sFqwpQ03zi1Ww8totLYhNveHKXtZvbzMAiwlMYJgH91zhF/xdTUmYYD2CqXzF/mE
	 z6GWAidKB2VLra9lV8T0J8mikr20RswDBp6TzbyMms/og1dPuYEGtdY8C3cxVHliRxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMwcvLIc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B227606A8B4
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMwcvLIc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB7A1F000D2;
	Fri, 20 Nov 2026 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198778;
	bh=lwsyC23ZXmHheOI5J8DIel2Cs9/MLX+PEVVlqZIdUh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eMwcvLIci5+9VITpyseHzlfZIw8fWoBDAlgsJRWZbMOR2s0xZZD1IyJPhcZBnlpS1
	 CovaN0vieuiFL5JqTIQhP3a/5tbHbCUpEDHhNhVsbo5FSQ4nB0xcWuD6NkEFnjEX7d
	 AVrLeJe/aOtP00ZSBgGiiBxhACybbe+ZpKV2x31CQazprDDLUbHnkvwojuwWanoq6n
	 LZLwpslFJqHvFA6dW10BmEf0RX7B8DtqNmfouKIBtfgCbmkHg5JeC2WWcTpIeFxK6E
	 rqVuDSD73NFYu40+ObDumgcfRfJXSdqcUh+YdO8kZh1P9SJUSGUO8ZTeG8PcArID0F
	 Wgb04T86O0/Ug==
Message-ID: <sashiko-outbox-225796@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/60] mm/migrate: reject move_pages() destinations
 outside common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-8-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-8-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:19:38 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> move_pages(2) places user memory on a node the caller picks. As with
> memory policies, the destination should be general purpose memory.
>=20
> Reject a destination outside N_MEMORY_COMMON with -ENODEV, exactly
> the same as a node without memory is rejected today.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D8

