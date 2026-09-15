Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC3392C2C
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789438287; cv=none; b=pZ2nVtzUD8g0mCTFFmR1hCixTnp2djj9LDUGCOHI6KYC/JIgYSa5O+EaGkBF6zimUvvvLRqeBol+3av1SwGy7d7tSBEYhd5eGPJaZYM3eMe5lFT4ij+sE4RvrvmMdPoRCv9Bt0e07K3wwk0Ac+OFVtTgSQeevgdPzGp+C1/SKyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789438287; c=relaxed/simple;
	bh=gwDcywHvk8rBnSRXuDMkiAFobpzRvnHhBRHDtocveXM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qeiD0mrtDt5RCJEXTOf3c4NpQIcpY2o6Bv3j4HyIS6d17zx3Vrvyq4U6WQWN5ArMhu7A8L91TYYJ5F1BW0hkz+hmpo14QRC3P/u5ozZ4Xb58YAesPSF9HirAt04Lb67s/gO69GLQAp0rqlWVgNfEoIiGZ4SkLpwAKW2pIDQW+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCVpEMri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCVpEMri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D736E1F000FF;
	Tue, 15 Sep 2026 02:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789438286;
	bh=gwDcywHvk8rBnSRXuDMkiAFobpzRvnHhBRHDtocveXM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HCVpEMriSnrykYwpkCDSoJNR+cY+ZCnW6Rr25WQapPmg+flUmL5FsQkl09cNqLACI
	 OswtJjrGJEY85xxoaExek5DHTlbu/uch+XFXNMbICd/jjOm6DHe/t49PEWvuL5o+fe
	 3Wyj8KeNLrD01NDexRImXKyX3s9OdpiMf/czsgchlKqDWM0T2e8JwCT4wiAdJQKmuS
	 xw9DtiZc9R9ddRGgiaAAwf+ALfVqz0agR2uiUygAapNropjKKhr7uVrEMxKTpvKVSg
	 k+NFq+aHPcFbz8Gf9Ul9wrZct06UH+LrkeRXVLw6p79hnbiQz1jAyy5HgmDbhGcS5k
	 z2abES5211n3A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 6/8] Docs/mm/damon/design: update for
 hugepage_size probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260915020929.102953-7-sj@kernel.org>
References: <20260915020929.102953-1-sj@kernel.org>
 <20260915020929.102953-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 02:11:25 +0000
Message-Id: <20260915021125.D736E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added hugepage_size data
> attribute probe filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915020929.1029=
53-1-sj@kernel.org?part=3D6

