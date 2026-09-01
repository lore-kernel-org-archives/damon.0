Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDAF39150B
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269259; cv=none; b=dkh0hJQb61Do+hb+XxdKIPx5HzbW2GmgdCIl9By8M0CMw4Kduj54s02AxfHTE6risKbuzk42b2B/mYdatmCrFihOZQdGIOkzeJbLTijbHzbTUQLnuSuujoHW06bVgbaXjpjPZKNMLiuS0IXveq2gVg/bg1DxmJbY7Jo+Sr8Vrt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269259; c=relaxed/simple;
	bh=NwefBcGenOOMaCoBYOisLpEce+HFJNliu5ofQHofPoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mEMvgRFtgMf7iXGiFhnHphSDyLMUxId0LTP1qMU0Ge6yLYkLNip4y2ilv3EkWn485YNL/EQroXVeGVPphYboLRmjN/VbnxoQo++6NyouTU30kfPNCpT4YveVgXHkkmzpC3/BkQdJwq1wAROO8XzDSM3Wo0dY/mt9lrDmLin7sRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8C+TzAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8C+TzAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995EC1F000E9;
	Tue,  1 Sep 2026 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269257;
	bh=dWbZ7rwZnLaTPka1CDyRsXro5GGMaqyDLUFO93vL444=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F8C+TzAC4LJPAv0j5vU7kTveIxb/nOuu4kmTp2Wz8iF/1jZ30Cyt3eIBDsH9kuZ0B
	 CvqpqVexD+K83v0UG1wtn0ez8fo88Nw3Iz4AxKXhvx/AOnaLdMndfEdHm3CCrUyaN+
	 lu/Ow8dJxM2sFC+x4k3h/innjMA52dslhL2uh/QSm88xaA+bAXyfD5BzeQbhiRezXS
	 p/VQplPyyhhLR2jvDvsp4M/Zi0a64yK5U20diSa1USDC8uQdSSzhLfVNWqrerVqK1i
	 iKqF2lxwXmBGlqsLNjUG4oOX4NKFtjk4DPLWQiXKwPBH59XrKM1HBhLWd2B40RXY8U
	 pG9AfzwHAxfgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 04/17] Docs/mm/damon/design: document pgidle_unset
 probe filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-5-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:27:37 +0000
Message-Id: <20260901132737.995EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added pgidle_unset probe
> filter type.  Also use a list for the types, as it becomes not very easy
> to read the whole types in a simple sentence.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D4

