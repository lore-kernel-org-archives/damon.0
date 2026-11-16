Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857739;
	b=hpsWhJTiE1XXwm4xJFqxjytaasEFx3S40XyqGXtrMIIVKVuP78Chdccizh3EZvGNxF9v
	 YB/NfU5GuwoL6Dtc8ljPl7GDnuRw/S2eYYP0tiijm6yqpyw2u+CjYROMzgt7G0+7Lh5JT
	 hnXyGrKKv7YqkxtohdYIehgxcALneUIXGchV3++lMl0ARh3QxvAVhSLc1p58Lbn/FsDqn
	 st2ejkJdduPeRNZyf8Kc2iMtw5RYSlUzbDQLm32GRPC4+kotspocgnbUFCY9+UvVSs8wL
	 Q3X9pvT5buWF3uKtULCV/iGrNuSH66FCPr9RgZi8KqTyvxKcDnDLQ7KJ/E/bcCueB3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857739;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wjJtK2+NBI0fBpYdl60UBYu38EiqqqJvmtlZxRG/Imk=;
	b=ru2xI0hxeJ0Yk6CvFvqXGEs9JZ0M/tCUWB8YQMSv9zTDShoIGHCX/2mqKXukb65ZsEER
	 VZw+Nmqd9YsJgSv22uT503VTxBHA3OZuTz93FaZjsY1Pn52C27AcIdU3s1jotLTj0lk/9
	 wUjaAfj7fcLH/iHBLQMzKXPbXPPmDOYXdPVHX3gRwU97jZrE4YHPY8pAK/HCRW/yXJtya
	 Nlu2RcVfs2hKFIfKgE2+2YEdn6poSQe27m7aAF1deH+2OSJLIkRlZJShhBeGSdP26l2/o
	 ic+HaEhiGogQFAUjmGHuG3yHJPTUJ/MGUnsNjgXEjkn2Usz8hEwFLwJvagtB3ohn0iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWFbNadR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A4606A31C
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kWFbNadR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AA81F000C5;
	Mon, 16 Nov 2026 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794857739;
	bh=wjJtK2+NBI0fBpYdl60UBYu38EiqqqJvmtlZxRG/Imk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kWFbNadRY6UEh0zXMcxid4IzaEkyVS3OXs3uC19bEGlOvVaCSC11MjS9fGHb1/cIm
	 hkS3GCg77fGu564PwxC3jYQuqvjBODOFG3xwM0Z7UcJPHd6qoAf9TOpIutUmNhcEPK
	 DpWEu9zmC/9YT7dx+RQh23Fj5vkzlBV8eGmc04AA6IuaSJ+Z90m3aFF0/yTJYm9ZOr
	 fFr+mi4IWR3CIywcgkv2s8dP9XbFzaWxfBQbSMc2jMTN/tCvblBcHEF5Tk5sO0dVcw
	 zK/TRaOSFL+HLPgqBKbsEBTxPJ5qJM0Pmo1eJJAEWDGKrzTzmorZ54Hfyk4LVbpvmn
	 zvw2013XSqcvQ==
Message-ID: <sashiko-outbox-217576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] Docs/ABI/damon: update for
 sz_ops_filter_passed_last
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattathias Pinchover" <mattathias.pinchover@uber.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261116-damon-sz-ops-b4-v1-6-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
 <20261116-damon-sz-ops-b4-v1-6-1cffe7227e6d@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:35:38 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
>=20
> Update DAMON ABI document for the newly added DAMOS stat file,
> sz_ops_filter_passed_last.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-damon-sz-o=
ps-b4-v1-0-1cffe7227e6d@uber.com?part=3D6

