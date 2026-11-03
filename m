Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667725;
	b=M+oHnKpylPHenPcR44g9Cu/DqtBLDzJCV1yU1cWhruRbqE9FQ1UjKwA2wjqq+vEUJO+6
	 rctY5QE8qOkuFUHVubRi1R87DYLUuzhpGW0YvHms5etc97JuUUd/iNZspsjtXBViOvsKf
	 6gGHnbQdb/odOVV/lzqQ8zFNKEYVVQUyg5KGtU8ysMhYjY9f3Rx9BN0NVv1x9KoYKUZIm
	 sIRhxmMlm7wUtdWrWDnbeW31n0hmYmp+G/SHj6Lfo4Y0qUB4vvD162xmuHSj+Rhk8XTeF
	 zb/BwT1Dl3f5yUe61O8E9LUN3fw6rMMN2FbLtReZRiS+GaNjS+sZTBUyEHLUUI9yxhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667725;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7rOzUwVJF1Frp2wFcuMeLxea/SqqHGfoaKg9PvwVkUM=;
	b=sU4+rKEXKKJ3CC2dOWKFpszjep4h7TlvmKSNecSAKks25usioYS/EBpFzcn8538ePmtr
	 gIMWTLOuufjs8EoyrMmNLC56StuLcqraha3XscvsC9PCMRuWBy9KkkV/FXJdgsdHm9kiR
	 FzRvEQzZ5IiaXRBgYr3NpqfekzknDYc3jq9FSMNj6RocJCsmkAQq3QgTqeDuDRaOxfjIE
	 XhSwrowFG9vM2L+lzrh7XCuMwk022jZyoHjMra3eM7tReNERoiyFrpumGGQbHKs6mVz0d
	 0filrEhEEa+eHyjF8LEO/qlaolJsgunE8Qw6Gdt8HY+sicKC2Mhup5BZjXISt2ELHwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLCkvUyo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA0606A32D
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 01:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aLCkvUyo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264061F000C1;
	Tue,  3 Nov 2026 01:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667725;
	bh=7rOzUwVJF1Frp2wFcuMeLxea/SqqHGfoaKg9PvwVkUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aLCkvUyoH1hANUzWyaon4mryd4gKhF7CXCrG96x4NAmoQvh6H4VxJtrQrSmu8EsWE
	 gJ4H/KcUkKKIQ2BugGwonveW4U6xnoQZR4pPKTe4qdyNG2zLLJuxm4NedCZXWyv7pK
	 TBTm5UedTjF7xXUqYwqOlb0fSJaJHliwG4fKX/tkJcZ+eqKhCp/IBssWxZOZKGxEt2
	 +MPLOFVW+aySYaByBnrZZpuB054Mj9QOMW9DVWDlQtfMHSQQ/Ho0J4PPnaqOLWzEmU
	 3rwfaIlrTxbCuy97EArQ8JMpwLXkWoFQFbpqf7nbKE6AsS6Y3M2F05yORkQbawxzja
	 M5j5HElLtQuWA==
Message-ID: <sashiko-outbox-194415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] Docs/admin-guide/mm/damon/lru_sort: fix
 remaining grammar
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261103005940.91432-5-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
 <20261103005940.91432-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:02:04 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Aveline Noir <jm5905938@gmail.com>
>=20
> Manuel's recent grammar fix for this file, now in damon/next, covered a
> good part of it.  This should take care of the few mistakes that are
> left, like "should automatically activated" and "Make DAMON_LRU_SORT
> reads".  Rewrap where the lines got too long.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103005940.9143=
2-1-sj@kernel.org?part=3D4

