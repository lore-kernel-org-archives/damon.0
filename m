Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774743;
	b=XTnwMvklWQYl2Hb/2bhzDq57WnQr/mr/2/a7We2OProT2CIFgqHYgx2jqex5grN+3D/J
	 O3fvCabEiYS74v/Gj5LvjIOz2W+zOA8eJ1YKtjOxp9ic+aWCt9iYyO/1UB+KWavmi9BrK
	 W77H6/OABIaOFzfiuxmNMaHlnwOR9JNJ5xm0KoyXFjbH+1ZPv3kkn5QFu4VGa4sSWCK9g
	 LHgynT0SFSUu4KG3dPk+xRqBejMXCHDepD2yhXB+X4Xb/UgZ+XU9oae0SMED3hvw87gO7
	 NJCic0Mu12pgbynoG3W6ARv6fGauxA7MQaAWaAEgG+iQB6oDPGnu/yzCKbHx8VUeyXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774743;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5/Rn559MEqlp1o8YtzbQNmaKwE+KkS/0bJoT8vcE2Xk=;
	b=DDyb23zeljvGqXREJaWX7Cq7G+HFtHuyd/LfEgPzMmyedZI7GCArchwszf5lJBd45dSm
	 zpyEcyq2hMDVEF+boBGNDCm2e9lyZkhvC8QteaC5SFdO7k2hA7IUEmDjcV+eWZScNDNiX
	 7MadnQ04cZjae6dh5ZN3HmJWX9fgbXDOgmStPOpWUBb1P2dY7w/GOd9Di7lJTjkevt+k4
	 IGqEyoyNolSZFhEbUgkKX1Bo7/7RkD0Z6r7neAgsM7zIrfQDz/uWVuwif+CDum2f1EkDf
	 ty9SULUPXxLZEoVFXsNoTn4RMkS1NIZFT5YXlgeQYDRJpdQLvyTRlGHRfUMYmCavVvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZ4myEwY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B6606A323
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZ4myEwY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B708D1F000C4;
	Sun, 15 Nov 2026 20:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774742;
	bh=5/Rn559MEqlp1o8YtzbQNmaKwE+KkS/0bJoT8vcE2Xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EZ4myEwYTF757QW/49IU6Ul7E7jwJDlgW/rMaL/ZYl6uDBT/iFqxxzhpwg0IyBu6E
	 nQMiCiJidB7R88G6B4Ug2N4xnpdnS6vhkR4nlfoCMcMFIfOJua+pFi9NXBCNZlFCMe
	 /vMnfaQyZbk2AOLVn3iWye3veQHmYOp/LQgl9oTuihLSeac6KLKWlWb+Kjzvytzwrk
	 0D40VIaKDIOoVHxZ05Aw5KoCeaSQ9vB7mi4+HiPqhQnkaJpjHHN4q5Fgk3k0ojt5R8
	 YuIHWEn4gTBPrTMqK1G0PXJ3/W+mXuBdzMHn2+rOvut+gx3QwxXdTwoyt33e7JvTy7
	 zhyjbelvZX74w==
Message-ID: <sashiko-outbox-215825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/27] mm/damon/sysfs: add admin/reports/ directory
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-5-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:32:22 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Add a new sysfs directory, reports/, as a place holder for sysfs files
> that will be used for controlling the data attribute report system.  Put
> the directory under the admin/ directory, next to kdamonds/ directory.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D4

