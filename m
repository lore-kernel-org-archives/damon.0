Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968862;
	b=WjSlmlOMFWCRQKqSS4YbOVigUxutxmq0TkZK1o3x2/H4NEMQd889/iG6eMGw5LPPPtkp
	 PPxdUevaddTiGGdM8U86lZoQQjzLDYwD4fy799EgD9/NBczSAlrhDg6MUfkCEVDGO6kTb
	 P7W4W95NFHL2BYYVeW5CVU348gfE8qJ+M58Bdm/M4lmN/N3hzhSiqgwDISSGUoEGFJws+
	 8gGgGige11BUPKmvbqqTNS+XAaG6T2o2nAJM6b3ohbhxtW4tjydkH0rvRaVSe+GK59bbi
	 HihvzzRxrCl1mUE7MJLo8FORjuewbo35xRMqLEAp8p2qBMPNsn6Bk0651COLk8i6y5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968862;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AJGwy+nV0VD9C/ephusHahz9LANsP2eDwgfpNyqAVCo=;
	b=OUZbEpNv7TBOqfI8bfREtNTf1sTJLjChXYq13SS4fCUu8Pt0tOozgX9x3DzhnP2j1/11
	 Je9E0ekIhskM869U3hZq++M6U7KOxBGW6nN/3s4Y40aJxjtZJCkjWYEapiN4ggBv1XyS6
	 3H/b/CaD0pc6rQLSrkjoIDrXazzYU1ZnhtbgasFzDBMu0kpvSgL8pi3HGKMCde57itOWG
	 UGq/QDxUM9N7U4PNgr6ZSx1ugmV8UiQ+EP8Xz/SWKy4befA4l8LRYAkP0qXwktGuz9AUS
	 3oMWwyP/DIFoS6Na6RIUE8W4/DXf2wPlkc3Tym0SYjVM27V4MNV982u6ku4qORRTr0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsCX8USC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7A6606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QsCX8USC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD9C1F000C4;
	Wed, 18 Nov 2026 02:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968862;
	bh=AJGwy+nV0VD9C/ephusHahz9LANsP2eDwgfpNyqAVCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsCX8USCOtmp9SMnqnHgStVI0SYdGQTbt0gjhliiPKqCWfIgaWWHV/iiZrXwQR04O
	 aoR9fxW6j8syhVE5wgA31pvjSWKaN2MGF2Ko2l+Wc5mTSKl9AyhwwtuRx+2S7FaEPP
	 iXXaQTCyOiCni7g0oyjo7D8URCw44s2Rr5LQS+98yAwy1W/37NG82wRdkwiHLec2/M
	 cMpjh6ZSvC/GaSrddlGoamQY6xp2p0GP3J/8Y0ukbVLuYOtU/8Hxz61D/nqd35mOrt
	 RCbTIRCpXAADIFAFrI78wrpuvf6uF/rtkrGC2QYsOYdFw4zTpPHJnv52ElETOBrW89
	 Qe1CSummf8kLg==
Message-ID: <sashiko-outbox-219949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 16/27] mm/damon/sysfs: support REPORT_MADE type
 probe filter setup
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-17-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-17-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:27:42 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Accept user keyword "report_made" to probe filter type file.  Set the
> damon_filter->type as REPORT_MADE for the input.  Setup
> damon_filter->report_type with the filter_report_type user input.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D16

