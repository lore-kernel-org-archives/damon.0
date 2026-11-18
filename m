Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968907;
	b=tmPtFf7batH8FMWG579f4OF/El/4lQWjlrrtKL0GHJnTHdCWCwD1BSeQB1bkMK3UA4a2
	 fEG+nG53CUwdcAfKa2sfX5c+G7tyuD5jctm8C62tRA7EXXYOnjZDkJby5biIa2lInB/U6
	 qRrS1/17+SPDQH/qFBCxVSSy0ZAMT3CqXDn6OferYc3H+9l3N91iGFPkj41HvCyUXvNH2
	 wg6T6n6c2qe8UjnYzUNHD7fTkKOliQpLViSqq6Mg3JtNe3hvjTUOoFdCwS2JXQT2GCoQV
	 93QZanTwgDVMQVpbWpYsHv1YariIPUVNdv823N9tXZnK9Cb5NK8VbTjMTAzf2xhpm8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cOZQyZc4BQKeif5D0aHOascWCxSAnCg2KoVnj5XYpNo=;
	b=IyFYCOKNs/C7H/S25IJCsaKVjDGyWHEimYW6FbV88o31IgvC4ceiRfdkNvw+Uw+D0iVT
	 IJc1C49Pi4iPgD6ZgfEJdZ+DlTXnbXKCnwulk4mbj6zPqQizCM0UWCEpHhhI9KUIeuctW
	 HZvZdN3aMcEVVs21CogM5ixXU563vGWcEGdeHQURejFOAY+D6XymQo9CC7GD7J+QI5mFV
	 E7ct/rdhs8dQONsm2PPw5pqAikmcFxnGF9eP1gncCejoO8dNhBbGYf9/+x6AJM8hdGOJ7
	 Bt+9RHN0vfMZ8+89gNa0Bh/ck74FTL2KPXgB3rGRyEvdqxMiIEJTTLHecdVcx66YjVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xl7VOBAW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549BD606A32C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xl7VOBAW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE15E1F000CC;
	Wed, 18 Nov 2026 02:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968906;
	bh=cOZQyZc4BQKeif5D0aHOascWCxSAnCg2KoVnj5XYpNo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xl7VOBAWANZhOVFm3ucLcANkjh3zBqXXgGTPPxV1a3A1XoXwS1rmZy67oJFkdGrWh
	 8NNgI8pbcvFWnPdSGsHwR9VQDrpePMXXknuw9E7NpnuOBdsTc42lnco+zzewrrAuVX
	 8C6BRBrRyNDyi/QERzcgd6tU91bE1VR7NCOcI/2aJgrx+Q0Tbp8XqnvXhIjL8md6ge
	 pjh4I2CwSHFOQTClB+HeRQTBDsPfQXgU65GQd9jHnWnI3o+/th5k1VOD796zJGpTET
	 8FkgtOklYzb80M/Zdwh5tMqkmvcTG90gPjI2+vWGHzbD5sx1lYXMZaJ0MIYbnLxE/h
	 XQtmB1h9KlKQQ==
Message-ID: <sashiko-outbox-219952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 18/27] Docs/admin-guide/mm/damon/usage: update
 for REPORT_MADE probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-19-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-19-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:28:26 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON usage document for the newly added REPORT_MADE type probe
> filter support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D18

