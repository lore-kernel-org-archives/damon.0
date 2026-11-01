Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553867;
	b=ER5Aq1V5nbu5qhaXGuqdij7p1PNGtxoz2MnITGuX2btdTjOPMwrp3kttIZvN37OlF4tm
	 hFPpUangJCS24AOCyJoRMA0xKnAYtG8sXfASuV5uxYtl+BN4DauOnkT5N+18G0fySyJg3
	 F3BtP9qqEHlAppkAk7TJ581sThBQnewHEIVWtTDmoD0dFz867ZYNUTci7uukUxeAg202Y
	 p4vAbMVWeFJ6xz/42xnHQ8nQxO3885nW66nCsvLyC8T+Lk61Edt7TwZp9Dt1L4XciQqS5
	 ksWx4tsoh2rKZwLWj1AQNlaidNjF/x9o6KPYCCWBvckIl6TmAGBBvPeK/myEceQ574Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553867;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=147o5fUFXrCNV/qQ89AzwD3Q2RWXIphR1psPINCNBXo=;
	b=uafgkn01LQN9prJZkvS5+cKdL2pYNGDf3vhVHhmxI4ckIDsQHafvryJXi6BaSVm5gKyF
	 cHv9aIWUCHGYlTSzSXy6gbJXox13BFU5mtfPDNamP8q6KVijfSzEcV32HGmsAtBet4dPz
	 33Ue/PTFEIG0hVJmi6mHGXMdA4osk7PlabTfal+KlzccHOGfcNouf57MUjQNSlNigS7mU
	 Fd2LdQ1ALudS81hUhOHcdkuZnhRdyBS3zzVxAB0XS/fYxvu1Bxlel007/DcmAO976o3Ir
	 2Q7cs83HNtWtLcSPmWV/am7RKsGdTlwDI6VKIXtG+50M8i4xXVSO9ZqbrmYh1egwZ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5JOACo4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9F606A324
	for <damon@lists.linux.dev>; Sun,  1 Nov 2026 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5JOACo4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5B11F000C1;
	Sun,  1 Nov 2026 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793553866;
	bh=147o5fUFXrCNV/qQ89AzwD3Q2RWXIphR1psPINCNBXo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g5JOACo4+6b+Jq5uh/Ar61G+OS9b9hg/cQjFW+mUjnTP0qJyhGAgbxu9o0r+UWbTD
	 8rHmk42uPdNPpN8aiv9ju6jTiKG3FpHhQvHNKlWcKoGs5Ht9uGX1KWD+TafwgR8RKD
	 czAAC2dHgJMJqQsz4Gb9uZTPsUPL0Z8dcQoSXYmtXzgVKrynHPYu4qJzJC5XVZ1Nwr
	 XXzAS0pZ+6fHwiKc/IeIwvM9UkGOMubOqWO6lqXoXTne7DG7YVNwoaY9BO4CWGx9yF
	 raslDeLUIJv42JD30LN+HocU6kMlYEsekHDFWZJAcAj5sV+92hfS2yUgi0EEka/f01
	 LTTaL02QnB/Gg==
Message-ID: <sashiko-outbox-192525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/6] mm/damon/sysfs-schemes: drop redundant and
 racy zero target_value check
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261101171630.81477-5-sj@kernel.org>
References: <20261101171630.81477-1-sj@kernel.org>
 <20261101171630.81477-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 17:24:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> DAMON sysfs interface disallowed zero target_value because it could
> result in divide-by-zero in damos_quota_store().  Because similar checks
> were duplicated to other DAMON API callers, a patch series that starts
> with commit 610c4438fb66 ("mm/damon/core: error
> damos_commit_quota_goal() for zero target_value") added a same check in
> the core layer central parameters, and dropped redundant checks in
> DAMON_LRU_SORT and DAMON_SAMPLIE_MTIER.  It forgot to drop that in the
> DAMON sysfs interface.
>=20
> Now the zero target_value check in DAMON sysfs interface is only
> redundant.  Further, it has a time-of-check to time-of-use (toctou) race
> with target_value_store().  It can confuse readers to believe [1] the
> division-by-zero can still happen.  Drop the redundant and racy check.
>=20
> [1] https://lore.kernel.org/20261021005234.94107-1-sj@kernel.org
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101171630.8147=
7-1-sj@kernel.org?part=3D4

