Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272915;
	b=3J/e/kvAI03iKj7galYuB2ZAPxy2pvAN2MWln48joejgOQYYOaym/huRegabj9lONv2U
	 B0Ddu+KIT+LXv025jg+TYqbk/Cs/CHmsn91RQwwDOk+rqxZBXW/RtozJH0phyIy24G7Un
	 QzpSdrRLnSOsTgBtz5QtsypxmUxIeHn76rvL8+kBo0QikaKQx0E1g97305gjrDxbfq0oB
	 1tnP/wj6y7WnjQkH2AqaW9GnLfmPDKLwvd3eOKy13aUOKJrdS3DU0gntkQscPGsSRwYJH
	 +PI4ljNXGrza8YzY+CyKlMzvhavy2ntI0Ci0EX6Hny7T9+jL9yyStMTEdaqOJdNqYbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vYUSG8+NbtBcKy7q32VjQ+47zzdhYFqtCgaRmwKINGU=;
	b=flW22RP8xj5MuzXBIiUaPIyZTL+J7YpYnv0NtyFVuBRa/LmzUiUDUPI96GMdxcbbMhVd
	 yK7v6//FK3CRaQFzS9QXnHvA0cQzUKnLE53eOIFwCkZhMTxnuo9DTzy7QTMFBh9KjskTf
	 gOXb4VbEb56XWUSTzk5/KxJhOSPax3F1Kh7FKdDyo3IdHgAA6DVK1DzV9/DItrculuF8c
	 /22O+Okej8Ywt541sJ14ttTBuAwZV4xQrK7aIdBI6lyFfd5FZ0CI0KgK2KUC4o7D9Z0pl
	 T4aSZCdhvYoCBDZCYE+4vwSMH0F0Fug0VpRSzA8HnmaZoauat9vY7En6cFYMTYdrTDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuMLp8ZV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAF606A325
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuMLp8ZV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1051F008A1;
	Tue, 10 Nov 2026 01:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272915;
	bh=vYUSG8+NbtBcKy7q32VjQ+47zzdhYFqtCgaRmwKINGU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AuMLp8ZVMRx3D85GcWKYDTiMqj29cRCoL/6u+00AN+vNRbmkAMBkMDuPcqfi5PJTk
	 t9N9z/KmrGxs2BjT88AajMCkLhGZOyaXyzj6JzZK4wDyzhsZeQC4JpDtp8vueJV6Mp
	 mqf9162U8RuBumUnWn+62sfgm3zsZ7PrT4QJH/4TbuK7yaUUDvF1CRe4M54lta9OUG
	 QJsr25CuJw+Nd+N8Sf0DyjfaYzDbOBIDdR7RRm0VKw9uJX6Z3Li8Ki/Pw2oPVHGk0Q
	 953DAV/M0bFDlWX0H0czXFJ4C3oWvnpatXxDvuddc9yfn6piDR6r8I/DIHhIDNheRr
	 s83MHmKjbeMGQ==
Message-ID: <sashiko-outbox-205944@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core: use list_{next,prev}_entry() in
 damon_{next,prev}_region()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261110010558.104905-2-sj@kernel.org>
References: <20261110010558.104905-1-sj@kernel.org>
 <20261110010558.104905-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:08:34 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Enze Li <lienze@kylinos.cn>
>=20
> damon_next_region() and damon_prev_region() manually do container_of()
> type casting to fetch the next and previous region from the linked
> list.  Use the dedicated list.h helpers, list_next_entry() and
> list_prev_entry(), as damon_first_region() and damon_last_region() do.
>=20
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110010558.1049=
05-1-sj@kernel.org?part=3D1

